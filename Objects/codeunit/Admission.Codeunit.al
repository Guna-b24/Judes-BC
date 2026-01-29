codeunit 71000 Admission
{
    //    No     Date       Sign     Trigger                     Description
    // ------------------------------------------------------------------------------------------------------------------------------
    //   01     22/09/09   KATHIR   Application Received()       Function created for updating the Application status
    //                                                              from Sold to received
    //   02     22/09/09   KATHIR   Sales Application Journal()  Function Created to Create Journal for application sales
    //   03     22/09/09   KATHIR   Update receipt ()            Function added to generate registration Cost
    //   04     24/09/09   KATHIR   AllotStudentNo ()            Code added to Insert Student from application
    //   05     24/09/09   KATHIR   AllotStudentNo ()            Code added to Insert student in to Customer
    //   06     24/09/09   KATHIR   AllotStudentNo ()            Code added to Generate Initial Fees for the student
    //   08     26/09/09   KATHIR   Check Age Limit()            Code added to check age limit of the applicant while admission
    //   09     29/09/09   KATHIR   Check Subject Group()        Code added to check the Subject Group in application
    //   10     29/09/09   KATHIR   Update Optional Subject()    Code added to Update Optional subjects to Student
    //   11     03/10/09   VIGNESH  CheckApplicationDate()       Code added to validate the application Date
    //   12     03/10/09   VIGNESH  CheckRegistrationDate()      Code added to validate the Registration Date
    //   13     16/11/09   VIGNESH  CheckCertificate             Code added to validadte certificate befor alloting the roll no.
    //   14     17/11/09   VIGNESH  AllotStudentNo ()            Code modified to validate the Certificatie & Capacity
    //   15     24/11/09   VIGNESH  SpotAdmitChangeStatus()      Code added to Change the Applciation Status ti allocate roll no


    trigger OnRun()
    begin
    end;

    var
        RecStudent: Integer;
        Text000: Label 'Journal already created';
        Text001: Label 'Sales completed.';
        Text002: Label 'Registration completed.';
        Text003: Label 'Student capacity for the class %1';
        Text004: Label 'Please submit all the certificates.';
        Text005: Label 'Subject group needs to be captured for this application.';
        Text006: Label 'Subject needs to be filled in for the group.';
        Text007: Label 'Sale of Application closed.';
        Text008: Label 'Registration closed.';
        Text009: Label 'Student Capacity for the Class %1, Curriculam %2 exceedes';
        Text010: Label 'Reason Should not be Empty for Free Prospectus';

    [Scope('Internal')]
    procedure "Application Journal"("ApplnNo.": Code[20]; Process: Option Sales,Registration)
    var
        "No.SeriesLine": Record "No. Series Line";
        "TempDocNo.": Code[20];
        Application: Record Application;
        AdmissionSetup: Record "Admission Setup";
        GenJnlLine: Record "Gen. Journal Line";
        "No.seriesManagement": Codeunit NoSeriesManagement;
        PaymentMethod: Record "Payment Method";
        Enquiry: Record Enquiry;
        TxtBalAccType: Text[30];
    begin
        // Start 02.KATHIR
        AdmissionSetup.GET;
        AdmissionSetup.TESTFIELD("Journal Template Name");
        Application.GET("ApplnNo.");
        Application.TESTFIELD(Class);
        Application.TESTFIELD("Curriculum Intrested");
        Application.TESTFIELD("Academic Year");
        Application.TESTFIELD("Date of Birth");
        CLEAR("TempDocNo.");

        IF (Application."Free Prospectus" = TRUE) AND
          (Application.Reason = '') THEN
            ERROR(Text010);

        IF Process = Process::Sales THEN BEGIN
            IF (NOT (Application."Free Prospectus") AND
              (Application."Application Status" = 0))
            THEN BEGIN
                PaymentMethod.GET(Application."Mode of Payment");
                PaymentMethod.TESTFIELD("Bal. Account No.");
            END;
        END;

        IF Process = Process::Registration THEN BEGIN
            PaymentMethod.GET(Application."Mode of Payment");
            PaymentMethod.TESTFIELD("Bal. Account No.");
        END;

        IF Process = Process::Sales THEN BEGIN
            IF (Application."Application Status" = Application."Application Status"::Sold) OR
               (Application."Application Status" = Application."Application Status"::Received)
            THEN
                ERROR(Text000);
            AdmissionSetup.TESTFIELD("Application Sales Batch Name");
            AdmissionSetup.TESTFIELD("Application Sales Posting No.");
            "TempDocNo." := "No.seriesManagement".GetNextNo(AdmissionSetup."Application Sales Posting No.", 0D, FALSE);

        END;

        IF Process = Process::Registration THEN BEGIN
            IF Application."Application Status" = Application."Application Status"::Received THEN
                ERROR(Text000);
            AdmissionSetup.TESTFIELD("Registration Batch Name");
            AdmissionSetup.TESTFIELD("Registration Posting No.");
            "TempDocNo." := "No.seriesManagement".GetNextNo(AdmissionSetup."Registration Posting No.", 0D, FALSE);
        END;

        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", AdmissionSetup."Journal Template Name");
        IF Process = Process::Sales THEN
            GenJnlLine.SETRANGE("Journal Batch Name", AdmissionSetup."Application Sales Batch Name")
        ELSE
            IF Process = Process::Registration THEN
                GenJnlLine.SETRANGE("Journal Batch Name", AdmissionSetup."Registration Batch Name");

        IF GenJnlLine.FINDLAST THEN
            GenJnlLine."Line No." := GenJnlLine."Line No." + 10000
        ELSE
            GenJnlLine."Line No." := 10000;

        IF Process = Process::Sales THEN BEGIN
            GenJnlLine."Journal Batch Name" := AdmissionSetup."Application Sales Batch Name";
            GenJnlLine."Posting Date" := Application."Date of Sale";
            GenJnlLine."Credit Amount" := Application."Application Cost";
            GenJnlLine."Cheque No." := Application."Cheque / DD No.";
            GenJnlLine."Cheque Date" := Application."Cheque / DD Date";
        END;

        IF Process = Process::Registration THEN BEGIN
            GenJnlLine."Journal Batch Name" := AdmissionSetup."Registration Batch Name";
            GenJnlLine."Posting Date" := Application."Date of Receive";
            GenJnlLine."Credit Amount" := Application."Registration Cost";
            GenJnlLine."Cheque No." := Application."Reg DD / Cheque No";
            GenJnlLine."Cheque Date" := Application."Reg DD / Cheque Date";
        END;

        GenJnlLine.VALIDATE("Credit Amount");

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";

        IF Process = Process::Sales THEN
            GenJnlLine."Account No." := AdmissionSetup."Application Cost Account No.";

        IF Process = Process::Registration THEN
            GenJnlLine."Account No." := AdmissionSetup."Registration Cost Account No.";

        GenJnlLine.VALIDATE("Account No.");
        GenJnlLine."Journal Template Name" := AdmissionSetup."Journal Template Name";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := "TempDocNo.";

        IF PaymentMethod."Bal. Account Type" = 0 THEN
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";

        IF PaymentMethod."Bal. Account Type" = 1 THEN
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";

        GenJnlLine."Bal. Account No." := PaymentMethod."Bal. Account No.";
        GenJnlLine.VALIDATE("Credit Amount");
        GenJnlLine.Description := Application."No.";
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT(TRUE);

        GenJnlLine.RESET;
        GenJnlLine.SETRANGE("Journal Template Name", AdmissionSetup."Journal Template Name");

        IF Process = Process::Sales THEN
            GenJnlLine.SETRANGE("Journal Batch Name", AdmissionSetup."Application Sales Batch Name");
        IF Process = Process::Registration THEN
            GenJnlLine.SETRANGE("Journal Batch Name", AdmissionSetup."Registration Batch Name");


        GenJnlLine.SETRANGE("Document No.", "TempDocNo.");
        IF GenJnlLine.FINDSET THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnlLine);

        IF Process = Process::Sales THEN BEGIN
            Application."Application Status" := Application."Application Status"::Sold;
            IF Enquiry.GET(Application."Enquiry No.") THEN BEGIN
                Enquiry."Enquiry Closed" := TRUE;
                Enquiry.MODIFY;
            END;

        END ELSE
            IF Process = Process::Registration THEN BEGIN
                Application."Application Status" := Application."Application Status"::Received;
                Application."Hostel Acommodation" := TRUE;
            END;

        Application.MODIFY;

        IF Process = Process::Sales THEN
            MESSAGE(Text001)
        ELSE
            IF Process = Process::Registration THEN
                MESSAGE(Text002);
        // Stop 02.KATHIR
    end;

    [Scope('Internal')]
    procedure "Update Receipt"("ApplNo.": Code[20])
    var
        Application: Record Application;
        AdmissionSetup: Record "Admission Setup";
        Process: Option Sales,Registration;
    begin
        //Start 03.KATHIR
        Application.GET("ApplNo.");
        AdmissionSetup.GET;

        IF AdmissionSetup."Registration Cost Needed" THEN BEGIN
            IF Application."Date of Receive" = 0D THEN
                Application."Date of Receive" := TODAY;
            Application.MODIFY;
            "Application Journal"("ApplNo.", Process::Registration);
        END ELSE BEGIN
            IF Application."Date of Receive" = 0D THEN
                Application."Date of Receive" := TODAY;
            Application."Application Status" := Application."Application Status"::Received;
            Application.MODIFY;
            MESSAGE(Text002);
        END;
        //Stop 03.KATHIR
    end;

    [Scope('Internal')]
    procedure AllotStudentNo(ApplNo: Code[20])
    var
        Application: Record Application;
        Admission: Record "Admission Setup";
        StudentNo: Code[20];
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        RollNo: Code[20];
        Student: Record Student;
        Customer: Record Customer;
        TEXT0001: Label 'Roll No. %1 Generated for this application ';
        TEXT0002: Label 'Already Converted as Student';
        FeeGeneration: Report Report71067;
        InitialFeeSetup: Record "Initial Fee Setup";
        CombineCode: Text[50];
        IntCount: Integer;
        ShiptoAddress: Record "Ship-to Address";
        ClassCard: Record "Class Card";
        ClassSection: Record "Class Section";
        SetSection: Code[10];
        Student1: Record Student;
        SkipBool: Boolean;
        JudesFeeMang: Codeunit "Judes Fee Management";
    begin
        // Start 04.KATHIR
        Application.GET(ApplNo);
        IF Application."Application Status" = Application."Application Status"::Admitted THEN
            ERROR(TEXT0002);

        /*
        IntCount := 0;
        InitialFeeSetup.RESET;
        IF InitialFeeSetup.FINDSET THEN
          REPEAT
            IntCount += 1;
            CombineCode += InitialFeeSetup."Fee Type Code";
            IF IntCount <> InitialFeeSetup.COUNT THEN
              CombineCode += '|';
          UNTIL InitialFeeSetup.NEXT = 0;
        */

        Application.TESTFIELD("Application Status", Application."Application Status"::Selected);
        Application.TESTFIELD(Class);
        Application.TESTFIELD("Academic Year");
        Application.TESTFIELD("Curriculum Intrested");

        Admission.GET;
        Admission.TESTFIELD("Student No.");
        Admission.TESTFIELD("Gen. Bus. Posting Group");
        Admission.TESTFIELD("Customer Posting Group");

        // Start 14.VIGNESH
        ClassSection.RESET;
        ClassSection.SETCURRENTKEY(Class, Curriculum, "Academic Year");
        ClassSection.SETRANGE(Class, Application.Class);
        ClassSection.SETRANGE(Curriculum, Application."Curriculum Intrested");
        ClassSection.SETRANGE("Academic Year", Application."Academic Year");
        ClassSection.CALCSUMS(Capacity);

        Student1.RESET;
        Student1.SETCURRENTKEY(Class, Curriculum, "Academic Year");
        Student1.SETRANGE(Class, Application.Class);
        Student1.SETRANGE(Curriculum, Application."Curriculum Intrested");
        Student1.SETRANGE("Academic Year", Application."Academic Year");
        Student1.SETRANGE("Student Status", Student1."Student Status"::Student);
        IF Student1.COUNT >= ClassSection.Capacity THEN
            ERROR(Text009, Application.Class, Application."Curriculum Intrested");
        SkipBool := FALSE;

        IF ClassSection.FINDSET THEN
            REPEAT
                IF ClassSection."Present Strength" < ClassSection.Capacity THEN BEGIN
                    SetSection := ClassSection.Section;
                    SkipBool := TRUE;
                END;
            UNTIL (ClassSection.NEXT = 0) OR SkipBool;

        IF NOT SkipBool THEN
            ERROR(Text003, Application.Class, Application."Curriculum Intrested");
        IF NOT CheckCertificate(ApplNo) THEN
            ERROR(Text004);


        // Stop 14.VIGNESH
        StudentNo := NoSeriesMgmt.GetNextNo(Admission."Student No.", 0D, TRUE);
        Student.INIT;
        Student.TRANSFERFIELDS(Application);
        Student."No." := StudentNo;
        Student."Application No." := ApplNo;
        Student.VALIDATE("Date Of Birth");
        Student."Date Joined" := TODAY;
        Student."New Student" := TRUE;
        Student.Section := SetSection;
        Student."Class Code" := Student.Class + '-' + Student.Section + '-' + Student.Curriculum + '-' + Student."Academic Year";
        Student."Student Status" := Student."Student Status"::Student;
        Student.INSERT;

        "Update Optional Subjects"(ApplNo, StudentNo);

        // Stop 04.KATHIR
        // Start 05.KATHIR
        Customer."No." := StudentNo;
        Customer.VALIDATE(Name, COPYSTR(Application."Name of the pupil", 1, 50));
        Customer.Address := COPYSTR(Application.Address1, 1, 50);
        Customer."Address 2" := COPYSTR(Application.Address2, 1, 50);
        Customer.City := Application.City;
        Customer."Phone No." := Application."Phone Number";
        Customer.County := Application.Country;
        Customer."E-Mail" := Application."E-Mail Address";
        Customer.VALIDATE("Gen. Bus. Posting Group", Admission."Gen. Bus. Posting Group");
        Customer.VALIDATE("Customer Posting Group", Admission."Customer Posting Group");
        Customer.INSERT(TRUE);
        Application."Application Status" := Application."Application Status"::Admitted;
        Application."Student No." := StudentNo;
        Application.MODIFY;
        // Stop 05.KATHIR
        // Start 06.KATHIR


        JudesFeeMang.ProcessFee(ApplNo, StudentNo);

        /*
        Student1.RESET;
        Student1.SETFILTER("No.",StudentNo);
        FeeGeneration.SetFeeType(CombineCode);
        FeeGeneration.USEREQUESTFORM(FALSE);
        FeeGeneration.SETTABLEVIEW(Student1);
        FeeGeneration.RUN;
        MESSAGE(TEXT0001,StudentNo);
        // Stop 06.KATHIR
         */

    end;

    [Scope('Internal')]
    procedure "Check Age Limit"(Class: Code[10]; Curriculum: Code[10]; AcadYr: Code[10]; Age: Integer): Boolean
    var
        ClassCard: Record "Class Card";
    begin
        // Start 07.KATHIR
        ClassCard.RESET;
        ClassCard.SETCURRENTKEY(Class, Curriculum, "Academic Year");
        ClassCard.SETRANGE(Class, Class);
        ClassCard.SETRANGE(Curriculum, Curriculum);
        ClassCard.SETRANGE("Academic Year", AcadYr);
        IF ClassCard.FINDFIRST THEN BEGIN
            IF (ClassCard."Miniimum Age Limit" <> 0) AND (ClassCard."Maximum Age Limit" <> 0) THEN BEGIN
                IF (ClassCard."Miniimum Age Limit" >= Age) AND (ClassCard."Maximum Age Limit" <= Age) THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END ELSE
                EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
        //Stop 07.KATHIR
    end;

    [Scope('Internal')]
    procedure "Update Optional Subjects"(ApplnNo: Code[20]; StudentNo: Code[20])
    var
        ApplicationOptionalSubject: Record "Application Optional Subjects";
        Application: Record Application;
        StudentOptionalSubject: Record "Student Optional Subjects";
    begin
        // Start 10.KATHIR
        ApplicationOptionalSubject.SETRANGE("Application No", ApplnNo);
        IF ApplicationOptionalSubject.FINDSET THEN
            REPEAT
                StudentOptionalSubject."Student No" := StudentNo;
                StudentOptionalSubject."Subject Group" := ApplicationOptionalSubject."Subject Group";
                StudentOptionalSubject.Subject := ApplicationOptionalSubject.Subject;
                StudentOptionalSubject.Description := ApplicationOptionalSubject.Description;
                StudentOptionalSubject.INSERT;
            UNTIL ApplicationOptionalSubject.NEXT = 0;
        // Stop 10.KATHIR
    end;

    [Scope('Internal')]
    procedure CheckApplicationDate(GetClass: Code[20]; GetCurriculum: Code[20]; GetYear: Code[10]): Boolean
    var
        ClassCard: Record "Class Card";
        AdmissionSetup: Record "Admission Setup";
    begin
        // Start 11.VIGNESH
        AdmissionSetup.GET;
        IF AdmissionSetup."Application Sale Method" = AdmissionSetup."Application Sale Method"::Common THEN BEGIN
            IF (AdmissionSetup."Application Sales From" <> 0D) AND (AdmissionSetup."Application Sales To" <> 0D) THEN
                IF (AdmissionSetup."Application Sales From" <= TODAY) AND
                   (AdmissionSetup."Application Sales To" >= TODAY)
                THEN
                    EXIT(TRUE)
                ELSE BEGIN
                    ERROR(Text007);
                    EXIT(FALSE);
                END;
        END ELSE
            IF AdmissionSetup."Application Sale Method" = AdmissionSetup."Application Sale Method"::Classwise THEN BEGIN
                ClassCard.RESET;
                ClassCard.SETCURRENTKEY(Class, Curriculum);
                ClassCard.SETRANGE(Class, GetClass);
                ClassCard.SETRANGE(Curriculum, GetCurriculum);
                //ClassCard.SETRANGE("Academic Year",GetYear);
                IF ClassCard.FINDFIRST THEN BEGIN
                    IF (ClassCard."Application Sale From" <> 0D) AND (ClassCard."Application Sale Till" <> 0D) THEN BEGIN
                        IF (ClassCard."Application Sale From" <= TODAY) AND (ClassCard."Application Sale Till" >= TODAY) THEN
                            EXIT(TRUE)
                        ELSE BEGIN
                            MESSAGE(Text007);
                            EXIT(FALSE);
                        END;
                    END ELSE
                        EXIT(TRUE);
                END ELSE
                    EXIT(TRUE);
            END ELSE
                EXIT(TRUE);
        // Stop 11.VIGNESH
    end;

    [Scope('Internal')]
    procedure CheckRegistrationDate(GetClass: Code[20]; GetCurriculum: Code[20]; GetYear: Code[10]): Boolean
    var
        ClassCard: Record "Class Card";
    begin
        // Start 12.VIGNESH
        ClassCard.RESET;
        ClassCard.SETCURRENTKEY(Class, Curriculum);
        ClassCard.SETRANGE(Class, GetClass);
        ClassCard.SETRANGE(Curriculum, GetCurriculum);
        ClassCard.SETRANGE("Academic Year", GetYear);
        IF ClassCard.FINDFIRST THEN BEGIN
            IF (ClassCard."Application Receive From" <> 0D) AND (ClassCard."Application Receive Till" <> 0D) THEN BEGIN
                IF (ClassCard."Application Receive From" <= TODAY) AND (ClassCard."Application Receive Till" >= TODAY) THEN
                    EXIT(TRUE)
                ELSE BEGIN
                    MESSAGE(Text008);
                    EXIT(FALSE);
                END;
            END ELSE
                EXIT(TRUE);
        END ELSE
            EXIT(TRUE);
        // Stop 12.VIGNESH
    end;

    [Scope('Internal')]
    procedure CheckCertificate("GetAppNo.": Code[20]): Boolean
    var
        ApplicationCertificate: Record "Application Certificate";
    begin
        // Start 13.VIGNESH
        ApplicationCertificate.RESET;
        ApplicationCertificate.SETRANGE("Application No.", "GetAppNo.");
        IF ApplicationCertificate.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
        // Stop 13.VIGNESH
    end;

    [Scope('Internal')]
    procedure SpotAdmitChangeStatus("GetApplNo.": Code[20])
    var
        Application: Record Application;
    begin
        // Start 15.VIGNESH
        Application.GET("GetApplNo.");
        Application."Application Status" := Application."Application Status"::Selected;
        Application.MODIFY;
        AllotStudentNo("GetApplNo.");
        // Stop 15.VIGNESH
    end;
}

