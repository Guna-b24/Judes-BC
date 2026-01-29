table 71053 "Marks Line"
{
    //   No   Date      Sign     Trigger                          Description
    // -----------------------------------------------------------------------------------------------
    //   01  30/09/09   KATHIR  Student No. - OnValidate()        Code added to Get student Name
    //   02  30/09/09   KATHIR  Marks Obtained - OnValidate()     Code added to Calculate Grade and average
    //   03  17/11/09   VIGNESH Marks Obtained - OnValidate()     Code added modifiy to validate if mark is zero
    //   04  23/11/09   VIGNESH  Class - OnValidate()             Code added to get the Class Section & Curriculum
    //   05  23/11/09   VIGNESH  Class - OnLookup()               Code added to get the Class Section & Curriculum
    //   06  23/11/09   VIGNESH  Section - OnValidate()           Code added to get the Class Section & Curriculum
    //   07  23/11/09   VIGNESH  Section - OnLookup()             Code added to get the Class Section & Curriculum
    //   08  23/11/09   VIGNESH  Curriculum - OnValidate()        Code added to get the Class Section & Curriculum
    //   09  23/11/09   VIGNESH  Curriculum - OnLookup()          Code added to get the Class Section & Curriculum
    //   10  25/11/09   VIGNESH  Marks Obtained - OnValidate()    Code modified based on Class Section
    //   11  13/1/10    KAVITHA  Field                            Added a new field Points
    //   12  13/1/10    KAVITHA  Marks Obtained - OnValidate()    Code is written to get the Points .

    Caption = 'Marks Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = true;
            TableRelation = Student WHERE (Class = FIELD (Class),
                                           Section = FIELD (Section),
                                           Curriculum = FIELD (Curriculum),
                                           "Academic Year" = FIELD ("Academic Year"),
                                           "Student Status" = FILTER (Student));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                // Start 01.KATHIR
                if RecStudent.Get("Student No.") then
                    "Student Name" := RecStudent.Name
                else
                    "Student Name" := '';
                // Start 04.KATHIR
            end;
        }
        field(4; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            Editable = false;
        }
        field(5; "Max Mark"; Decimal)
        {
            BlankZero = true;
            Caption = 'Max Mark';
        }
        field(6; "Marks Obtained"; Decimal)
        {
            Caption = 'Marks Obtained';

            trigger OnValidate()
            begin
                // Start 02.KATHIR
                if ("Marks Obtained" > "Max Mark") or ("Marks Obtained" < 0) then
                    Error(Text000);

                if "Marks Obtained" < "Pass Mark" then
                    Result := Result::Fail
                else
                    Result := Result::Pass;

                if ("Marks Obtained" <> 0) and ("Max Mark" <> 0) then
                    Percentage := ("Marks Obtained" / "Max Mark") * 100
                else
                    if ("Marks Obtained" = 0) and ("Max Mark" <> 0) then // Start 03.VIGNESH
                        Percentage := 0;                                       // Stop 03.VIGNESH

                // Start 10.VIGNESH
                //IF "Class Card".GET(Class,Section,Curriculum,"Academic Year") THEN;
                if ClassSection.Get("Class Code") then;
                // Stop 10.VIGNESH

                //IF "Class Card"."Marks System" = "Class Card"."Marks System"::Grade THEN
                //BEGIN
                ClassGrade.Reset;
                ClassGrade.SetCurrentKey(Class, Curriculum, "Academic Year", "Grade Code");
                ClassGrade.SetRange(Class, Class);
                ClassGrade.SetRange(Curriculum, Curriculum);
                ClassGrade.SetRange("Academic Year", "Academic Year");
                ClassGrade.SetFilter("Max Percentage", '>=%1', "Marks Obtained");
                ClassGrade.SetFilter("Min Percentage", '<=%1', "Marks Obtained");
                if ClassGrade.FindSet then begin
                    Grade := ClassGrade."Grade Code";
                    // Start01.KAVITHA
                    Points := ClassGrade.Points;
                    // Stop01.KAVITHA
                end else begin
                    Grade := '';
                    // Start01.KAVITHA
                    Points := 0;
                    // Stop01.KAVITHA
                end
                //ELSE
                //  Grade := '';
                // Start 02.KATHIR
            end;
        }
        field(7; Result; Option)
        {
            Caption = 'Result';
            OptionCaption = ' ,Pass,Fail,Absent';
            OptionMembers = " ",Pass,Fail,Absent;
        }
        field(8; Remarks; Text[50])
        {
            Caption = 'Remarks';
        }
        field(9; Percentage; Decimal)
        {
            BlankZero = true;
            Caption = 'Percentage';
        }
        field(10; Grade; Code[20])
        {
            Caption = 'Grade';
            TableRelation = Grade;
        }
        field(11; ExamCount; Integer)
        {
            Caption = 'ExamCount';
        }
        field(12; Class; Code[20])
        {
            Caption = 'Class';
        }
        field(13; Section; Code[20])
        {
            Caption = 'Section';
        }
        field(14; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(15; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
        }
        field(16; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(17; Subject; Code[20])
        {
            Caption = 'Subject';
            Editable = true;
            TableRelation = Subject;
        }
        field(18; "Exam Type"; Code[10])
        {
            Caption = 'Exam Type';
            Editable = true;
            TableRelation = "Exam Code";
        }
        field(19; "Pass Mark"; Integer)
        {
            Caption = 'Pass Mark';
        }
        field(20; Points; Decimal)
        {
            Caption = 'Points';
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
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(30; Published; Boolean)
        {
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
        ClassCard: Record "Class Card";
        ClassSection: Record "Class Section";
        Text000: Label 'Enter valid mark.';
        ClassSection1: Record "Class Section";
        ClassSectionLook: Record "Class Section";
}

