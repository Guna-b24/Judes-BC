table 71172 "Faculty Class Plan Header"
{
    Caption = 'Faculty Class Plan Header';

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
                    NoSeriesMgt.TestManual(AcademicsSetup."Faculty Class Plan No.");
                    "No.Series" := '';
                end;
                // Stop 02.VIGNESH
            end;
        }
        field(2; Class; Code[20])
        {
            Caption = 'Class';
            Editable = false;
        }
        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculam Code';
            Editable = false;
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;
        }
        field(5; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = false;
        }
        field(6; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
        }
        field(7; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            TableRelation = Employee;
        }
        field(8; "Plan Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,Applied,Approved,Rejected';
            OptionMembers = " ",Applied,Approved,Rejected;
        }
        field(9; Comments; Text[50])
        {
            Caption = 'Comments';
        }
        field(10; "Total Week Hours"; Integer)
        {
            Caption = 'Total Week Hours';
        }
        field(11; Section; Code[10])
        {
            Caption = 'Section';
            Editable = false;
        }
        field(12; "Perc Completed"; Decimal)
        {
            Caption = 'Perc Completed';
        }
        field(13; "Class Code"; Code[20])
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
        key(Key2; Class, Curriculum, "Subject Code", "Faculty Code")
        {
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
            AcademicsSetup.TestField("Faculty Class Plan No.");
            NoSeriesMgt.InitSeries(AcademicsSetup."Faculty Class Plan No.", xRec."No.Series", 0D, "No.", "No.Series");
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
        FacultyClassPlanHeader: Record "Faculty Class Plan Header";
        ClassSection: Record "Class Section";

    [Scope('Internal')]
    procedure Assistedit(OldFacultyClassPlanHeader: Record "Faculty Class Plan Header"): Boolean
    begin
        // Start 03.VIGNESH
        with FacultyClassPlanHeader do begin
            FacultyClassPlanHeader := Rec;
            AcademicsSetup.Get;
            AcademicsSetup.TestField("Faculty Class Plan No.");
            if NoSeriesMgt.SelectSeries(AcademicsSetup."Faculty Class Plan No.", OldFacultyClassPlanHeader."No.Series",
               "No.Series")
            then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := FacultyClassPlanHeader;
                exit(true);
            end;
        end;
        // Stop 03.VIGNESH
    end;
}

