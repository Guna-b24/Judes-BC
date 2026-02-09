table 72116 "Bonus Header"
{
    Caption = 'Bonus Header';
    // DrillDownPageID = 72160;
    // LookupPageID = 72160;

    fields
    {
        field(1; "Bonus Id."; Code[20])
        {
            Caption = 'Bonus Id.';
            DataClassification = CustomerContent;

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
            DataClassification = CustomerContent;
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }
        field(4; "Bonus Year"; Code[20])
        {
            Caption = 'Bonus Year';
            DataClassification = CustomerContent;
        }
        field(5; "Bonus Start Date"; Date)
        {
            Caption = 'Bonus Start Date';
            DataClassification = CustomerContent;
        }
        field(6; "Bonus End Date"; Date)
        {
            Caption = 'Bonus End Date';
            DataClassification = CustomerContent;
        }
        field(7; "Bonus Declare Date"; Date)
        {
            Caption = 'Bonus Declare Date';
            DataClassification = CustomerContent;
        }
        field(8; "Bonus Min No of Years"; Integer)
        {
            Caption = 'Bonus Min No of Years';
            DataClassification = CustomerContent;
        }
        field(9; "Bonus Max No of Years"; Integer)
        {
            Caption = 'Bonus Max No of Years';
            DataClassification = CustomerContent;
        }
        field(10; "Bonusable Earnings Min Limit"; Decimal)
        {
            Caption = 'Bonusable Earnings Min Limit';
            DataClassification = CustomerContent;
        }
        field(11; "Bonusable Earnings Max Limit"; Decimal)
        {
            Caption = 'Bonusable Earnings Max Limit';
            DataClassification = CustomerContent;
        }
        field(12; "Bonus (%)"; Decimal)
        {
            Caption = 'Bonus (%)';
            DataClassification = CustomerContent;
        }
        field(13; "Ex-Gratia (%)"; Decimal)
        {
            Caption = 'Ex-Gratia (%)';
            DataClassification = CustomerContent;
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(15; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Worker Permanent,Worker Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Worker Permanent","Worker Temporary";
        }
        field(16; "Staff Total EL Days"; Decimal)
        {
            Caption = 'Staff Total EL Days';
            DataClassification = CustomerContent;
        }
        field(17; "Staff Total CL Days"; Decimal)
        {
            Caption = 'Staff Total CL Days';
            DataClassification = CustomerContent;
        }
        field(18; "Worker Total EL Days"; Decimal)
        {
            Caption = 'Worker Total EL Days';
            DataClassification = CustomerContent;
        }
        field(19; "Worker Total CL Days"; Decimal)
        {
            Caption = 'Worker Total CL Days';
            DataClassification = CustomerContent;
        }
        field(20; "Total Days In a Year"; Decimal)
        {
            Caption = 'Total Days In a Year';
            DataClassification = CustomerContent;
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
            BonusLine.Reset();
            BonusLine.SetRange("Bonus Id.", "Bonus Id.");
            if BonusLine.FindFirst() then begin
                BonusLine.LockTable();
                BonusLine.DeleteAll();
            end;
        end;
    end;

    trigger OnInsert()
    begin
        if "Bonus Id." = '' then begin
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Bonus No.");
            "No. Series" := LocationHRPayrollSetup."Bonus No.";
            "Bonus Id." := NoSeriesMgt.GetNextNo("No. Series");
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

        PayrollYear.Reset();
        PayrollYear.SetRange("Location Code", "Location Code");
        PayrollYear.SetRange("Salary Plan Code", "Salary Plan Code");
        PayrollYear.SetRange("Year Type", PayrollYear."Year Type"::"Bonus Year");
        PayrollYear.SetRange(Closed, false);
        if PayrollYear.FindFirst() then begin
            "Bonus Year" := PayrollYear."Year Code";
            "Bonus Start Date" := PayrollYear."Year Start Date";
            "Bonus End Date" := PayrollYear."Year End Date";
        end;
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        PayrollYear: Record "Payroll Year";
        BonusLine: Record "Bonus Line";
        NoSeriesMgt: Codeunit "No. Series";

    procedure AssistEdit(OldBonusHeader: Record "Bonus Header"): Boolean
    var
        BonusHeader: Record "Bonus Header";
    begin

        BonusHeader := Rec;
        HRPayrollSetup.Get(UserId);
        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
        LocationHRPayrollSetup.TestField("Bonus No.");
        if NoSeriesMgt.LookupRelatedNoSeries(LocationHRPayrollSetup."Bonus No.", OldBonusHeader."No. Series", "No. Series") then begin
            BonusHeader."Bonus Id." := NoSeriesMgt.GetNextNo(BonusHeader."Bonus Id.");
            Rec := BonusHeader;
            exit(true);
        end;
    end;
}

