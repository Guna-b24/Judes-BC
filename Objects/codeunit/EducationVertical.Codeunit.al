codeunit 71880 "Education Vertical"
{
    //    No     Date         Sign          Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    //   01     18/09/09     KATHIR      GetAcademicYear()         Function added to get academic year
    //   02     25.09.09     VIGNESH     GetAdmissionYearCOLLEGE() Function Added to get admission Year for College
    //   03     03.10.09     VIGNESH     RankSelection()           Function added to create Rank Generation
    //   04     03/10/09     VIGNESH     GetAdmissionYear()        Function added to get admission year
    //   05     30/12/09       ABK       CloseAdmissionYear()      Function added to close the previous admission year
    //   06     03/10/09       ABK       AssignAdmissionYear()     Function added to assign the current admission year
    //   07     03/10/09       ABK       GetCBCSBatch()            Function added to get the current CBCS Batch


    trigger OnRun()
    begin
    end;

    var
        EduSetup: Record "Education Setup";
        Text001: Label 'Do you want to receive this Application %1?';
        RecApplication: Record Application;
        Academics: Codeunit Academics;
        AcademicsCOLLEGE: Codeunit Codeunit71350;
        Text000: Label 'Academic Year Already Closed';
        Text002: Label 'Academic Year Has Been Assigned';
        Text003: Label 'Do you want to Close the academic Year ?';
        Text004: Label 'Do you want to Assign the academic Year ?';
        Ret: Code[20];

    //[Scope('Internal')]
    procedure GetAcademicYear(): Code[10]
    begin
        // Start 01.Kathir
        EduSetup.GET;
        EduSetup.TESTFIELD("Academic Year");
        EXIT(EduSetup."Academic Year")
        // Stop 01.Kathir
    end;

    // [Scope('Internal')]
    procedure GetAdmissionYear(): Code[10]
    var
        Admission: Record "Admission Setup";
    begin
        // Start 02.Kathir
        Admission.GET();
        Admission.TESTFIELD("Admission Year");
        exit(Admission."Admission Year");
        // Stop 02.Kathir
    end;

    [Scope('Internal')]
    procedure GetAdmissionYearCOLLEGE(): Code[10]
    var
        AdmissionSetup: Record Table71270;
    begin
        // Start 04.VIGNESH
        AdmissionSetup.GET;
        AdmissionSetup.TESTFIELD("Admission Year");
        EXIT(AdmissionSetup."Admission Year");
        // Stop 04.VIGNESH
    end;

    [Scope('Internal')]
    procedure RankGeneration("getFirstNo.": Code[20]; "getLastNo.": Code[20])
    var
        RankGeneration: Record "Rank Generation";
        RankGeneration1: Record "Rank Generation";
        SetRank: Integer;
        Countrank: Integer;
    begin
        // Start 03.VIGNESH
        SetRank := 1;
        RankGeneration.RESET;
        RankGeneration.SETRANGE("Entry No.", "getFirstNo.", "getLastNo.");
        RankGeneration.MODIFYALL(Rank, 0);

        RankGeneration.RESET;
        RankGeneration.SETCURRENTKEY(Average);
        RankGeneration.SETRANGE("Entry No.", "getFirstNo.", "getLastNo.");
        RankGeneration.ASCENDING(FALSE);
        IF RankGeneration.FINDFIRST THEN
            REPEAT
                RankGeneration1.RESET;
                RankGeneration1.SETRANGE("Entry No.", "getFirstNo.", "getLastNo.");
                RankGeneration1.SETRANGE(Average, RankGeneration.Average);
                RankGeneration1.SETRANGE(Rank, 0);
                Countrank := RankGeneration1.COUNT;
                RankGeneration1.MODIFYALL(Rank, SetRank);
                IF Countrank <> 0 THEN
                    SetRank := Countrank + SetRank;
            UNTIL RankGeneration.NEXT = 0;
        // Stop 03.VIGNESH
    end;

    [Scope('Internal')]
    procedure CloseAcademicYear(AcaYear: Code[10])
    var
        AcademicYear: Record "Academic Year";
    begin
        // Start 05.ABK
        IF CONFIRM(Text003) THEN BEGIN
            AcademicYear.GET(AcaYear);
            AcademicYear.Closed := TRUE;
            AcademicYear.MODIFY;
        END;
        // Stop 05.ABK
    end;

    [Scope('Internal')]
    procedure AssignAcademicYear(AcademicCode: Code[20])
    var
        AcademicYear: Record "Academic Year";
        EducationSetup: Record "Education Setup";
    begin
        // Start 06.ABK
        AcademicYear.GET(AcademicCode);
        IF AcademicYear.Closed THEN
            ERROR(Text000);

        IF CONFIRM(Text004) THEN BEGIN
            EducationSetup.GET;
            EducationSetup.TESTFIELD(Company);
            EducationSetup."Academic Year" := AcademicYear.Code;
            EducationSetup."Start Date" := AcademicYear."Start Date";
            EducationSetup."End Date" := AcademicYear."End Date";
            EducationSetup.MODIFY;
            MESSAGE(Text002);
        END;
        // Stop 06.ABK
    end;

    [Scope('Internal')]
    procedure CopyGrades()
    begin
        EduSetup.GET;
        EduSetup.TESTFIELD(Company);
        IF EduSetup.Company = EduSetup.Company::School THEN
            Academics."Copy Grades"
        ELSE
            IF EduSetup.Company = EduSetup.Company::College THEN
                AcademicsCOLLEGE.CopyGrades;
    end;

    [Scope('Internal')]
    procedure GetClassCode(StudentNo: Code[20]; AcademicYear: Code[20]) ret: Code[20]
    var
        PromotionHistory: Record "Promotion History";
    begin
        PromotionHistory.RESET;
        PromotionHistory.SETRANGE(PromotionHistory."Student No.", StudentNo);
        PromotionHistory.SETRANGE(PromotionHistory."Academic Year", AcademicYear);
        IF PromotionHistory.FINDFIRST THEN
            EXIT(PromotionHistory."Class Code");
    end;
}

