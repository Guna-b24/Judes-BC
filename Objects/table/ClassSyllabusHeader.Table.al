table 71170 "Class Syllabus Header"
{
    Caption = 'Class Syllabus Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                // Start 02.VIGNESH
                if "No." <> xRec."No." then begin
                    AcademicsSetup.Get;
                    NoSeriesMgt.TestManual(AcademicsSetup."Class Syllabus No.");
                    "No.Series" := '';
                end;
                // Stop 02.VIGNESH
            end;
        }
        field(2; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = Class;
        }
        field(3; Curriculam; Code[10])
        {
            Caption = 'Curriculam';
            TableRelation = Curriculum;
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;
        }
        field(5; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(6; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
        field(70784; Department; Code[20])
        {
            Caption = 'Department';
            TableRelation = Department;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.VIGNESH
        AcademicsSetup.Get;
        if "No.Series" = '' then begin
            AcademicsSetup.TestField("Class Syllabus No.");
            NoSeriesMgt.InitSeries(AcademicsSetup."Class Syllabus No.", xRec."No.Series", 0D, "No.", "No.Series");
        end;

        "Academic Year" := EduVertical.GetAcademicYear;
        // Stop 01.VIGNESH

        // Start 06. VANDHANA
        "User ID" := UserId;
        // Stop 06. VANDHANA
    end;

    var
        AcademicsSetup: Record "Academics Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EduVertical: Codeunit "Education Vertical";
        ClassSyllabusHeader: Record "Class Syllabus Header";

    [Scope('Internal')]
    procedure Assistedit(OldClassSyllabusHeader: Record "Class Syllabus Header"): Boolean
    begin
        // Start 03.VIGNESH
        with ClassSyllabusHeader do begin
            ClassSyllabusHeader := Rec;
            AcademicsSetup.Get;
            AcademicsSetup.TestField("Class Syllabus No.");
            if NoSeriesMgt.SelectSeries(AcademicsSetup."Class Syllabus No.", OldClassSyllabusHeader."No.Series",
               "No.Series")
            then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := ClassSyllabusHeader;
                exit(true);
            end;
        end;
        // Stop 03.VIGNESH
    end;
}

