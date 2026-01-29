table 72067 "Income Tax Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Income Tax Header';

    fields
    {
        field(1; "Assessment Year"; Code[20])
        {
            Caption = 'Assessment Year';
            TableRelation = "Payroll Year";
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
        field(4; "Tax Deduction Limit"; Decimal)
        {
            Caption = 'Tax Deduction Limit';
        }
        field(5; "Medical Claim Limit"; Decimal)
        {
            Caption = 'Medical Claim Limit';
        }
        field(6; "Physically Handicapped Limit"; Decimal)
        {
            Caption = 'Physically Handicapped Limit';
        }
        field(7; "Housing Loan Interest Limit"; Decimal)
        {
            Caption = 'Housing Loan Interest Limit';
        }
        field(8; "Metro %"; Decimal)
        {
            Caption = 'Metro %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(9; "Non Metro %"; Decimal)
        {
            Caption = 'Non Metro %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(10; "Excess of Rent Paid"; Decimal)
        {
            Caption = 'Excess of Rent Paid';
        }
        field(11; "Max. Conveyance"; Decimal)
        {
            Caption = 'Max. Conveyance';
        }
    }

    keys
    {
        key(Key1; "Assessment Year", "Location Code", "Salary Plan Code")
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
            IncomeTaxLine.Reset;
            IncomeTaxLine.SetRange("Assessment Year", "Assessment Year");
            IncomeTaxLine.SetRange("Location Code", "Location Code");
            IncomeTaxLine.SetRange("Salary Plan Code", "Salary Plan Code");
            if IncomeTaxLine.FindFirst then begin
                IncomeTaxLine.LockTable;
                IncomeTaxLine.DeleteAll;
            end;
        end;
    end;

    var
        IncomeTaxLine: Record "Income Tax Line";
}

