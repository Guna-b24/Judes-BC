table 71173 "Faculty Class Plan Line"
{
    Caption = 'Faculty Class Plan Line';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71533;
    // LookupPageID = 71533;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = SystemMetadata;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }

        field(3; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = Class;
            DataClassification = CustomerContent;
        }
        field(4; "Curriculam Code"; Code[10])
        {
            Caption = 'Curriculam Code';
            TableRelation = Curriculum;
            DataClassification = CustomerContent;
        }

        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;
            DataClassification = CustomerContent;
        }

        field(6; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            TableRelation = "Unit Master";
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                if FacultyClassPlanHeader.Get("Document No.") then begin
                    ClassSyllabusLine.Reset();
                    ClassSyllabusLine.SetRange("Class Code", FacultyClassPlanHeader.Class);
                    ClassSyllabusLine.SetRange(Curriculam, FacultyClassPlanHeader.Curriculum);
                    if PAGE.RunModal(0, ClassSyllabusLine) = ACTION::LookupOK then begin
                        "Unit Code" := ClassSyllabusLine."Unit Code";
                        "Unit Name" := ClassSyllabusLine."Unit Name";
                        "Chapter Code" := ClassSyllabusLine."Chapter Code";
                        "Chapter Name" := ClassSyllabusLine."Chapter Name";
                    end;
                end;
            end;
        }
        field(7; "Chapter Code"; Code[20])
        {
            Caption = 'Chapter Code';
            TableRelation = "Chapter Master";
            DataClassification = CustomerContent;
        }

        field(8; "Chapter Name"; Text[100])
        {
            Caption = 'Chapter Name';
            DataClassification = CustomerContent;
        }

        field(9; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }

        field(10; Week; Integer)
        {
            Caption = 'Week';
            DataClassification = CustomerContent;
        }

        field(11; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            DataClassification = CustomerContent;
        }

        field(12; "Unit Name"; Text[100])
        {
            Caption = 'Unit Name';
            DataClassification = CustomerContent;
        }

        field(13; Period; Integer)
        {
            Caption = 'Period';
            DataClassification = CustomerContent;
        }

        field(14; "No of Minuites"; Integer)
        {
            Caption = 'No of Minuites';
            DataClassification = CustomerContent;
        }

        field(15; "Learning OutCome"; Text[30])
        {
            Caption = 'Learning OutCome';
            DataClassification = CustomerContent;
        }

        field(16; Assesment; Text[30])
        {
            Caption = 'Assesment';
            DataClassification = CustomerContent;
        }
        field(17; "Work Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,Completed,Not Completed';
            OptionMembers = " ",Completed,"Not Completed";
            DataClassification = CustomerContent;
        }

        field(18; "Scheduled Date"; Date)
        {
            Caption = 'Scheduled Date';
            DataClassification = CustomerContent;
        }

        field(19; "Actual Date"; Date)
        {
            Caption = 'Actual Date';
            DataClassification = CustomerContent;
        }

        field(20; "Section Code"; Code[20])
        {
            Caption = 'Section Code';
            TableRelation = Section;
            DataClassification = CustomerContent;
        }

        field(21; "Faculty Department"; Code[20])
        {
            Caption = 'Faculty Department';
            CalcFormula = Lookup(Employee."No." WHERE("No." = FIELD("Faculty Code")));
            Editable = false;
            FieldClass = FlowField;
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
            "Academic Year" := EducationVertical.GetAcademicYear();
        end;
    end;

    var
        FacultyClassPlanHeader: Record "Faculty Class Plan Header";
        ClassSyllabusLine: Record "Class Syllabus Line";
        EducationVertical: Codeunit "Education Vertical";

}

