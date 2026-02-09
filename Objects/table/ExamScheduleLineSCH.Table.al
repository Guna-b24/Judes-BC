table 71066 "Exam Schedule Line - SCH"
{
    Caption = 'Exam Schedule Line - SCH';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = SystemMetadata;
        }

        field(2; Class; Code[20])
        {
            Caption = 'Class';
            Editable = true;
            DataClassification = CustomerContent;
        }

        field(3; Section; Code[20])
        {
            Caption = 'Section';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;
            DataClassification = CustomerContent;
        }

        field(5; Curriculum; Code[10])
        {
            Caption = 'Curriculam Code';
            Editable = true;
            DataClassification = CustomerContent;
        }

        field(6; "Hall Code"; Code[20])
        {
            Caption = 'Hall Code';
            DataClassification = CustomerContent;
        }
        field(7; "No of Students"; Integer)
        {
            Caption = 'No of Students';
            DataClassification = CustomerContent;
        }

        field(8; "Examiner Type"; Option)
        {
            Caption = 'Examiner Type';
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
            DataClassification = CustomerContent;
        }
        field(9; "Examiner Code"; Code[20])
        {
            Caption = 'Examiner Code';
            DataClassification = CustomerContent;
        }

        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }

        field(11; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(12; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
        }

        field(13; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
        }

        field(14; "Exam Slot"; Code[20])
        {
            Caption = 'Exam Slot';
            DataClassification = CustomerContent;
        }

        field(15; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = CustomerContent;
        }

        field(16; "Exam Code"; Code[20])
        {
            Caption = 'Exam Code';
            TableRelation = "Exam Code";
            DataClassification = CustomerContent;
        }

        field(17; "Mark Header Code"; Code[20])
        {
            Caption = 'Mark Header Code';
            DataClassification = CustomerContent;
        }
        field(18; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";

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
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Class)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Academic Year" := EducationVertical.GetAcademicYear();

        if ExamScheduleHead.Get("Document No.") then begin
            "Exam Slot" := ExamScheduleHead."Exam Slot";
            "Start Time" := ExamScheduleHead."Start Time";
            "End Time" := ExamScheduleHead."End Time";
            "Exam Date" := ExamScheduleHead.Date;
            "Exam Code" := ExamScheduleHead."Exam Code";
        end;


    end;

    var
        ExamScheduleHead: Record "Exam Schedule Head - SCH";
        ClassSection: Record "Class Section";
        EducationVertical: Codeunit "Education Vertical";
}

