table 71008 "Class Evaluation"
{
    //  No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    //  01  15/10/09  KATHIR    Weightage - OnValidate()    Code added to Check weightage should not exceed more than 100
    //  02  19/10/09  VANDHANA  OnInsert                    Code to assign User ID.

    Caption = 'Class Evaluation';
    DrillDownPageID = 71016;
    LookupPageID = 71016;

    fields
    {
        field(1; Class; Code[10])
        {
            Caption = 'Class';
            TableRelation = Class;
        }
        field(2; "Evaluation Method Code"; Code[20])
        {
            Caption = 'Evaluation Method Code';
            TableRelation = "Evaluation Method";

            trigger OnValidate()
            begin
                Evaluation.Get("Evaluation Method Code");
                "Prequalification Mark" := Evaluation."Prequalification Mark";
            end;
        }
        field(3; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
        }
        field(4; "Pass Mark"; Decimal)
        {
            Caption = 'Pass Mark';
        }
        field(5; Compulsory; Boolean)
        {
            Caption = 'Compulsory';
        }
        field(6; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
        }
        field(7; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(8; Weightage; Decimal)
        {
            Caption = 'Weightage';

            trigger OnValidate()
            begin
                // Start 01.KATHIR
                WeigAge := 0;
                ClassEvaluation.Reset;
                ClassEvaluation.SetRange(Class, Class);
                ClassEvaluation.SetRange(Curriculum, Curriculum);
                ClassEvaluation.SetRange("Academic Year", "Academic Year");
                if ClassEvaluation.FindSet then
                    repeat
                        WeigAge += ClassEvaluation.Weightage;
                    until ClassEvaluation.Next = 0;

                if (WeigAge + Weightage - xRec.Weightage) > 100 then
                    Error(Text000);
                // Stop 01.KATHIR
            end;
        }
        field(9; "Prequalification Mark"; Boolean)
        {
            Caption = 'Prequalification Mark';
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

        "Evaluation Header".Reset;
        "Evaluation Header".SetRange("Evaluation Header".Class, Class);
        "Evaluation Header".SetRange("Evaluation Header".Curriculum, Curriculum);
        "Evaluation Header".SetRange("Evaluation Header"."Academic Year", "Academic Year");
        "Evaluation Header".SetRange("Evaluation Header"."Evaluation Code", "Evaluation Method Code");
        if "Evaluation Header".FindFirst then
            Error('Please Delete Evaluation Mark Frist');
    end;

    trigger OnInsert()
    begin
        // Start 02. VANDHANA
        "User ID" := UserId;
        // Stop 02. VANDHANA
    end;

    var
        EduVert: Codeunit "Education Vertical";
        WeigAge: Decimal;
        ClassEvaluation: Record "Class Evaluation";
        Evaluation: Record "Evaluation Method";
        Text000: Label 'Weightagea cannot be more than 100.';
        "Evaluation Header": Record "Evaluation Header";
}

