table 71170 "Class Syllabus Header"
{
    Caption = 'Class Syllabus Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the unique number for the class syllabus.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                // Start 02.VIGNESH
                if "No." <> xRec."No." then begin
                    AcademicsSetup.Get();
                    NoSeriesMgt.TestManual(AcademicsSetup."Class Syllabus No.");
                    "No.Series" := '';
                end;
                // Stop 02.VIGNESH
            end;
        }
        field(2; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            ToolTip = 'Specifies the class for which the syllabus is created.';
            TableRelation = Class;
            DataClassification = CustomerContent;
        }
        field(3; Curriculam; Code[10])
        {
            Caption = 'Curriculam';
            ToolTip = 'Specifies the curriculum applicable to the syllabus.';
            TableRelation = Curriculum;
            DataClassification = CustomerContent;
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            ToolTip = 'Specifies the subject covered by the syllabus.';
            TableRelation = Subject;
            DataClassification = CustomerContent;
        }
        field(5; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year for the syllabus.';
            TableRelation = "Academic Year";
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "No.Series"; Code[20])
        {
            Caption = 'No. Series';
            ToolTip = 'Specifies the number series used to generate the syllabus number.';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the external portal reference ID.';
            DataClassification = CustomerContent;
        }
        field(70784; Department; Code[20])
        {
            Caption = 'Department';
            ToolTip = 'Specifies the department responsible for the syllabus.';
            TableRelation = Department;
            DataClassification = CustomerContent;
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

        if "No." = '' then begin
            AcademicsSetup.Get();
            AcademicsSetup.TestField("Class Syllabus No.");
            "No.Series" := AcademicsSetup."Class Syllabus No.";
            "No." := NoSeriesMgt.GetNextNo("No.Series");
        end;
    end;


    var
        AcademicsSetup: Record "Academics Setup";
        ClassSyllabusHeader: Record "Class Syllabus Header";

        NoSeriesMgt: Codeunit "No. Series";
    //EduVertical: Codeunit "Education Vertical";

    procedure Assistedit(OldClassSyllabusHeader: Record "Class Syllabus Header"): Boolean
    begin

        ClassSyllabusHeader := Rec;
        AcademicsSetup.Get();
        AcademicsSetup.TestField("Class Syllabus No.");
        if NoSeriesMgt.LookupRelatedNoSeries(AcademicsSetup."Class Syllabus No.", OldClassSyllabusHeader."No.Series",
           "No.Series")
        then begin
            ClassSyllabusHeader."No." := NoSeriesMgt.GetNextNo(ClassSyllabusHeader."No.Series");
            Rec := ClassSyllabusHeader;
            exit(true);
        end;
    end;


}

