table 72110 "Piece Rate Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Piece Rate Header';
    DrillDownPageID = 72146;
    LookupPageID = 72146;

    fields
    {
        field(1; "Piece Rate ID No."; Code[20])
        {
            Caption = 'Piece Rate ID No.';

            trigger OnValidate()
            begin
                if "Piece Rate ID No." <> xRec."Piece Rate ID No." then begin
                    HRPayrollSetup.Get(UserId);
                    LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
                    NoSeriesMgt.TestManual(LocationHRPayrollSetup."Piece Rate No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Piece Rate Entry Date"; Date)
        {
            Caption = 'Piece Rate Entry Date';
            Editable = false;
        }
        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(5; "Salary Cyclic Code"; Code[20])
        {
            Caption = 'Salary Cyclic Code';
            Editable = false;
        }
        field(6; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            Editable = false;
        }
        field(7; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            Editable = false;
        }
        field(8; Remarks; Text[50])
        {
            Caption = 'Remarks';
        }
        field(9; "Creator User Id"; Code[20])
        {
            Caption = 'Creator User Id';
            Editable = false;
        }
        field(10; "Created Date Time"; DateTime)
        {
            Caption = 'Created Date Time';
            Editable = false;
        }
        field(11; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(12; "Posted Date Time"; DateTime)
        {
            Caption = 'Posted Date Time';
            Editable = false;
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
    }

    keys
    {
        key(Key1; "Piece Rate ID No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Confirm('Are Sure to Delete the Records <Yes/No> Delete All Lines..!!') then begin
            PieceRateLine.Reset;
            PieceRateLine.SetRange("Piece Rate ID No.", "Piece Rate ID No.");
            if PieceRateLine.FindFirst then begin
                PieceRateLine.LockTable;
                PieceRateLine.DeleteAll;
            end;
        end;
    end;

    trigger OnInsert()
    begin
        if "Piece Rate ID No." = '' then begin
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Piece Rate No.");
            NoSeriesMgt.InitSeries(LocationHRPayrollSetup."Piece Rate No.", xRec."No. Series", 0D, "Piece Rate ID No.", "No. Series");
        end;

        if HRPayrollSetup.Get(UserId) then begin
            "Location Code" := HRPayrollSetup."Location Code";
            "Salary Plan Code" := HRPayrollSetup."Salary Plan Code";
            "Salary Cyclic Code" := HRPayrollSetup."Salary Cyclic Code";
            "Starting Date" := HRPayrollSetup."Salary Start Date";
            "Ending Date" := HRPayrollSetup."Salary End Date";
        end;

        "Piece Rate Entry Date" := Today;
        "Creator User Id" := UserId;
        "Created Date Time" := CurrentDateTime;
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        Employee: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PieceRateLine: Record "Piece Rate Line";

    [Scope('Internal')]
    procedure AssistEdit(OldPieceRateHeader: Record "Piece Rate Header"): Boolean
    var
        PieceRateHeader: Record "Piece Rate Header";
    begin
        with PieceRateHeader do begin
            PieceRateHeader := Rec;
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Piece Rate No.");
            if NoSeriesMgt.SelectSeries(LocationHRPayrollSetup."Piece Rate No.", OldPieceRateHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Piece Rate ID No.");
                Rec := PieceRateHeader;
                exit(true);
            end;
        end;
    end;
}

