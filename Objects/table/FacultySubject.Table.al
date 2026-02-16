table 71150 "Faculty Subject"
{
    Caption = 'Faculty Subject';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71150;
    // LookupPageID = 71150;

    fields
    {
        field(1; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            TableRelation = "Employee Alll";
            DataClassification = CustomerContent;
            ToolTip = 'Select the faculty for the subject.';

            trigger OnValidate()
            begin
                if "Faculty Code" <> '' then
                    if RecEmployee.Get("Faculty Code") then
                        "Faculty Name" := RecEmployee."First Name" + ' ' + RecEmployee."Last Name" + ' ' + RecEmployee."Middle Name";
            end;
        }
        field(2; Class; Code[20])
        {
            Caption = 'Class';
            TableRelation = Class;
            DataClassification = CustomerContent;
            ToolTip = 'Select the class for which the faculty is assigned.';
        }

        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
            DataClassification = CustomerContent;
            ToolTip = 'Curriculum associated with the class and faculty.';
        }

        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;
            DataClassification = CustomerContent;
            ToolTip = 'Select the subject taught by the faculty.';

            trigger OnValidate()
            begin
                if RecSubject.Get("Subject Code") then
                    "Subject Description" := RecSubject.Description;

            end;
        }
        field(5; "Class Master"; Boolean)
        {
            Caption = 'Class Master';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates if the faculty is the class master.';
        }

        field(6; "Alloted Hours"; Integer)
        {
            Caption = 'Alloted Hours';
            DataClassification = CustomerContent;
        }

        field(7; "Weekly Hours"; Integer)
        {
            Caption = 'Weekly Hours';
            DataClassification = CustomerContent;
        }

        field(8; "Section Code"; Code[10])
        {
            Caption = 'Section Code';
            DataClassification = CustomerContent;
        }
        field(9; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }

        field(10; Available; Boolean)
        {
            Caption = 'Available';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates if the faculty is available for assignment.';
        }

        field(11; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            // TableRelation = "Subject Type";
            DataClassification = CustomerContent;
            ToolTip = 'Select the type of subject.';
        }

        field(12; "Faculty Name"; Text[100])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
            ToolTip = 'Full name of the faculty.';
        }

        field(13; "Subject Description"; Text[50])
        {
            Caption = 'Subject Description';
            DataClassification = CustomerContent;
        }

        field(14; "Class Code"; Code[20])
        {
            TableRelation = "Class Section";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ClassSection.Get("Class Code") then begin
                    Class := ClassSection.Class;
                    "Section Code" := ClassSection.Section;
                    Curriculum := ClassSection.Curriculum;
                    "Academic Year" := ClassSection."Academic Year";
                end;
            end;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Faculty Code", Class, Curriculum, "Section Code", "Subject Code", "Academic Year")
        {
            Clustered = true;
        }
        key(Key2; Class, Curriculum, "Subject Code", Available)
        {
        }
        key(Key3; Class, Curriculum, "Section Code", "Subject Code", "Academic Year")
        {
        }
        key(Key4; "Faculty Code", Class, "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }


    var
        RecEmployee: Record Employee;
        ClassSection: Record "Class Section";
        RecSubject: Record Subject;
}

