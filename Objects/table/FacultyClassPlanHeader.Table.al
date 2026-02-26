table 71172 "Faculty Class Plan Header"
{
    Caption = 'Faculty Class Plan Header';
    DataClassification = CustomerContent;
    LookupPageId = "Faculty Class Plan List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AcademicsSetup.Get();
                    NoSeriesMgt.TestManual(AcademicsSetup."Faculty Class Plan No.");
                    "No.Series" := '';
                end;
            end;
        }
        field(2; Class; Code[20])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculam Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = Subject;
        }
        field(5; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = SystemMetadata;
        }
        field(7; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(8; "Plan Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Applied,Approved,Rejected';
            OptionMembers = " ",Applied,Approved,Rejected;
        }
        field(9; Comments; Text[50])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
        field(10; "Total Week Hours"; Integer)
        {
            Caption = 'Total Week Hours';
            DataClassification = CustomerContent;
        }
        field(11; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Perc Completed"; Decimal)
        {
            Caption = 'Perc Completed';
            DataClassification = CustomerContent;
        }
        field(13; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            DataClassification = CustomerContent;
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
        field(70784; Department; Code[20])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
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


        if "No." = '' then begin
            AcademicsSetup.Get();
            AcademicsSetup.TestField("Faculty Class Plan No.");
            "No.Series" := AcademicsSetup."Faculty Class Plan No.";
            "No." := NoSeriesMgt.GetNextNo("No.Series");
        end;

        "Academic Year" := EduVertical.GetAcademicYear();

    end;

    var
        AcademicsSetup: Record "Academics Setup";

        FacultyClassPlanHeader: Record "Faculty Class Plan Header";
        ClassSection: Record "Class Section";
        NoSeriesMgt: Codeunit "No. Series";
        EduVertical: Codeunit "Education Vertical";

    procedure Assistedit(OldFacultyClassPlanHeader: Record "Faculty Class Plan Header"): Boolean
    begin

        FacultyClassPlanHeader := Rec;
        AcademicsSetup.Get();
        AcademicsSetup.TestField("Faculty Class Plan No.");
        if NoSeriesMgt.LookupRelatedNoSeries(AcademicsSetup."Faculty Class Plan No.", OldFacultyClassPlanHeader."No.Series",
           "No.Series")
        then begin
            FacultyClassPlanHeader."No." := NoSeriesMgt.GetNextNo(FacultyClassPlanHeader."No.Series");
            Rec := FacultyClassPlanHeader;
            exit(true);
        end;
    end;
}

