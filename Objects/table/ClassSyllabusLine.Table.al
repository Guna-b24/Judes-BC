table 71171 "Class Syllabus Line"
{
    Caption = 'Class Syllabus Line';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71176;
    // LookupPageID = 71176;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the syllabus document number this line belongs to.';
            DataClassification = CustomerContent;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the line number in the syllabus document.';
            DataClassification = SystemMetadata;
        }

        field(3; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            ToolTip = 'Specifies the class for which the syllabus line is defined.';
            TableRelation = Class;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; Curriculam; Code[10])
        {
            Caption = 'Curriculam';
            ToolTip = 'Specifies the curriculum applicable to the syllabus line.';
            TableRelation = Curriculum;
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            ToolTip = 'Specifies the subject associated with the syllabus line.';
            TableRelation = Subject;
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(6; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            ToolTip = 'Specifies the unit covered in the syllabus.';
            TableRelation = "Unit Master";
            DataClassification = CustomerContent;
        }
        field(7; "Chapter Code"; Code[20])
        {
            Caption = 'Chapter Code';
            ToolTip = 'Specifies the chapter included in the unit.';
            TableRelation = "Chapter Master";
            DataClassification = CustomerContent;
        }

        field(8; "Chapter Name"; Text[100])
        {
            Caption = 'Chapter Name';
            ToolTip = 'Specifies the name of the chapter.';
            DataClassification = CustomerContent;
        }

        field(9; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year for the syllabus line.';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(10; "No of Hours"; Integer)
        {
            Caption = 'No. of Hours';
            ToolTip = 'Specifies the number of teaching hours planned for this chapter.';
            MinValue = 0;
            DataClassification = CustomerContent;
        }

        field(11; "Unit Name"; Text[100])
        {
            Caption = 'Unit Name';
            ToolTip = 'Specifies the name of the unit.';
            DataClassification = CustomerContent;
        }

        field(20; "Teaching Aids"; Text[250])
        {
            Caption = 'Teaching Aids';
            ToolTip = 'Specifies the teaching aids used for this chapter.';
            DataClassification = CustomerContent;
        }
        field(21; Aim; Text[250])
        {
            Caption = 'Aim';
            ToolTip = 'Specifies the learning objective of the chapter.';
            DataClassification = CustomerContent;
        }

        field(22; Explaination; Text[250])
        {
            Caption = 'Explanation';
            ToolTip = 'Provides a brief explanation of the chapter content.';
            DataClassification = CustomerContent;
        }

        field(23; Assignment; Text[250])
        {
            Caption = 'Assignment';
            ToolTip = 'Specifies assignments related to the chapter.';
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the external portal reference ID.';
            DataClassification = CustomerContent;
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
            "Academic Year" := EducationVertical.GetAcademicYear();
        end;
    end;

    var
        ClassSyllabusHeader: Record "Class Syllabus Header";
        EducationVertical: Codeunit "Education Vertical";
}

