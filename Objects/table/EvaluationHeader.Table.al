table 71012 "Evaluation Header"
{
    Caption = 'Evaluation Header';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71021;
    // LookupPageID = 71021;

    fields
    {
        field(1; "Evaluation No."; Code[20])
        {
            Caption = 'Evaluation No.';
            ToolTip = 'Specifies the unique number assigned to the evaluation.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Evaluation No." <> xRec."Evaluation No." then begin
                    AdmSetup.Get();
                    NoSeriesMgt.TestManual(AdmSetup."Evaluation No.");
                    "No Series" := '';
                end;
            end;
        }
        field(2; Class; Code[10])
        {
            Caption = 'Class';
            TableRelation = "Class Card";
            ToolTip = 'Specifies the class for which the evaluation is created.';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin

                ClassCardLook.LookUpClass(Class, Curriculum, "Academic Year");

            end;

            trigger OnValidate()
            begin

                ClassCardLook.ValidateClass(Class, Curriculum, "Academic Year");

            end;
        }
        field(3; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            TableRelation = "Class Card".Curriculum;
            ToolTip = 'Specifies the curriculum applicable to the selected class.';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin

                ClassCardLook.LookUpCurriculum(Class, Curriculum, "Academic Year");

            end;

            trigger OnValidate()
            begin

                ClassCardLook.ValidateCurriculum(Class, Curriculum, "Academic Year");

            end;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            ToolTip = 'Specifies the academic year for the evaluation.';
            DataClassification = CustomerContent;
        }
        field(5; "Evaluation Code"; Code[10])
        {
            Caption = 'Evaluation Code';
            TableRelation = "Class Evaluation"."Evaluation Method Code" WHERE(Class = FIELD(Class),
                                                                               Curriculum = FIELD(Curriculum),
                                                                               "Academic Year" = FIELD("Academic Year"));

            trigger OnValidate()
            begin
                EvaluationHeader.Reset();
                EvaluationHeader.SetCurrentKey(Class, Curriculum, "Academic Year", "Evaluation Code");
                EvaluationHeader.SetRange(Class, Class);
                EvaluationHeader.SetRange(Curriculum, Curriculum);
                EvaluationHeader.SetRange("Academic Year", "Academic Year");
                EvaluationHeader.SetRange("Evaluation Code", "Evaluation Code");
                if EvaluationHeader.FindFirst() then
                    Error(Text000);
            end;
        }
        field(6; "No Series"; Code[20])
        {
            Caption = 'No Series';
            DataClassification = SystemMetadata;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = SystemMetadata;
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
        AppEval.Reset();
        AppEval.SetRange(AppEval."Evaluation No.", "Evaluation No.");
        if AppEval.FindSet() then
            AppEval.DeleteAll();
    end;

    trigger OnInsert()
    begin

        if "Evaluation No." = '' then begin
            AdmSetup.Get();
            AdmSetup.TestField("Evaluation No.");
            "No Series" := AdmSetup."Evaluation No.";
            "Evaluation No." := NoSeriesMgt.GetNextNo("No Series");

        end;

        "Academic Year" := Eduvertical.GetAdmissionYear();
    end;

    var
        AdmSetup: Record "Admission Setup";
        EvaluationHeader1: Record "Evaluation Header";
        EvaluationHeader: Record "Evaluation Header";
        ClassCardLook: Record "Class Card";
        Eduvertical: Codeunit "Education Vertical";
        NoSeriesMgt: Codeunit "No. Series";
        Text000: Label 'Evaluation is already  done for this class.';

    procedure Assistedit(OldEvaluation: Record "Evaluation Header"): Boolean
    begin

        OldEvaluation := Rec;
        AdmSetup.Get();
        AdmSetup.TestField("Evaluation No.");
        if NoSeriesMgt.LookupRelatedNoSeries(AdmSetup."Evaluation No.", OldEvaluation."No Series", "No Series") then begin
            OldEvaluation."Evaluation No." := NoSeriesMgt.GetNextNo(OldEvaluation."No Series");
            Rec := EvaluationHeader1;
            exit(true);
        end;
    end;

}

