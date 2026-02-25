table 71060 "Promotion History"
{
    Caption = 'Promotion History';
    DataClassification = CustomerContent;
    LookupPageId = "Promotion History List";

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the student number.';
        }

        field(2; Class; Code[20])
        {
            Caption = 'Class';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class of the student.';
        }
        field(3; Section; Code[10])
        {
            Caption = 'Section';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the section of the student.';
        }

        field(4; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the curriculum associated with the class.';
        }

        field(5; "Pass %"; Decimal)
        {
            BlankZero = true;
            Caption = 'Pass %';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the pass percentage achieved by the student.';
        }
        field(6; "Marks Obtained"; Decimal)
        {
            BlankZero = true;
            Caption = 'Marks Obtained';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total marks obtained by the student.';
        }

        field(7; Result; Option)
        {
            Caption = 'Result';
            OptionCaption = 'Promoted,Detained,Withheld';
            OptionMembers = Promoted,Detained,Withheld;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the promotion result of the student.';
        }

        field(8; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the name of the student.';
        }

        field(9; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year of the record.';
        }

        field(10; "Promoted Academic Year"; Code[10])
        {
            Caption = 'Promoted Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year to which the student was promoted.';
        }

        field(11; "Promoted Class"; Code[10])
        {
            Caption = 'Promoted Class';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class to which the student was promoted.';
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
        field(50000; "Orig.Promoted Academic Year"; Code[10])
        {
            Caption = 'Original Promoted Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the originally recorded promoted academic year.';
        }

        field(50001; "Orig. Class Code"; Code[20])
        {
            Caption = 'Original Class Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the originally recorded class code.';
        }

        field(50002; "Acad. Class Code"; Code[20])
        {
            Caption = 'Academic Class Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic class code reference.';
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
        key(Key1; "Student No.", Class, "Academic Year")
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

    trigger OnInsert()
    begin
    end;

    var
        ClassSection: Record "Class Section";
}

