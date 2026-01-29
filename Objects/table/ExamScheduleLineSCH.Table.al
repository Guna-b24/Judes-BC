table 71066 "Exam Schedule Line - SCH"
{
    // 
    //   No   Date      Sign     Trigger            Description
    // -----------------------------------------------------------------------------------------------
    //   01  08.02.10   GUNA    OnInsert()       Inserted slot and time from the header

    Caption = 'Exam Schedule Line - SCH';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; Class; Code[20])
        {
            Caption = 'Class';
            Editable = true;
        }
        field(3; Section; Code[20])
        {
            Caption = 'Section';
            Editable = true;
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;
        }
        field(5; Curriculum; Code[10])
        {
            Caption = 'Curriculam Code';
            Editable = true;
        }
        field(6; "Hall Code"; Code[20])
        {
            Caption = 'Hall Code';
        }
        field(7; "No of Students"; Integer)
        {
            Caption = 'No of Students';
        }
        field(8; "Examiner Type"; Option)
        {
            Caption = 'Examiner Type';
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(9; "Examiner Code"; Code[20])
        {
            Caption = 'Examiner Code';
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(11; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Editable = true;
        }
        field(12; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(13; "End Time"; Time)
        {
            Caption = 'End Time';
        }
        field(14; "Exam Slot"; Code[20])
        {
            Caption = 'Exam Slot';
        }
        field(15; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
        }
        field(16; "Exam Code"; Code[20])
        {
            Caption = 'Exam Code';
            TableRelation = "Exam Code";
        }
        field(17; "Mark Header Code"; Code[20])
        {
            Caption = 'Mark Header Code';
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
        "Academic Year" := EducationVertical.GetAcademicYear;
        "User ID" := UserId;
        // Start 01.GUNA
        if ExamScheduleHead.Get("Document No.") then begin
            "Exam Slot" := ExamScheduleHead."Exam Slot";
            "Start Time" := ExamScheduleHead."Start Time";
            "End Time" := ExamScheduleHead."End Time";
            "Exam Date" := ExamScheduleHead.Date;
            "Exam Code" := ExamScheduleHead."Exam Code";
        end;

        // Stop 01.GUNA
    end;

    var
        EducationVertical: Codeunit "Education Vertical";
        ExamScheduleHead: Record "Exam Schedule Head - SCH";
        ClassSection: Record "Class Section";
}

