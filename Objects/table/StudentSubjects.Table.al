table 71049 "Student Subjects"
{
    // 
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'Student Subjects';
    LookupPageID = 71059;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = false;
            TableRelation = Student;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(3; Subject; Code[20])
        {
            Caption = 'Subject';
            TableRelation = Subject;

            trigger OnValidate()
            begin
                if RecSubject.Get(Subject) then begin
                    Description := RecSubject.Description;
                    "Subject Type" := RecSubject.Type;
                    "Subject Group" := RecSubject."Subject Group";
                    Stud.Get("Student No.");
                    "Class Code" := Stud."Class Code";
                    if ClassSection1.Get(Stud."Class Code") then begin
                        Class := ClassSection1.Class;
                        Section := ClassSection1.Section;
                        Curriculum := ClassSection1.Curriculum;
                    end;
                    //END ELSE BEGIN
                    // Description := '';
                    // "Subject Group" := '';
                end;
            end;
        }
        field(4; "Subject Type"; Option)
        {
            Caption = 'Subject Type';
            OptionCaption = 'Scholastic,Non-Scholastic';
            OptionMembers = Scholastic,"Non-Scholastic";
        }
        field(5; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            TableRelation = "Subject Group";
        }
        field(6; Class; Code[10])
        {
            Caption = 'Class';
            TableRelation = Class;
        }
        field(7; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = Section;
        }
        field(8; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
        }
        field(9; Description; Text[50])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                /*
                IF RecSubject.GET(Subject) THEN
                BEGIN
                    Description := RecSubject.Description;
                END;
                */
                /*
                IF RecSubject.GET(Subject) THEN BEGIN
                  Class := ClassSection1.Class;
                  Section := ClassSection1.Section;
                   Curriculum := ClassSection1.Curriculum;
                  "Academic Year" := ClassSection1."Academic Year";
                   Description := RecSubject.Description;
                END;
                 */

            end;
        }
        field(10; "Student Status"; Option)
        {
            CalcFormula = Lookup (Student."Student Status" WHERE ("No." = FIELD ("Student No.")));
            Caption = 'Student Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Student,Inactive,Alumni';
            OptionMembers = " ",Student,Inactive,Alumni;
        }
        field(11; Mark; Decimal)
        {
            Caption = 'Mark';
        }
        field(12; Grade; Code[10])
        {
            Caption = 'Grade';
        }
        field(13; "Attendance Percentage"; Decimal)
        {
            Caption = 'Attendance Percentage';
        }
        field(14; "Student Name"; Text[50])
        {
            CalcFormula = Lookup (Student.Name WHERE ("No." = FIELD ("Student No.")));
            Caption = 'Student Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Attendance % as on Date"; Date)
        {
            Caption = 'Attendance % as on Date';
        }
        field(16; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
        }
        field(20; "Student Gender"; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
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
        key(Key1; "Student No.", "Academic Year", Subject)
        {
            Clustered = true;
        }
        key(Key2; Class, Section, Curriculum, "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01. VANDHANA
        "User ID" := UserId;
        // Stop 01. VANDHANA

        Edusetup.Get;
        "Academic Year" := Edusetup."Academic Year";
    end;

    var
        RecSubject: Record Subject;
        Edusetup: Record "Education Setup";
        ClassSection1: Record "Class Section";
        Stud: Record Student;
}

