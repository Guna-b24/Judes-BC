codeunit 71001 Evaluation
{
    trigger OnRun()
    begin
    end;

    var
        Application: Record Application;
        ApplicantEvaluation: Record "Applicant Evaluation";
        EvaluationHead: Record "Evaluation Header";
        ClassEvaluation: Record "Class Evaluation";
        Application1: Record Application;
        SelectionProcessLine: Record "Selection Process Line";
        ApplicantEvaluation1: Record "Applicant Evaluation";
        ClassEvaluation1: Record "Class Evaluation";
        EducationVertical: Codeunit "Education Vertical";
        StartNo: Code[10];
        EndNo: Code[10];
        Text000: Label 'Total Weight-Age should be 100 for class %1 and for curriculam %2';
        Text001: Label 'Class Evaluation does not EXIST';
        Text002: Label 'Evaluation %1 is not calculated for Class %2 and Curriculum %3';
        Text003: Label 'Selection Updated sucessfully';
        Total: Decimal;


    procedure GetApplicants(EvaluationNo: Code[10])
    var
        TotalWeightage: Decimal;
    begin
        TotalWeightage := 0;
        EvaluationHead.Get(EvaluationNo);
        EvaluationHead.TestField(Class);
        EvaluationHead.TestField(Curriculum);
        EvaluationHead.TestField("Academic Year");
        EvaluationHead.TestField("Evaluation Code");

        ClassEvaluation1.Reset();
        ClassEvaluation1.SetRange(Class, EvaluationHead.Class);
        ClassEvaluation1.SetRange(Curriculum, EvaluationHead.Curriculum);
        ClassEvaluation1.SetRange("Academic Year", EvaluationHead."Academic Year");
        if ClassEvaluation1.FindSet() then
            repeat
                TotalWeightage += ClassEvaluation1.Weightage;
            until ClassEvaluation1.Next() = 0;
        if TotalWeightage <> 100 then
            Error(Text000, EvaluationHead.Class, EvaluationHead.Curriculum);

        ClassEvaluation.Reset();
        ClassEvaluation.SetRange(Class, EvaluationHead.Class);
        ClassEvaluation.SetRange(Curriculum, EvaluationHead.Curriculum);
        ClassEvaluation.SetRange("Academic Year", EvaluationHead."Academic Year");
        ClassEvaluation.SetRange("Evaluation Method Code", EvaluationHead."Evaluation Code");
        if ClassEvaluation.IsEmpty then
            Error(Text001)
        else
            if ClassEvaluation.FindFirst() then;
        Application.Reset();
        Application.SetCurrentKey(Class, "Curriculum Intrested", "Academic Year");
        Application.SetRange(Class, EvaluationHead.Class);
        Application.SetRange("Curriculum Intrested", EvaluationHead.Curriculum);
        Application.SetRange("Academic Year", EvaluationHead."Academic Year");
        Application.SetRange("Application Status", Application."Application Status"::Received);
        if Application.FindSet() then
            repeat

                ApplicantEvaluation1.Reset();
                ApplicantEvaluation1.SetRange("Application No.", Application."No.");
                ApplicantEvaluation1.SetRange("Evaluation Method Code", EvaluationHead."Evaluation Code");
                ApplicantEvaluation1.SetRange(ApplicantEvaluation1.Class, EvaluationHead.Class);
                if ApplicantEvaluation1.IsEmpty then begin

                    ApplicantEvaluation."Application No." := Application."No.";
                    ApplicantEvaluation."Evaluation Method Code" := EvaluationHead."Evaluation Code";
                    ApplicantEvaluation."Maximum Mark" := ClassEvaluation."Maximum Mark";
                    ApplicantEvaluation."Pass Mark" := ClassEvaluation."Pass Mark";
                    ApplicantEvaluation.Weightage := ClassEvaluation.Weightage;
                    ApplicantEvaluation."Applicant Name" := Application."Name of the pupil";
                    ApplicantEvaluation."Evaluation No." := EvaluationNo;
                    ApplicantEvaluation.Class := Application.Class;
                    if ClassEvaluation."Prequalification Mark" then
                        "Prequalification Marks"(ApplicantEvaluation);
                    ApplicantEvaluation.Insert();
                end;

            until Application.Next() = 0;

    end;


    procedure "Selection Process"("SelectionNo.": Code[20]): Decimal
    var
        SelectionProcess: Record "Selection process";
    begin

        if SelectionProcess.Get("SelectionNo.") then begin
            SelectionProcess.TestField(Class);
            SelectionProcess.TestField(Curriculum);
            SelectionProcess.TestField("Academic Year");

            ClassEvaluation.Reset();
            ClassEvaluation.SetRange(Class, SelectionProcess.Class);
            ClassEvaluation.SetRange(Curriculum, SelectionProcess.Curriculum);
            ClassEvaluation.SetRange("Academic Year", SelectionProcess."Academic Year");
            if ClassEvaluation.FindSet() then
                repeat
                    EvaluationHead.Reset();
                    EvaluationHead.SetCurrentKey(Class, Curriculum, "Academic Year", "Evaluation Code");
                    EvaluationHead.SetRange(Class, SelectionProcess.Class);
                    EvaluationHead.SetRange(Curriculum, SelectionProcess.Curriculum);
                    EvaluationHead.SetRange("Academic Year", SelectionProcess."Academic Year");
                    EvaluationHead.SetRange("Evaluation Code", ClassEvaluation."Evaluation Method Code");
                    if EvaluationHead.FindFirst() then begin
                        ApplicantEvaluation.Reset();
                        ApplicantEvaluation.SetCurrentKey("Evaluation No.");
                        ApplicantEvaluation.SetRange("Evaluation No.", EvaluationHead."Evaluation No.");
                        if ApplicantEvaluation.IsEmpty then
                            Error(Text002, ClassEvaluation."Evaluation Method Code", SelectionProcess.Class, SelectionProcess.Curriculum);
                    end else
                        Error(Text002, ClassEvaluation."Evaluation Method Code", SelectionProcess.Class, SelectionProcess.Curriculum);
                until ClassEvaluation.Next() = 0;

            Application.Reset();
            Application.SetRange(Class, SelectionProcess.Class);
            Application.SetRange("Curriculum Intrested", SelectionProcess.Curriculum);
            Application.SetRange("Academic Year", SelectionProcess."Academic Year");
            Application.SetRange("Application Status", Application."Application Status"::Received);


            if Application.FindSet() then
                repeat
                    SelectionProcessLine."Evaluation Total" := CalcTotal(Application."No.");
                    SelectionProcessLine."Selection No." := "SelectionNo.";
                    SelectionProcessLine."Application No" := Application."No.";
                    SelectionProcessLine.Name := Application."Name of the pupil";
                    SelectionProcessLine.Gender := Application."Applicant Gender";
                    SelectionProcessLine.Insert();
                until Application.Next() = 0;

            SelectionProcessLine.Reset();
            SelectionProcessLine.SetRange("Selection No.", "SelectionNo.");
            if SelectionProcessLine.FindSet() then;
            //CalcRank(SelectionProcessLine);
        end;

    end;


    procedure CalcTotal("ApplicationNo.": Code[10]): Decimal
    begin

        Clear(Total);
        ApplicantEvaluation.Reset();
        ApplicantEvaluation.SetRange("Application No.", "ApplicationNo.");
        if ApplicantEvaluation.FindSet() then
            repeat
                if (ApplicantEvaluation."Mark Obtained" = 0) and
                  (ApplicantEvaluation."Maximum Mark" = 0) then
                    Total := Total + 0
                else
                    Total := Total + ((ApplicantEvaluation."Mark Obtained" / ApplicantEvaluation."Maximum Mark" * 100)
                    * (ApplicantEvaluation.Weightage / 100));
            until ApplicantEvaluation.Next() = 0;
        exit(Total);
    end;


    // procedure CalcRank( SelectionProcessLine: Record "Selection Process Line")
    // var
    //     Ranking: Record "Rank Generation";
    // begin        
    //     if SelectionProcessLine.FindSet then
    //         repeat
    //             Ranking."No." := SelectionProcessLine."Application No";
    //             Ranking.Average := SelectionProcessLine."Evaluation Total";
    //             Ranking.Insert(true);
    //         until SelectionProcessLine.Next = 0;

    //     if SelectionProcessLine.FindSet then
    //         if Ranking.Get(SelectionProcessLine."Application No") then
    //             StartNo := Ranking."Entry No.";

    //     if SelectionProcessLine.FindLast then
    //         if Ranking.Get(SelectionProcessLine."Application No") then
    //             EndNo := Ranking."Entry No.";

    //     EducationVertical.RankGeneration(StartNo, EndNo);

    //     if SelectionProcessLine.FindSet then
    //         repeat
    //             Ranking.SetRange("No.", SelectionProcessLine."Application No");
    //             if Ranking.FindFirst then begin
    //                 SelectionProcessLine.Rank := Ranking.Rank;
    //                 SelectionProcessLine.Modify;
    //             end;
    //         until SelectionProcessLine.Next = 0;
    //     Ranking.Reset;
    //     Ranking.SetRange("Entry No.", StartNo, EndNo);
    //     if Ranking.FindSet then
    //         Ranking.DeleteAll;
    //     // Stop 04.GUNA
    // end;


    procedure UpdateStatus(SelectionNo: Code[20])
    begin

        SelectionProcessLine.Reset();
        SelectionProcessLine.SetRange("Selection No.", SelectionNo);
        if SelectionProcessLine.FindSet() then
            repeat
                if Application1.Get(SelectionProcessLine."Application No") then begin
                    Application1."Application Status" := Application1."Application Status"::Received;
                    if SelectionProcessLine.Select then begin
                        Application1."Selection Number" := SelectionProcessLine."Selection No.";
                        Application1."Evaluation Total" := SelectionProcessLine."Evaluation Total";
                        Application1.Rank := SelectionProcessLine.Rank;
                        Application1."Application Status" := Application1."Application Status"::Selected;
                    end;
                    Application1.Modify();
                end;
            until SelectionProcessLine.Next() = 0;
        Message(Text003);
    end;


    procedure "Prequalification Marks"(varApplicantEvaluation: Record "Applicant Evaluation")
    var
        ApplicationMark: Record "Application Mark";
        ObtainedMarks: Decimal;
        TotalMarks: Decimal;
    begin

        Clear(TotalMarks);
        ApplicationMark.Reset();
        ApplicationMark.SetRange("Application No", varApplicantEvaluation."Application No.");
        if ApplicationMark.FindSet() then
            repeat
                ObtainedMarks := ObtainedMarks + ApplicationMark."Mark Obtained";
                TotalMarks := TotalMarks + ApplicationMark.Maximum;
            until ApplicationMark.Next() = 0;

        varApplicantEvaluation."Maximum Mark" := TotalMarks;
        varApplicantEvaluation."Mark Obtained" := ObtainedMarks;

    end;
}

