table 71171 "Class Syllabus Line"
{
    // 
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   22.09.09 VIGNESH  Fee Code - OnValidate()    Code added to get the Description from Fees component table;

    Caption = 'Class Syllabus Line';
    DrillDownPageID = 71176;
    LookupPageID = 71176;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = Class;
        }
        field(4; Curriculam; Code[10])
        {
            Caption = 'Curriculam';
            TableRelation = Curriculum;
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;
        }
        field(6; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            TableRelation = "Unit Master";
        }
        field(7; "Chapter Code"; Code[20])
        {
            Caption = 'Chapter Code';
            TableRelation = "Chapter Master";
        }
        field(8; "Chapter Name"; Text[100])
        {
            Caption = 'Chapter Name';
        }
        field(9; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(10; "No of Hours"; Integer)
        {
            Caption = 'No of Hours';
        }
        field(11; "Unit Name"; Text[100])
        {
            Caption = 'Unit Name';
        }
        field(20; "Teaching Aids"; Text[250])
        {
        }
        field(21; Aim; Text[250])
        {
        }
        field(22; Explaination; Text[250])
        {
        }
        field(23; Assignment; Text[250])
        {
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
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if ClassSyllabusHeader.Get("Document No.") then begin
            "Class Code" := ClassSyllabusHeader."Class Code";
            Curriculam := ClassSyllabusHeader.Curriculam;
            "Subject Code" := ClassSyllabusHeader."Subject Code";
            "Academic Year" := EducationVertical.GetAcademicYear;
            "User ID" := UserId;
        end;
    end;

    var
        ClassSyllabusHeader: Record "Class Syllabus Header";
        EducationVertical: Codeunit "Education Vertical";
}

