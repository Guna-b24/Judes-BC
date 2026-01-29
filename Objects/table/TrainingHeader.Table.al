table 72024 "Training Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Training Header';
    DataCaptionFields = "Training No.", "Department Code", "Department Description";
    DrillDownPageID = 72037;
    LookupPageID = 72037;

    fields
    {
        field(1; "Training No."; Code[20])
        {
            Caption = 'Training No.';

            trigger OnValidate()
            begin
                if "Training No." <> xRec."Training No." then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Training SNo");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(3; "Department Description"; Text[30])
        {
            Caption = 'Department Description';
        }
        field(4; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = Training;

            trigger OnValidate()
            begin
                if Training.Get("Course Code") then
                    "Course Description" := Training.Description;
            end;
        }
        field(5; "Course Description"; Text[50])
        {
            Caption = 'Course Description';
            Editable = false;
        }
        field(6; "Training Facility"; Option)
        {
            Caption = 'Training Facility';
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(7; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(8; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                "No. of Days" := Abs(("Ending Date" - "Starting Date") + 1);
            end;
        }
        field(9; Date; Date)
        {
            Caption = 'Date';
            Editable = false;
        }
        field(10; "Training Hour / Day"; Duration)
        {
            Caption = 'Training Hour / Day';
            Editable = false;
        }
        field(11; "Total Training Hour"; Duration)
        {
            Caption = 'Total Training Hour';
            Editable = false;
        }
        field(12; "No. of Days"; Integer)
        {
            Caption = 'No. of Days';
            Editable = false;
        }
        field(13; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
        }
        field(14; "Ending Time"; Time)
        {
            Caption = 'Ending Time';

            trigger OnValidate()
            begin
                if ("Starting Time" <> 0T) and ("Ending Time" <> 0T) then
                    "Training Hour / Day" := Abs("Ending Time" - "Starting Time");

                "Total Training Hour" := "Training Hour / Day" * "No. of Days";
            end;
        }
        field(15; Notes; Text[100])
        {
            Caption = 'Notes';
        }
        field(16; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(17; Comment; Boolean)
        {
            CalcFormula = Exist ("Human Resource Comment Line" WHERE ("Table Name" = CONST ("8"),
                                                                     "No." = FIELD ("Training No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Training No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Training No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Training SNo");
            NoSeriesMgt.InitSeries(HRSetup."Training SNo", xRec."No. Series", 0D, "Training No.", "No. Series");
        end;

        Date := Today;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Training: Record Training;

    [Scope('Internal')]
    procedure AssistEdit(TrainingHeader: Record "Training Header"): Boolean
    begin
        with TrainingHeader do begin
            TrainingHeader := Rec;
            HRSetup.Get;
            HRSetup.TestField("Training SNo");
            if NoSeriesMgt.SelectSeries(HRSetup."Training SNo", "No. Series", "No. Series") then begin
                HRSetup.Get;
                HRSetup.TestField("Training SNo");
                NoSeriesMgt.SetSeries("Training No.");
                Rec := TrainingHeader;
                exit(true);
            end;
        end;
    end;
}

