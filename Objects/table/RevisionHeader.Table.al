table 72091 "Revision Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Revision Header';
    DrillDownPageID = 72129;
    LookupPageID = 72129;

    fields
    {
        field(1; "Pay Revision Id"; Code[20])
        {
            Caption = 'Pay Revision Id';

            trigger OnValidate()
            begin
                if "Pay Revision Id" <> xRec."Pay Revision Id" then begin
                    HRPayrollSetup.Get(UserId);
                    LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
                    NoSeriesMgt.TestManual(LocationHRPayrollSetup."Pay Revision No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Pay Revision Processing Date"; Date)
        {
            Caption = 'Pay Revision Processing Date';
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
        field(5; "New Effective Date"; Date)
        {
            Caption = 'New Effective Date';
        }
        field(6; "Revision Amount"; Decimal)
        {
            Caption = 'Revision Amount';
        }
        field(7; "Revision Percent"; Decimal)
        {
            Caption = 'Revision Percent';
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(9; "Based on"; Option)
        {
            Caption = 'Based on';
            OptionCaption = 'Amount,Percent';
            OptionMembers = Amount,Percent;
        }
        field(10; "Arrears Starting Date"; Date)
        {
            Caption = 'Arrears Starting Date';
        }
        field(11; "Arrears Ending Date"; Date)
        {
            Caption = 'Arrears Ending Date';
        }
        field(12; "Arrears Generated"; Boolean)
        {
            Caption = 'Arrears Generated';
        }
        field(13; "VDA Increase Amount"; Decimal)
        {
            Caption = 'VDA Increase Amount';
        }
        field(14; "VDA Eligible Max Amount"; Decimal)
        {
            Caption = 'VDA Eligible Max Amount';
        }
    }

    keys
    {
        key(Key1; "Pay Revision Id")
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
            RevisionLine.Reset;
            RevisionLine.SetRange("Pay Revision Id", "Pay Revision Id");
            if RevisionLine.FindFirst then begin
                RevisionLine.LockTable;
                RevisionLine.DeleteAll;
            end;
        end;
    end;

    trigger OnInsert()
    begin
        if "Pay Revision Id" = '' then begin
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Pay Revision No.");
            NoSeriesMgt.InitSeries(LocationHRPayrollSetup."Pay Revision No.", xRec."No. Series", 0D, "Pay Revision Id", "No. Series");
        end;

        if HRPayrollSetup.Get(UserId) then begin
            "Location Code" := HRPayrollSetup."Location Code";
            "Salary Plan Code" := HRPayrollSetup."Salary Plan Code";
        end;

        "Pay Revision Processing Date" := Today;
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RevisionLine: Record "Revision Line";
        PayElements: Record "Pay Elements";

    [Scope('Internal')]
    procedure AssistEdit(OldRevisionHeader: Record "Revision Header"): Boolean
    var
        RevisionHeader: Record "Revision Header";
    begin
        with RevisionHeader do begin
            RevisionHeader := Rec;
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Pay Revision No.");
            if NoSeriesMgt.SelectSeries(LocationHRPayrollSetup."Pay Revision No.", OldRevisionHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Pay Revision Id");
                Rec := RevisionHeader;
                exit(true);
            end;
        end;
    end;
}

