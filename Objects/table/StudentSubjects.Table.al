table 71049 "Student Subjects"
{
    Caption = 'Student Subjects';
    DataClassification = CustomerContent;
    //LookupPageID = 71059;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = false;
            TableRelation = Student;
            ToolTip = 'Specifies the student number.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            ToolTip = 'Specifies the academic year.';
            DataClassification = CustomerContent;
        }
        field(3; Subject; Code[20])
        {
            Caption = 'Subject';
            TableRelation = Subject;
            ToolTip = 'Specifies the subject assigned to the student.';
            DataClassification = CustomerContent;
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
                end;
            end;
        }
        field(4; "Subject Type"; Option)
        {
            Caption = 'Subject Type';
            OptionCaption = 'Scholastic,Non-Scholastic';
            OptionMembers = Scholastic,"Non-Scholastic";
            ToolTip = 'Specifies whether the subject is scholastic or non-scholastic.';
            DataClassification = CustomerContent;
        }

        field(5; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            TableRelation = "Subject Group";
            ToolTip = 'Specifies the subject group.';
            DataClassification = CustomerContent;
        }
        field(6; Class; Code[20])
        {
            Caption = 'Class';
            TableRelation = Class;
            ToolTip = 'Specifies the class of the student.';
            DataClassification = CustomerContent;
        }

        field(7; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = Section;
            ToolTip = 'Specifies the section of the student.';
            DataClassification = CustomerContent;
        }

        field(8; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
            ToolTip = 'Specifies the curriculum followed by the student.';
            DataClassification = CustomerContent;
        }
        field(9; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the subject description.';
            DataClassification = CustomerContent;
        }

        field(10; "Student Status"; Option)
        {
            Caption = 'Student Status';
            Editable = false;
            OptionCaption = ' ,Student,Inactive,Alumni';
            OptionMembers = " ",Student,Inactive,Alumni;
            ToolTip = 'Displays the current status of the student.';
            DataClassification = CustomerContent;
        }

        field(11; Mark; Decimal)
        {
            Caption = 'Mark';
            ToolTip = 'Specifies the mark obtained in the subject.';
            DataClassification = CustomerContent;
        }

        field(12; Grade; Code[10])
        {
            Caption = 'Grade';
            ToolTip = 'Specifies the grade obtained in the subject.';
            DataClassification = CustomerContent;
        }
        field(13; "Attendance Percentage"; Decimal)
        {
            Caption = 'Attendance Percentage';
            ToolTip = 'Specifies the attendance percentage for the subject.';
            DataClassification = CustomerContent;
        }

        field(14; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            Editable = false;
            ToolTip = 'Displays the name of the student.';
            DataClassification = CustomerContent;

        }

        field(15; "Attendance % as on Date"; Date)
        {
            Caption = 'Attendance % as on Date';
            ToolTip = 'Specifies the date on which attendance percentage is calculated.';
            DataClassification = CustomerContent;
        }

        field(16; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            ToolTip = 'Specifies the class section code.';
            DataClassification = CustomerContent;
        }

        field(20; "Student Gender"; Option)
        {
            Caption = 'Student Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
            ToolTip = 'Specifies the gender of the student.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal identifier for integration.';
            DataClassification = SystemMetadata;
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
        Edusetup.Get();
        "Academic Year" := Edusetup."Academic Year";
    end;

    var
        RecSubject: Record Subject;
        Edusetup: Record "Education Setup";
        ClassSection1: Record "Class Section";
        Stud: Record Student;
}

