table 71065 "Exam Schedule Head - SCH"
{
    Caption = 'Exam Schedule Head - SCH';
    DrillDownPageID = 71108;
    LookupPageID = 71108;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AcademicsSetup.Get;
                    NoSeriesManagement.TestManual(AcademicsSetup."Exam Schedule No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; "Exam Code"; Code[20])
        {
            Caption = 'Exam Code';
            TableRelation = "Exam Code";
        }
        field(5; "Exam Slot"; Code[20])
        {
            Caption = 'Exam Slot';
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(8; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(9; "End Time"; Time)
        {
            Caption = 'End Time';
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
        AcademicsSetup.Get;
        if "No." = '' then begin
            AcademicsSetup.TestField("Exam Schedule No.");
            NoSeriesManagement.InitSeries(AcademicsSetup."Exam Schedule No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Academic Year" := EducationVertical.GetAcademicYear;
        "User ID" := UserId;
    end;

    var
        CompanyInPageation: Record "Company Information";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        AcademicsSetup: Record "Academics Setup";
        ExamScheduleHead: Record "Exam Schedule Head - SCH";
        EducationVertical: Codeunit "Education Vertical";

    [Scope('Internal')]
    procedure AssistEdit(OldExamScheduleHead: Record "Exam Schedule Head - SCH"): Boolean
    begin
        with ExamScheduleHead do begin
            ExamScheduleHead := Rec;
            AcademicsSetup.Get;
            AcademicsSetup.TestField("Exam Schedule No.");
            if NoSeriesManagement.SelectSeries(AcademicsSetup."Exam Schedule No.",
               OldExamScheduleHead."No. Series", "No. Series")
            then begin
                NoSeriesManagement.SetSeries("No.");
                Rec := ExamScheduleHead;
                exit(true);
            end;
        end;
    end;
}

