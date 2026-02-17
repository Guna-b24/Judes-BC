codeunit 71880 "Education Vertical"
{
    trigger OnRun()
    begin
    end;

    var
        EduSetup: Record "Education Setup";
        Academics: Codeunit Academics;
        Text000: Label 'Academic Year Already Closed';
        Text002: Label 'Academic Year Has Been Assigned';
        Text003: Label 'Do you want to Close the academic Year ?';
        Text004: Label 'Do you want to Assign the academic Year ?';
        Text001: Label 'Do you want to receive this Application %1?';



    procedure GetAcademicYear(): Code[10]
    begin

        EduSetup.GET();
        EduSetup.TESTFIELD("Academic Year");
        EXIT(EduSetup."Academic Year")

    end;


    procedure GetAdmissionYear(): Code[10]
    var
        Admission: Record "Admission Setup";
    begin

        Admission.GET();
        Admission.TESTFIELD("Admission Year");
        exit(Admission."Admission Year");

    end;


    // procedure GetAdmissionYearCOLLEGE(): Code[10]
    // var
    //     AdmissionSetup: Record Table71270;
    // begin

    //     AdmissionSetup.GET;
    //     AdmissionSetup.TESTFIELD("Admission Year");
    //     EXIT(AdmissionSetup."Admission Year");

    // end;


    // procedure RankGeneration("getFirstNo.": Code[20]; "getLastNo.": Code[20])
    // var
    //     RankGeneration: Record "Rank Generation";
    //     RankGeneration1: Record "Rank Generation";
    //     SetRank: Integer;
    //     Countrank: Integer;
    // begin
    //     SetRank := 1;
    //     RankGeneration.RESET;
    //     RankGeneration.SETRANGE("Entry No.", "getFirstNo.", "getLastNo.");
    //     RankGeneration.MODIFYALL(Rank, 0);

    //     RankGeneration.RESET;
    //     RankGeneration.SETCURRENTKEY(Average);
    //     RankGeneration.SETRANGE("Entry No.", "getFirstNo.", "getLastNo.");
    //     RankGeneration.ASCENDING(FALSE);
    //     IF RankGeneration.FINDFIRST THEN
    //         REPEAT
    //             RankGeneration1.RESET;
    //             RankGeneration1.SETRANGE("Entry No.", "getFirstNo.", "getLastNo.");
    //             RankGeneration1.SETRANGE(Average, RankGeneration.Average);
    //             RankGeneration1.SETRANGE(Rank, 0);
    //             Countrank := RankGeneration1.COUNT;
    //             RankGeneration1.MODIFYALL(Rank, SetRank);
    //             IF Countrank <> 0 THEN
    //                 SetRank := Countrank + SetRank;
    //         UNTIL RankGeneration.NEXT = 0;

    // end;


    procedure CloseAcademicYear(AcaYear: Code[10])
    var
        AcademicYear: Record "Academic Year";
    begin
        IF CONFIRM(Text003) THEN BEGIN
            AcademicYear.GET(AcaYear);
            AcademicYear.Closed := TRUE;
            AcademicYear.MODIFY();
        END;
    end;


    procedure AssignAcademicYear(AcademicCode: Code[20])
    var
        AcademicYear: Record "Academic Year";
        EducationSetup: Record "Education Setup";
    begin
        AcademicYear.GET(AcademicCode);
        IF AcademicYear.Closed THEN
            ERROR(Text000);

        IF CONFIRM(Text004) THEN BEGIN
            EducationSetup.GET();
            EducationSetup.TESTFIELD(Company);
            EducationSetup."Academic Year" := AcademicYear.Code;
            EducationSetup."Start Date" := AcademicYear."Start Date";
            EducationSetup."End Date" := AcademicYear."End Date";
            EducationSetup.MODIFY();
            MESSAGE(Text002);
        END;
    end;


    procedure CopyGrades()
    begin
        EduSetup.GET();
        EduSetup.TESTFIELD(Company);
        IF EduSetup.Company = EduSetup.Company::School THEN
            Academics."Copy Grades"();
        // ELSE
        //     IF EduSetup.Company = EduSetup.Company::College THEN
        //        AcademicsCOLLEGE.CopyGrades;
    end;


    procedure GetClassCode(StudentNo: Code[20]; AcademicYear: Code[20]) ret: Code[20]
    var
        PromotionHistory: Record "Promotion History";
    begin
        PromotionHistory.RESET();
        PromotionHistory.SETRANGE(PromotionHistory."Student No.", StudentNo);
        PromotionHistory.SETRANGE(PromotionHistory."Academic Year", AcademicYear);
        IF PromotionHistory.FINDFIRST() THEN
            EXIT(PromotionHistory."Class Code");
    end;
}

