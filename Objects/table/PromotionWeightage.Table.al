table 71058 "Promotion Weightage"
{
    Caption = 'Promotion Weightage';
    DataClassification = CustomerContent;
    LookupPageId = "Promotion Weightage";

    fields
    {
        field(1; "Class Code"; Code[10])
        {
            Caption = 'Class Code';
            TableRelation = "Class Card".Class;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class for which the promotion weightage is defined.';
        }

        field(2; "Curriculum Code"; Code[10])
        {
            Caption = 'Curriculum Code';
            TableRelation = "Class Card".Curriculum;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the curriculum applicable for the class.';
        }
        field(3; "Academic Year Code"; Code[10])
        {
            Caption = 'Academic Year Code';
            TableRelation = "Academic Year";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year for which the weightage is defined.';
        }

        field(4; "Exam Type Code"; Code[10])
        {
            Caption = 'Exam Type Code';
            TableRelation = "Exam Code";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the exam type for which weightage is assigned.';
        }
        field(5; Weightage; Decimal)
        {
            Caption = 'Weightage';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the percentage weightage assigned to the selected exam type. Total weightage per class and year cannot exceed 100%.';

            trigger OnValidate()
            begin
                WeigAge := 0;
                PromotionWeight.Reset();
                PromotionWeight.SetCurrentKey("Class Code", "Curriculum Code", "Academic Year Code", "Exam Type Code");
                PromotionWeight.SetRange("Class Code", "Class Code");
                PromotionWeight.SetRange("Curriculum Code", "Curriculum Code");
                PromotionWeight.SetRange("Academic Year Code", "Academic Year Code");
                if PromotionWeight.FindSet() then
                    repeat
                        WeigAge += PromotionWeight.Weightage;
                    until PromotionWeight.Next() = 0;

                if (WeigAge + Weightage - xRec.Weightage) > 100 then
                    Error(Text000);
            end;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier associated with this record.';
        }
    }

    keys
    {
        key(Key1; "Class Code", "Curriculum Code", "Academic Year Code", "Exam Type Code")
        {
            Clustered = true;
            SumIndexFields = Weightage;
        }
    }

    fieldgroups
    {
    }

    var
        PromotionWeight: Record "Promotion Weightage";
        WeigAge: Decimal;
        Text000: Label 'Weightage cannot be more than 100.';
}

