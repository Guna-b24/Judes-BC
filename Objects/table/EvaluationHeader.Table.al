table 71012 "Evaluation Header"
{
    //    No     Date    Sign     Trigger                 Description
    // -----------------------------------------------------------------------------------------------
    //   01     07/10/09 VANDHANA OnInsert()                      Code added for No.series
    //   02     07/10/09 VANDHANA OnValidate()                    Code added for No.series
    //   03     07/10/09 VANDHANA Assistedit()                    Code added for No.series
    //   04     08/10/09 VANDHANA OnInsert()                      Code to get Admission year
    //   05     14/10/09 KATHIR   Evaluation Code - OnValidate()  Code added to check duplicate Entries
    //   06     19/10/09 VANDHANA OnInsert                        Code to assign User ID.
    //   07     23/11/09 VIGNESH  Class - OnValidate()            Code added to get the Class & Curriculum value
    //   08     23/11/09 VIGNESH  Class - OnLookup()              Code added to get the Class & Curriculum value
    //   09     23/11/09 VIGNESH  Curriculum - OnValidate()       Code added to get the Class & Curriculum value
    //   10     23/11/09 VIGNESH  Curriculum - OnLookup()         Code added to get the Class & Curriculum value

    Caption = 'Evaluation Header';
    DrillDownPageID = 71021;
    LookupPageID = 71021;

    fields
    {
        field(1; "Evaluation No."; Code[10])
        {
            Caption = 'Evaluation No.';

            trigger OnValidate()
            begin
                // Start 02 VANDHANA
                if "Evaluation No." <> xRec."Evaluation No." then begin
                    AdmSetup.Get;
                    NoSeriesMgt.TestManual(AdmSetup."Evaluation No.");
                    "No Series" := '';
                end;
                // Stop 02 VANDHANA
            end;
        }
        field(2; Class; Code[10])
        {
            Caption = 'Class';
            TableRelation = "Class Card";

            trigger OnLookup()
            begin
                // Start 08.VIGNESH
                ClassCardLook.LookUpClass(Class, Curriculum, "Academic Year");
                // Stop 08.VIGNESH
            end;

            trigger OnValidate()
            begin
                // Start 07.VIGNESH
                ClassCardLook.ValidateClass(Class, Curriculum, "Academic Year");
                // Stop 07.VIGNESH
            end;
        }
        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            TableRelation = "Class Card".Curriculum;

            trigger OnLookup()
            begin
                // Start 10.VIGNESH
                ClassCardLook.LookUpCurriculum(Class, Curriculum, "Academic Year");
                // Stop 10.VIGNESH
            end;

            trigger OnValidate()
            begin
                // Start 09.VIGNESH
                ClassCardLook.ValidateCurriculum(Class, Curriculum, "Academic Year");
                // Stop 09.VIGNESH
            end;
        }
        field(4; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(5; "Evaluation Code"; Code[10])
        {
            Caption = 'Evaluation Code';
            TableRelation = "Class Evaluation"."Evaluation Method Code" WHERE (Class = FIELD (Class),
                                                                               Curriculum = FIELD (Curriculum),
                                                                               "Academic Year" = FIELD ("Academic Year"));

            trigger OnValidate()
            begin
                // Start 05.KATHIR
                EvaluationHeader.Reset;
                EvaluationHeader.SetCurrentKey(Class, Curriculum, "Academic Year", "Evaluation Code");
                EvaluationHeader.SetRange(Class, Class);
                EvaluationHeader.SetRange(Curriculum, Curriculum);
                EvaluationHeader.SetRange("Academic Year", "Academic Year");
                EvaluationHeader.SetRange("Evaluation Code", "Evaluation Code");
                if EvaluationHeader.FindFirst then
                    Error(Text000);
                // Stop 05.KATHIR
            end;
        }
        field(6; "No Series"; Code[20])
        {
            Caption = 'No Series';
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
    }

    keys
    {
        key(Key1; "Evaluation No.")
        {
            Clustered = true;
        }
        key(Key2; Class, Curriculum, "Academic Year", "Evaluation Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        AppEval: Record "Applicant Evaluation";
    begin
        AppEval.Reset;
        AppEval.SetRange(AppEval."Evaluation No.", "Evaluation No.");
        if AppEval.FindSet then
            AppEval.DeleteAll;
    end;

    trigger OnInsert()
    begin
        // Start 01 VANDHANA
        AdmSetup.Get;
        if "No Series" = '' then begin
            AdmSetup.TestField("Evaluation No.");
            NoSeriesMgt.InitSeries(AdmSetup."Evaluation No.", xRec."No Series", 0D, "Evaluation No.", "No Series");
        end;
        // Stop 01 VANDHANA

        // Start 04 VANDHANA
        "Academic Year" := Eduvertical.GetAdmissionYear;
        // Stop 04 VANDHANA

        // Start 06. VANDHANA
        "User ID" := UserId;
        // Stop 06. VANDHANA
    end;

    var
        AdmSetup: Record "Admission Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EvaluationHeader1: Record "Evaluation Header";
        Eduvertical: Codeunit "Education Vertical";
        EvaluationHeader: Record "Evaluation Header";
        ClassCardLook: Record "Class Card";
        Text000: Label 'Evaluation is already  done for this class.';

    [Scope('Internal')]
    procedure Assistedit(OldEvaluation: Record "Evaluation Header"): Boolean
    begin
        // Start 03 VANDHANA
        with EvaluationHeader1 do begin
            OldEvaluation := Rec;
            AdmSetup.Get;
            AdmSetup.TestField("Evaluation No.");
            if NoSeriesMgt.SelectSeries(AdmSetup."Evaluation No.", OldEvaluation."No Series", "No Series") then begin
                NoSeriesMgt.SetSeries("Evaluation No.");
                Rec := EvaluationHeader1;
                exit(true);
            end;
        end;
        // Stop 03 VANDHANA
    end;
}

