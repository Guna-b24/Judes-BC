table 71059 "Promotion Suggestion"
{
    Caption = 'Promotion Suggestion';
    LookupPageId = "Promotion Suggestion";

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the student number.';
        }

        field(2; Class; Code[20])
        {
            Caption = 'Class';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the current class of the student.';
        }
        field(3; Section; Code[10])
        {
            Caption = 'Section';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the current section of the student.';
        }

        field(4; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the curriculum of the student.';
        }

        field(5; "Pass %"; Decimal)
        {
            BlankZero = true;
            Caption = 'Pass %';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the pass percentage obtained by the student.';
        }
        field(6; "Marks Obtained"; Decimal)
        {
            BlankZero = true;
            Caption = 'Marks Obtained';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the marks obtained by the student.';
        }

        field(7; Result; Option)
        {
            Caption = 'Result';
            OptionCaption = 'Promoted,Detained,Withheld';
            OptionMembers = Promoted,Detained,Withheld;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the suggested promotion result for the student.';
        }

        field(8; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the name of the student.';
        }
        field(9; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year of the student.';
        }

        field(12; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class section code. Selecting this will auto-populate class, section, curriculum and academic year.';
            trigger OnValidate()
            begin
                if ClassSection.Get("Class Code") then begin
                    Class := ClassSection.Class;
                    Section := ClassSection.Section;
                    Curriculum := ClassSection.Curriculum;
                    "Academic Year" := ClassSection."Academic Year";
                end;
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
        key(Key1; "Student No.", "Class Code")
        {
            Clustered = true;
        }
        key(Key2; Class, Section, Curriculum, "Academic Year")
        {
        }
        key(Key3; "Class Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ClassSection: Record "Class Section";
}

