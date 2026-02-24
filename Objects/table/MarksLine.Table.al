table 71053 "Marks Line"
{
    Caption = 'Marks Line';
    DataClassification = CustomerContent;
    LookupPageID = "Marks Line List";
    DrillDownPageID = "Marks Line List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the document number.';
            DataClassification = CustomerContent;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = true;
            TableRelation = Student WHERE(Class = FIELD(Class),
                                           Section = FIELD(Section),
                                           Curriculum = FIELD(Curriculum),
                                           "Academic Year" = FIELD("Academic Year"),
                                           "Student Status" = FILTER(Student));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin

                if RecStudent.Get("Student No.") then
                    "Student Name" := RecStudent.Name
                else
                    "Student Name" := '';

            end;
        }
        field(4; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(5; "Max Mark"; Decimal)
        {
            Caption = 'Max Mark';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(6; "Marks Obtained"; Decimal)
        {
            Caption = 'Marks Obtained';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                if ("Marks Obtained" > "Max Mark") or ("Marks Obtained" < 0) then
                    Error(Text000);

                if "Marks Obtained" < "Pass Mark" then
                    Result := Result::Fail
                else
                    Result := Result::Pass;

                if ("Marks Obtained" <> 0) and ("Max Mark" <> 0) then
                    Percentage := ("Marks Obtained" / "Max Mark") * 100
                else
                    if ("Marks Obtained" = 0) and ("Max Mark" <> 0) then
                        if ClassSection.Get("Class Code") then;

                ClassGrade.Reset();
                ClassGrade.SetCurrentKey(Class, Curriculum, "Academic Year", "Grade Code");
                ClassGrade.SetRange(Class, Class);
                ClassGrade.SetRange(Curriculum, Curriculum);
                ClassGrade.SetRange("Academic Year", "Academic Year");
                ClassGrade.SetFilter("Max Percentage", '>=%1', "Marks Obtained");
                ClassGrade.SetFilter("Min Percentage", '<=%1', "Marks Obtained");
                if ClassGrade.FindSet() then begin
                    Grade := ClassGrade."Grade Code";
                    Points := ClassGrade.Points;
                end else begin
                    Grade := '';
                    Points := 0;
                end
            end;
        }
        field(7; Result; Option)
        {
            Caption = 'Result';
            OptionMembers = " ",Pass,Fail,Absent;
            OptionCaption = ' ,Pass,Fail,Absent';
            DataClassification = CustomerContent;
        }

        field(8; Remarks; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(9; Percentage; Decimal)
        {
            Caption = 'Percentage';
            BlankZero = true;
            DataClassification = CustomerContent;
        }

        field(10; Grade; Code[20])
        {
            Caption = 'Grade';
            TableRelation = Grade;
            DataClassification = CustomerContent;
        }
        field(11; ExamCount; Integer)
        {
            Caption = 'Exam Count';
            DataClassification = CustomerContent;
        }

        field(12; Class; Code[20])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
        }

        field(13; Section; Code[20])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
        }

        field(14; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }

        field(15; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            DataClassification = CustomerContent;
        }

        field(17; Subject; Code[20])
        {
            Caption = 'Subject';
            TableRelation = Subject;
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(18; "Exam Type"; Code[10])
        {
            Caption = 'Exam Type';
            TableRelation = "Exam Code";
            Editable = true;
            DataClassification = CustomerContent;
        }

        field(19; "Pass Mark"; Integer)
        {
            Caption = 'Pass Mark';
            DataClassification = CustomerContent;
        }

        field(20; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
        }
        field(21; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";

            trigger OnValidate()
            begin
                if ClassSection1.Get("Class Code") then begin
                    Class := ClassSection1.Class;
                    Section := ClassSection1.Section;
                    Curriculum := ClassSection1.Curriculum;
                    "Academic Year" := ClassSection1."Academic Year";
                end;
            end;
        }
        field(22; Gender; Option)
        {
            Caption = 'Gender';
            OptionMembers = " ",Male,Female;
            OptionCaption = ' ,Male,Female';
            DataClassification = CustomerContent;
        }

        field(30; Published; Boolean)
        {
            Caption = 'Published';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Student No.")
        {
            Clustered = true;
        }
        key(Key2; "Student No.", "Exam Type")
        {
        }
        key(Key3; Class, Section, "Academic Year", Curriculum, "Exam Type")
        {
        }
        key(Key4; Class, Section, "Academic Year", Curriculum, "Exam Type", "Student No.")
        {
            SumIndexFields = "Max Mark", "Marks Obtained";
        }
        key(Key5; "Academic Year", Class, Section, Curriculum, "Student No.")
        {
            SumIndexFields = Points;
        }
        key(Key6; "Student No.", "Exam Type", Subject)
        {
        }
        key(Key7; Class, Section, "Academic Year", Curriculum, Subject)
        {
        }
        key(Key8; "Student No.", Class, Section, Curriculum, "Academic Year", Subject, ExamCount, "Exam Type")
        {
        }
        key(Key9; "Class Code")
        {
        }
        key(Key10; "Marks Obtained")
        {
        }
        key(Key11; Gender, "Student Name")
        {
        }
        key(Key12; "Student Name")
        {
        }
    }

    fieldgroups
    {
    }

    var
        RecStudent: Record Student;
        ClassGrade: Record "Class Grade";
        ClassSection: Record "Class Section";
        ClassSection1: Record "Class Section";
        Text000: Label 'Enter valid mark.';
}

