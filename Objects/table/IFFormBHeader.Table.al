table 72113 "IF Form B Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'IF Form B Header';
    DrillDownPageID = 72153;
    LookupPageID = 72153;

    fields
    {
        field(1; "Form B Id"; Code[20])
        {
            Caption = 'Page B Id';

            trigger OnValidate()
            begin
                if "Form B Id" <> xRec."Form B Id" then begin
                    HRPayrollSetup.Get(UserId);
                    LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
                    NoSeriesMgt.TestManual(LocationHRPayrollSetup."Pay Revision No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
            Editable = false;
        }
        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = "Location HR & Payroll Setup";
        }
        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            Editable = false;
            TableRelation = "Salary Plan";
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
    }

    keys
    {
        key(Key1; "Form B Id")
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
            IFFormBLine.Reset;
            IFFormBLine.SetRange("Form B Id", "Form B Id");
            if IFFormBLine.FindFirst then begin
                IFFormBLine.LockTable;
                IFFormBLine.DeleteAll;
            end;
        end;
    end;

    trigger OnInsert()
    begin
        if "Form B Id" = '' then begin
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Pay Revision No.");
            NoSeriesMgt.InitSeries(LocationHRPayrollSetup."Pay Revision No.", xRec."No. Series", 0D, "Form B Id", "No. Series");
        end;

        if HRPayrollSetup.Get(UserId) then begin
            "Location Code" := HRPayrollSetup."Location Code";
            "Salary Plan Code" := HRPayrollSetup."Salary Plan Code";
        end;

        "Processed Date" := Today;
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IFFormBLine: Record "IF Form B Line";
        PayElements: Record "Pay Elements";

    [Scope('Internal')]
    procedure AssistEdit(OldIFFormBHeader: Record "IF Form B Header"): Boolean
    var
        IFFormBHeader: Record "IF Form B Header";
    begin
        with IFFormBHeader do begin
            IFFormBHeader := Rec;
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Pay Revision No.");
            if NoSeriesMgt.SelectSeries(LocationHRPayrollSetup."Pay Revision No.", OldIFFormBHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Form B Id");
                Rec := IFFormBHeader;
                exit(true);
            end;
        end;
    end;
}

