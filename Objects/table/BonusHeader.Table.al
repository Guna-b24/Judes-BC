table 72116 "Bonus Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Bonus Header';
    DrillDownPageID = 72160;
    LookupPageID = 72160;

    fields
    {
        field(1; "Bonus Id."; Code[20])
        {
            Caption = 'Bonus Id.';

            trigger OnValidate()
            begin
                if "Bonus Id." <> xRec."Bonus Id." then begin
                    HRPayrollSetup.Get(UserId);
                    LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
                    NoSeriesMgt.TestManual(LocationHRPayrollSetup."Bonus No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(4; "Bonus Year"; Code[20])
        {
            Caption = 'Bonus Year';
        }
        field(5; "Bonus Start Date"; Date)
        {
            Caption = 'Bonus Start Date';
        }
        field(6; "Bonus End Date"; Date)
        {
            Caption = 'Bonus End Date';
        }
        field(7; "Bonus Declare Date"; Date)
        {
            Caption = 'Bonus Declare Date';
        }
        field(8; "Bonus Min No of Years"; Integer)
        {
            Caption = 'Bonus Min No of Years';
        }
        field(9; "Bonus Max No of Years"; Integer)
        {
            Caption = 'Bonus Max No of Years';
        }
        field(10; "Bonusable Earnings Min Limit"; Decimal)
        {
            Caption = 'Bonusable Earnings Min Limit';
        }
        field(11; "Bonusable Earnings Max Limit"; Decimal)
        {
            Caption = 'Bonusable Earnings Max Limit';
        }
        field(12; "Bonus (%)"; Decimal)
        {
            Caption = 'Bonus (%)';
        }
        field(13; "Ex-Gratia (%)"; Decimal)
        {
            Caption = 'Ex-Gratia (%)';
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(15; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Worker Permanent,Worker Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Worker Permanent","Worker Temporary";
        }
        field(16; "Staff Total EL Days"; Decimal)
        {
            Caption = 'Staff Total EL Days';
        }
        field(17; "Staff Total CL Days"; Decimal)
        {
            Caption = 'Staff Total CL Days';
        }
        field(18; "Worker Total EL Days"; Decimal)
        {
            Caption = 'Worker Total EL Days';
        }
        field(19; "Worker Total CL Days"; Decimal)
        {
            Caption = 'Worker Total CL Days';
        }
        field(20; "Total Days In a Year"; Decimal)
        {
            Caption = 'Total Days In a Year';
        }
    }

    keys
    {
        key(Key1; "Bonus Id.")
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
            BonusLine.Reset;
            BonusLine.SetRange("Bonus Id.", "Bonus Id.");
            if BonusLine.FindFirst then begin
                BonusLine.LockTable;
                BonusLine.DeleteAll;
            end;
        end;
    end;

    trigger OnInsert()
    begin
        if "Bonus Id." = '' then begin
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Bonus No.");
            NoSeriesMgt.InitSeries(LocationHRPayrollSetup."Bonus No.", xRec."No. Series", 0D, "Bonus Id.", "No. Series");
        end;

        "Bonus Declare Date" := Today;

        if HRPayrollSetup.Get(UserId) then begin
            "Location Code" := HRPayrollSetup."Location Code";
            "Salary Plan Code" := HRPayrollSetup."Salary Plan Code";
            "Bonus Min No of Years" := LocationHRPayrollSetup."Bonus Min. No of Years";
            "Bonus Max No of Years" := LocationHRPayrollSetup."Bonus Max No of Years";
            "Bonusable Earnings Min Limit" := LocationHRPayrollSetup."Bonusable Earning Min Limit";
            "Bonusable Earnings Max Limit" := LocationHRPayrollSetup."Bonusable Earning Max Limit";
            "Bonus (%)" := LocationHRPayrollSetup."Bonus (%)";
            "Ex-Gratia (%)" := LocationHRPayrollSetup."Ex-Gratia (%)";
        end;

        PayrollYear.Reset;
        PayrollYear.SetRange("Location Code", "Location Code");
        PayrollYear.SetRange("Salary Plan Code", "Salary Plan Code");
        PayrollYear.SetRange("Year Type", PayrollYear."Year Type"::"Bonus Year");
        PayrollYear.SetRange(Closed, false);
        if PayrollYear.FindFirst then begin
            "Bonus Year" := PayrollYear."Year Code";
            "Bonus Start Date" := PayrollYear."Year Start Date";
            "Bonus End Date" := PayrollYear."Year End Date";
        end;
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        PayrollYear: Record "Payroll Year";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BonusLine: Record "Bonus Line";

    [Scope('Internal')]
    procedure AssistEdit(OldBonusHeader: Record "Bonus Header"): Boolean
    var
        BonusHeader: Record "Bonus Header";
    begin
        with BonusHeader do begin
            BonusHeader := Rec;
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Bonus No.");
            if NoSeriesMgt.SelectSeries(LocationHRPayrollSetup."Bonus No.", OldBonusHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Bonus Id.");
                Rec := BonusHeader;
                exit(true);
            end;
        end;
    end;
}

