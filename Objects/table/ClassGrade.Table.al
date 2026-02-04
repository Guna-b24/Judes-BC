table 71054 "Class Grade"
{
    Caption = 'Class Grade';

    fields
    {
        field(1; Class; Code[10])
        {
            Caption = 'Class';
            ToolTip = 'Specifies the class.';
            TableRelation = Class;
            DataClassification = CustomerContent;
        }
        field(2; "Grade Code"; Code[20])
        {
            Caption = 'Grade Code';
            ToolTip = 'Specifies the grade code applicable for the class.';
            TableRelation = Grade;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Grade.Get("Grade Code") then begin
                    Description := Grade.Description;
                    "Max Percentage" := Grade."Max Percentage";
                    "Min Percentage" := Grade."Min Percentage";
                end else begin
                    Description := '';
                    "Max Percentage" := 0;
                    "Min Percentage" := 0;
                end;
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the grade.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; Section; Code[10])
        {
            Caption = 'Section';
            ToolTip = 'Specifies the section.';
            DataClassification = CustomerContent;
        }
        field(5; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            ToolTip = 'Specifies the curriculum.';
            TableRelation = Curriculum;
            DataClassification = CustomerContent;
        }
        field(6; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year.';
            TableRelation = "Academic Year";
            DataClassification = CustomerContent;
        }
        field(7; "Max Percentage"; Decimal)
        {
            Caption = 'Max Percentage';
            DataClassification = CustomerContent;
        }
        field(8; "Min Percentage"; Decimal)
        {
            Caption = 'Min Percentage';
            DataClassification = CustomerContent;
        }
        field(9; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
        }
        field(10; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class section code.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Class, Curriculum, "Academic Year", "Grade Code")
        {
            Clustered = true;
        }
        key(Key2; Points)
        {
        }
        key(Key3; Class, Points)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
    end;

    var
        Grade: Record Grade;
    // ClassSectionLook: Record "Class Section";
}

