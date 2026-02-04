table 71008 "Class Evaluation"
{
    Caption = 'Class Evaluation';
    // DrillDownPageID = 71016;
    // LookupPageID = 71016;

    fields
    {
        field(1; Class; Code[10])
        {
            Caption = 'Class';
            TableRelation = Class;
            ToolTip = 'Specifies the class to which the evaluation applies.';
            DataClassification = CustomerContent;
        }
        field(2; "Evaluation Method Code"; Code[20])
        {
            Caption = 'Evaluation Method Code';
            TableRelation = "Evaluation Method";
            ToolTip = 'Specifies the evaluation method used for the class.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Evaluation.Get("Evaluation Method Code");
                "Prequalification Mark" := Evaluation."Prequalification Mark";
            end;
        }
        field(3; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies the maximum marks for the evaluation.';
            DataClassification = CustomerContent;
        }
        field(4; "Pass Mark"; Decimal)
        {
            Caption = 'Pass Mark';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies the minimum marks required to pass.';
            DataClassification = CustomerContent;
        }

        field(5; Compulsory; Boolean)
        {
            Caption = 'Compulsory';
            ToolTip = 'Specifies whether the evaluation is compulsory.';
            DataClassification = CustomerContent;
        }
        field(6; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
            ToolTip = 'Specifies the curriculum applicable to the class.';
            DataClassification = CustomerContent;
        }
        field(7; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            ToolTip = 'Specifies the academic year.';
            DataClassification = CustomerContent;
        }
        field(8; Weightage; Decimal)
        {
            Caption = 'Weightage';
            ToolTip = 'Specifies the weightage percentage for the evaluation.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ClassEvaluation.Reset();
                ClassEvaluation.SetRange(Class, Class);
                ClassEvaluation.SetRange(Curriculum, Curriculum);
                ClassEvaluation.SetRange("Academic Year", "Academic Year");
                if ClassEvaluation.FindSet() then
                    repeat
                        WeigAge += ClassEvaluation.Weightage;
                    until ClassEvaluation.Next() = 0;

                if (WeigAge + Weightage - xRec.Weightage) > 100 then
                    Error(Text000);
            end;
        }
        field(9; "Prequalification Mark"; Boolean)
        {
            Caption = 'Prequalification Mark';
            Editable = false;
            ToolTip = 'Indicates whether the evaluation is a prequalification mark.';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference ID.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Class, Curriculum, "Evaluation Method Code", "Academic Year")
        {
            Clustered = true;
        }
        key(Key2; Class, Compulsory)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        "Evaluation Header".Reset();
        "Evaluation Header".SetRange("Evaluation Header".Class, Class);
        "Evaluation Header".SetRange("Evaluation Header".Curriculum, Curriculum);
        "Evaluation Header".SetRange("Evaluation Header"."Academic Year", "Academic Year");
        "Evaluation Header".SetRange("Evaluation Header"."Evaluation Code", "Evaluation Method Code");
        if "Evaluation Header".FindFirst() then
            Error('Please Delete Evaluation Mark Frist');
    end;

    trigger OnInsert()
    begin

    end;

    var
        // EduVert: Codeunit "Education Vertical";       
        ClassEvaluation: Record "Class Evaluation";
        Evaluation: Record "Evaluation Method";
        "Evaluation Header": Record "Evaluation Header";
        Text000: Label 'Weightage cannot be more than 100.';

        WeigAge: Decimal;
}

