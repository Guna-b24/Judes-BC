table 71065 "Exam Schedule Head - SCH"
{
    Caption = 'Exam Schedule Head - SCH';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71108;
    // LookupPageID = 71108;

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
                    NoSeriesManagement.TestManual(AcademicsSetup."Exam Schedule No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }

        field(4; "Exam Code"; Code[20])
        {
            Caption = 'Exam Code';
            TableRelation = "Exam Code";
            DataClassification = CustomerContent;
        }

        field(5; "Exam Slot"; Code[20])
        {
            Caption = 'Exam Slot';
            DataClassification = CustomerContent;
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = SystemMetadata;
        }

        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }

        field(8; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
        }
        field(9; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = SystemMetadata;
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
            AcademicsSetup.TestField("Exam Schedule No.");
            "No. Series" := AcademicsSetup."Exam Schedule No.";
            "No." := NoSeriesManagement.GetNextNo("No. Series");
        end;

        "Academic Year" := EducationVertical.GetAcademicYear();

    end;

    var
        AcademicsSetup: Record "Academics Setup";
        ExamScheduleHead: Record "Exam Schedule Head - SCH";
        EducationVertical: Codeunit "Education Vertical";
        NoSeriesManagement: Codeunit "No. Series";

    procedure AssistEdit(OldExamScheduleHead: Record "Exam Schedule Head - SCH"): Boolean
    begin

        ExamScheduleHead := Rec;
        AcademicsSetup.Get();
        AcademicsSetup.TestField("Exam Schedule No.");
        if NoSeriesManagement.LookupRelatedNoSeries(AcademicsSetup."Exam Schedule No.",
           OldExamScheduleHead."No. Series", "No. Series")
        then begin
            ExamScheduleHead."No." := NoSeriesManagement.GetNextNo(ExamScheduleHead."No. Series");
            Rec := ExamScheduleHead;
            exit(true);
        end;
    end;

}

