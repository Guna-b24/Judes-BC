table 71173 "Faculty Class Plan Line"
{
    // 
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------

    Caption = 'Faculty Class Plan Line';
    DrillDownPageID = 71533;
    LookupPageID = 71533;

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
        field(4; "Curriculam Code"; Code[10])
        {
            Caption = 'Curriculam Code';
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

            trigger OnLookup()
            begin
                // Start 05.VIGNESH
                if FacultyClassPlanHeader.Get("Document No.") then begin
                    ClassSyllabusLine.Reset;
                    ClassSyllabusLine.SetRange("Class Code", FacultyClassPlanHeader.Class);
                    ClassSyllabusLine.SetRange(Curriculam, FacultyClassPlanHeader.Curriculum);
                    if PAGE.RunModal(0, ClassSyllabusLine) = ACTION::LookupOK then begin
                        "Unit Code" := ClassSyllabusLine."Unit Code";
                        "Unit Name" := ClassSyllabusLine."Unit Name";
                        "Chapter Code" := ClassSyllabusLine."Chapter Code";
                        "Chapter Name" := ClassSyllabusLine."Chapter Name";
                    end;
                end;
                // Stop 05.VIGNESH
            end;
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
        field(10; Week; Integer)
        {
            Caption = 'Week';
        }
        field(11; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
        }
        field(12; "Unit Name"; Text[100])
        {
            Caption = 'Unit Name';
        }
        field(13; Period; Integer)
        {
            Caption = 'Period';
        }
        field(14; "No of Minuites"; Integer)
        {
            Caption = 'No of Minuites';
        }
        field(15; "Learning OutCome"; Text[30])
        {
            Caption = 'Learning OutCome';
        }
        field(16; Assesment; Text[30])
        {
            Caption = 'Assesment';
        }
        field(17; "Work Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,Completed,Not Completed';
            OptionMembers = " ",Completed,"Not Completed";
        }
        field(18; "Scheduled Date"; Date)
        {
            Caption = 'Scheduled Date';
        }
        field(19; "Actual Date"; Date)
        {
            Caption = 'Actual Date';
        }
        field(20; "Section Code"; Code[20])
        {
            Caption = 'Section Code';
            TableRelation = Section;
        }
        field(21; "Faculty Department"; Code[20])
        {
            CalcFormula = Lookup (Employee."No." WHERE ("No." = FIELD ("Faculty Code")));
            Caption = 'Faculty Department';
            Editable = false;
            FieldClass = FlowField;
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
        if FacultyClassPlanHeader.Get("Document No.") then begin
            "Class Code" := FacultyClassPlanHeader.Class;
            "Curriculam Code" := FacultyClassPlanHeader.Curriculum;
            "Subject Code" := FacultyClassPlanHeader."Subject Code";
            "Academic Year" := EducationVertical.GetAcademicYear;
            "User ID" := UserId;
        end;
    end;

    var
        FacultyClassPlanHeader: Record "Faculty Class Plan Header";
        EducationVertical: Codeunit "Education Vertical";
        ClassSyllabusLine: Record "Class Syllabus Line";
}

