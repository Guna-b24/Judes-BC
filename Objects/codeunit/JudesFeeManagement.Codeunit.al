codeunit 71046 "Judes Fee Management"
{

    trigger OnRun()
    begin
    end;

    [Scope('Internal')]
    procedure ProcessFee(AppNo: Code[20]; StudNo: Code[20])
    var
        RollStr: Code[10];
        CustRec: Record Customer;
        RollNo: Code[10];
        RegRec: Record Table50000;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        RunSeries: Code[10];
        "StateNo.": Dialog;
        StateStr: Text[30];
        FeesStructure: Record "Fee Structure";
        SalesHeadRec: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Clas: Integer;
        Bool: Boolean;
        "Doc No": Code[20];
        Cnt: Integer;
        CompRec: Record Company;
        PostInv: Report "Batch Post Sales Invoices";
        GenSetup: Record "General Ledger Setup";
        GenJlRec: Record "Gen. Journal Line";
        GnlJnlPost: Codeunit "Gen. Jnl.-Check Line";
        varint: Integer;
        "Print Admission": Report Report50069;
        AppRec: Record Application;
        AdmSetupRec: Record "Admission Setup";
        FeeSetupRec: Record "Fee Setup";
        EduSetup: Record "Education Setup";
        RecStudentSubject: Record "Application Optional Subjects";
        InsertValue: Boolean;
        Flag: Boolean;
    begin
        IF AppRec.GET(AppNo) THEN BEGIN
            RollNo := StudNo;
            FeeSetupRec.GET;
            Bool := EVALUATE(Clas, AppRec.Class);
            IF AppRec."Staff Child" THEN BEGIN
                FeeSetupRec.GET;
                FeesStructure.RESET;
                FeesStructure.SETRANGE(FeesStructure."Academic Year", AppRec."Academic Year");
                FeesStructure.SETFILTER(FeesStructure."From Class", '<=%1', Clas);
                FeesStructure.SETFILTER(FeesStructure."To Class", '>=%1', Clas);
                FeesStructure.SETFILTER(FeesStructure."Type Of Fees", '%1|%2|%3', FeesStructure."Type Of Fees"::Initial,
                          FeesStructure."Type Of Fees"::Term1, FeesStructure."Type Of Fees"::Term2);
                FeesStructure.SETRANGE(FeesStructure."Staff Child", TRUE);
                FeesStructure.SETRANGE(FeesStructure.Company, 'St Jude''s Stores');
                "Doc No" := NoSeriesMgmt.GetNextNo(FeeSetupRec."Fee Number", 0D, TRUE);
                IF FeesStructure.FIND('-') THEN BEGIN
                    REPEAT
                        GenJlRec.CHANGECOMPANY('St Jude''s Stores');
                        GenJlRec.SETRANGE(GenJlRec."Journal Template Name", FeeSetupRec."Journal Template Name");
                        GenJlRec.SETRANGE(GenJlRec."Journal Batch Name", FeeSetupRec."Journal Batch Name");
                        IF GenJlRec.FIND('+') THEN;
                        Cnt := Cnt + 1;
                        GenJlRec.INIT;
                        GenJlRec."Journal Template Name" := FeeSetupRec."Journal Template Name";
                        GenJlRec."Journal Batch Name" := FeeSetupRec."Journal Batch Name";
                        GenJlRec."Line No." := GenJlRec."Line No." + 10000;
                        GenJlRec."Account Type" := GenJlRec."Account Type"::Customer;
                        GenJlRec.VALIDATE(GenJlRec."Account No.", RollNo);
                        GenJlRec.VALIDATE(GenJlRec."Bal. Account No.", FeesStructure."G/L Account");
                        GenJlRec."Document Type" := GenJlRec."Document Type"::Invoice;
                        GenJlRec.Description := FeesStructure."Fee Description";
                        GenJlRec."Type of Fees" := FeesStructure."Type Of Fees";
                        // GenJlRec."Posting Date":=WORKDATE;
                        IF EduSetup.FINDFIRST THEN
                            IF EduSetup."Admission Posting Date" <> 0D THEN
                                GenJlRec."Posting Date" := EduSetup."Admission Posting Date"
                            ELSE
                                GenJlRec."Posting Date" := WORKDATE;
                        GenJlRec."Document No." := "Doc No" + '/' + FORMAT(Cnt);
                        GenJlRec.VALIDATE(GenJlRec.Amount, FeesStructure.Amount);
                        GenJlRec.Description := FeesStructure."Fee Description";
                        GenJlRec.INSERT(TRUE);
                    UNTIL FeesStructure.NEXT = 0;
                    //   CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJlRec);
                    //  MESSAGE('Student No %1 Has been Alloted & Invoiced',"Roll No.");
                END
                ELSE
                    ERROR('There is No Fees Structure defined for this class');
            END
            ELSE BEGIN

                GenSetup.GET;
                FeesStructure.RESET;
                FeesStructure.SETRANGE(FeesStructure."Academic Year", AppRec."Academic Year");
                FeesStructure.SETFILTER(FeesStructure."From Class", '<=%1', Clas);
                FeesStructure.SETFILTER(FeesStructure."To Class", '>=%1', Clas);
                FeesStructure.SETFILTER(FeesStructure."Type Of Fees", '%1|%2|%3', FeesStructure."Type Of Fees"::Initial,
                          FeesStructure."Type Of Fees"::Term1, FeesStructure."Type Of Fees"::Term2);
                IF NOT AppRec."Thai Student" THEN
                    FeesStructure.SETRANGE(FeesStructure.Thai, FALSE);
                FeesStructure.SETRANGE(FeesStructure.Company, COMPANYNAME);
                "Doc No" := NoSeriesMgmt.GetNextNo(FeeSetupRec."Fee Number", 0D, TRUE);
                IF FeesStructure.FIND('-') THEN BEGIN

                    IF FeesStructure.Company = COMPANYNAME THEN BEGIN
                        EVALUATE(varint, AppRec.Class);
                        IF (varint >= 11) THEN BEGIN
                            IF AppRec.Group <> AppRec.Group::" " THEN BEGIN
                                CASE AppRec.Group OF


                                    AppRec.Group::"Group A":
                                        BEGIN
                                            FeesStructure.SETFILTER(FeesStructure.Group, '<>%1&<>%2&<>%3&<>%4', FeesStructure.Group::
         "Group B",
                                            FeesStructure.Group::"Group C", FeesStructure.Group::"Group D", FeesStructure.Group::"Group E");
                                        END;

                                    AppRec.Group::"Group B":
                                        FeesStructure.SETFILTER(FeesStructure.Group, '<>%1&<>%2&<>%3&<>%4',
                                  FeesStructure.Group::"Group A",
                                  FeesStructure.Group::"Group C", FeesStructure.Group::"Group D", FeesStructure.Group::"Group E");
                                    AppRec.Group::"Group C":
                                        FeesStructure.SETFILTER(FeesStructure.Group, '<>%1&<>%2&<>%3&<>%4',
                                  FeesStructure.Group::"Group B",
                                  FeesStructure.Group::"Group A", FeesStructure.Group::"Group D", FeesStructure.Group::"Group E");
                                    AppRec.Group::"Group D":
                                        FeesStructure.SETFILTER(FeesStructure.Group, '<>%1&<>%2&<>%3&<>%4',
                                  FeesStructure.Group::"Group A",
                                  FeesStructure.Group::"Group C", FeesStructure.Group::"Group B", FeesStructure.Group::"Group E");
                                    AppRec.Group::"5":
                                        FeesStructure.SETFILTER(FeesStructure.Group, '<>%1&<>%2&<>%3&<>%4',
                                        FeesStructure.Group::"Group A",
                                        FeesStructure.Group::"Group C", FeesStructure.Group::"Group B", FeesStructure.Group::"Group D");

                                END;

                            END ELSE
                                ERROR('Group is not allotted for the Student');
                        END;
                    END;

                    GenJlRec.SETRANGE(GenJlRec."Journal Template Name", FeeSetupRec."Journal Template Name");
                    GenJlRec.SETRANGE(GenJlRec."Journal Batch Name", FeeSetupRec."Journal Batch Name");
                    IF GenJlRec.FIND('+') THEN;
                    REPEAT
                        InsertValue := TRUE; // vignesh
                        Cnt := Cnt + 1;
                        GenJlRec.INIT;
                        GenJlRec."Journal Template Name" := FeeSetupRec."Journal Template Name";
                        GenJlRec."Journal Batch Name" := FeeSetupRec."Journal Batch Name";
                        GenJlRec."Line No." := GenJlRec."Line No." + 10000;
                        GenJlRec."Account Type" := GenJlRec."Account Type"::Customer;
                        GenJlRec.VALIDATE(GenJlRec."Account No.", RollNo);
                        GenJlRec.VALIDATE(GenJlRec."Bal. Account No.", FeesStructure."G/L Account");
                        GenJlRec.Description := FeesStructure."Fee Description";
                        GenJlRec."Type of Fees" := FeesStructure."Type Of Fees";
                        //      GenJlRec."Posting Date":=WORKDATE;
                        IF EduSetup.FINDFIRST THEN
                            IF EduSetup."Admission Posting Date" <> 0D THEN
                                GenJlRec."Posting Date" := EduSetup."Admission Posting Date"
                            ELSE
                                GenJlRec."Posting Date" := WORKDATE;

                        GenJlRec."Document Type" := GenJlRec."Document Type"::Invoice;
                        GenJlRec."Document No." := "Doc No" + '/' + FORMAT(Cnt);
                        GenJlRec.VALIDATE(GenJlRec.Amount, FeesStructure.Amount);
                        // Vignesh Start
                        IF FeesStructure."Group Subject" <> '' THEN BEGIN
                            Flag := TRUE;
                            RecStudentSubject.RESET;
                            RecStudentSubject.SETRANGE(RecStudentSubject."Application No", AppRec."No.");
                            IF RecStudentSubject.FINDFIRST THEN BEGIN
                                REPEAT
                                    IF Flag THEN BEGIN
                                        IF RecStudentSubject.Subject = FeesStructure."Group Subject" THEN BEGIN
                                            InsertValue := TRUE;
                                            Flag := FALSE;
                                        END ELSE
                                            InsertValue := FALSE;
                                    END;
                                UNTIL RecStudentSubject.NEXT = 0
                            END ELSE BEGIN
                                InsertValue := FALSE;
                            END
                        END;
                        // Vignesh End
                        IF InsertValue THEN BEGIN
                            GenJlRec.INSERT(TRUE);
                        END;
                    UNTIL FeesStructure.NEXT = 0;
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJlRec);
                END
                ELSE
                    ERROR('There is No Fees Structure defined for this class');

                // Code to enter the values for the students into general journal for diff companies

                CompRec.RESET;
                CompRec.SETFILTER(CompRec.Name, '<>%1', COMPANYNAME);
                // IF NOT AppRec."Hostel Acommodation" THEN
                //   CompRec.SETFILTER(CompRec.Name,'<>%1|<>%2',COMPANYNAME,'St Jude''s Hostel');
                IF CompRec.FINDSET THEN
                    REPEAT
                        IF (NOT ((NOT AppRec."Hostel Acommodation")
                          AND (CompRec.Name = 'St Jude''s Hostel'))) THEN BEGIN
                            //vignesh
                            GenJlRec.CHANGECOMPANY(CompRec.Name);
                            GenJlRec.SETRANGE(GenJlRec."Journal Template Name", FeeSetupRec."Journal Template Name");
                            GenJlRec.SETRANGE(GenJlRec."Journal Batch Name", FeeSetupRec."Journal Batch Name");
                            IF GenJlRec.FIND('+') THEN;
                            FeesStructure.RESET;
                            FeesStructure.SETRANGE(FeesStructure."Academic Year", AppRec."Academic Year");
                            FeesStructure.SETFILTER(FeesStructure."From Class", '<=%1', Clas);
                            FeesStructure.SETFILTER(FeesStructure."To Class", '>=%1', Clas);
                            FeesStructure.SETFILTER(FeesStructure."Type Of Fees", '%1|%2|%3', FeesStructure."Type Of Fees"::Initial,
                                      FeesStructure."Type Of Fees"::Term1, FeesStructure."Type Of Fees"::Term2);
                            // Code Added by GUNA

                            FeesStructure.SETFILTER(FeesStructure.Company, CompRec.Name);
                            IF CompRec.Name = 'St Jude''s Computer Academy' THEN BEGIN
                                EVALUATE(varint, AppRec.Class);
                                IF (varint >= 11) THEN BEGIN
                                    IF AppRec.Group <> AppRec.Group::" " THEN BEGIN
                                        CASE AppRec.Group OF


                                            AppRec.Group::"Group A":
                                                BEGIN
                                                    FeesStructure.SETFILTER(FeesStructure.Group, '<>%1&<>%2&<>%3&<>%4', FeesStructure.Group::
                 "Group B",
                                                    FeesStructure.Group::"Group C", FeesStructure.Group::"Group D", FeesStructure.Group::"Group E");
                                                END;

                                            AppRec.Group::"Group B":
                                                FeesStructure.SETFILTER(FeesStructure.Group, '<>%1&<>%2&<>%3&<>%4',
                      FeesStructure.Group::"Group A",
                                              FeesStructure.Group::"Group C", FeesStructure.Group::"Group D", FeesStructure.Group::"Group E");
                                            AppRec.Group::"Group C":
                                                FeesStructure.SETFILTER(FeesStructure.Group, '<>%1&<>%2&<>%3&<>%4',
                      FeesStructure.Group::"Group B",
                                              FeesStructure.Group::"Group A", FeesStructure.Group::"Group D", FeesStructure.Group::"Group E");
                                            AppRec.Group::"Group D":
                                                FeesStructure.SETFILTER(FeesStructure.Group, '<>%1&<>%2&<>%3&<>%4',
                      FeesStructure.Group::"Group A",
                                              FeesStructure.Group::"Group C", FeesStructure.Group::"Group B", FeesStructure.Group::"Group E");
                                            AppRec.Group::"5":
                                                FeesStructure.SETFILTER(FeesStructure.Group, '<>%1&<>%2&<>%3&<>%4',
                            FeesStructure.Group::"Group A",
                                                    FeesStructure.Group::"Group C", FeesStructure.Group::"Group B", FeesStructure.Group::"Group D");

                                        END;
                                    END;
                                END;
                            END;

                            //FeesStructur.SETRANGE(FeesStructur."Type Of Fees",Tm+1);
                            //FeesStructure.SETFILTER(FeesStructure.Company,CompRec.Name);
                            IF FeesStructure.FINDSET THEN
                                REPEAT
                                    Cnt := Cnt + 1;
                                    GenJlRec.INIT;
                                    GenJlRec."Journal Template Name" := FeeSetupRec."Journal Template Name";
                                    GenJlRec."Journal Batch Name" := FeeSetupRec."Journal Batch Name";
                                    GenJlRec."Line No." := GenJlRec."Line No." + 10000;
                                    GenJlRec."Account Type" := GenJlRec."Account Type"::Customer;
                                    GenJlRec.VALIDATE(GenJlRec."Account No.", RollNo);
                                    GenJlRec.VALIDATE(GenJlRec."Bal. Account No.", FeesStructure."G/L Account");
                                    GenJlRec."Type of Fees" := FeesStructure."Type Of Fees";
                                    GenJlRec.Description := FeesStructure."Fee Description";
                                    //      GenJlRec."Posting Date":=WORKDATE;
                                    IF EduSetup.FINDFIRST THEN
                                        IF EduSetup."Admission Posting Date" <> 0D THEN
                                            GenJlRec."Posting Date" := EduSetup."Admission Posting Date"
                                        ELSE
                                            GenJlRec."Posting Date" := WORKDATE;

                                    GenJlRec."Document Type" := GenJlRec."Document Type"::Invoice;
                                    GenJlRec."Document No." := "Doc No" + '/' + FORMAT(Cnt);
                                    GenJlRec.VALIDATE(GenJlRec.Amount, FeesStructure.Amount);
                                    GenJlRec.INSERT(TRUE);
                                UNTIL FeesStructure.NEXT = 0

                            //vignesh
                        END;
                        //vignesh

                    UNTIL CompRec.NEXT = 0;
                //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJlRec);
            END;

            MESSAGE('Student No %1 Has been Alloted & Invoiced', RollNo);
            MESSAGE('Please open Other companies to invoice the Student');
            // FSSH01
        END;
        // Latest
    end;

    [Scope('Internal')]
    procedure PostPayment(var Rec: Record "Gen. Journal Line")
    var
        PostBatch: Codeunit "Gen. Jnl.-Post Batch";
        DocNo: Code[20];
        StudNo: Code[20];
        AllocRec: Record Allocation;
    begin
        DocNo := Rec."Document No.";
        //StudNo:=Rec."Account No.";
        PostBatch.RUN(Rec);
        AllocRec.RESET;

        AllocRec.SETRANGE(AllocRec."Document No", DocNo);
        //AllocRec.SETRANGE(AllocRec."Student No.",StudNo);
        IF AllocRec.FINDSET THEN
            REPORT.RUN(50025, FALSE, FALSE, AllocRec);
    end;
}

