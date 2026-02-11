table 72067 "Income Tax Header"
{
    Caption = 'Income Tax Header';

    fields
    {
        field(1; "Assessment Year"; Code[20])
        {
            Caption = 'Assessment Year';
            ToolTip = 'Specifies the income tax assessment year.';
            TableRelation = "Payroll Year";
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the payroll location for income tax setup.';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            ToolTip = 'Specifies the salary plan applicable for income tax calculation.';
            TableRelation = "Salary Plan";
        }
        field(4; "Tax Deduction Limit"; Decimal)
        {
            Caption = 'Tax Deduction Limit';
            ToolTip = 'Specifies the maximum allowable tax deduction limit.';
        }
        field(5; "Medical Claim Limit"; Decimal)
        {
            Caption = 'Medical Claim Limit';
            ToolTip = 'Specifies the maximum limit allowed for medical claims.';
        }
        field(6; "Physically Handicapped Limit"; Decimal)
        {
            Caption = 'Physically Handicapped Limit';
            ToolTip = 'Specifies the deduction limit for physically handicapped employees.';
        }
        field(7; "Housing Loan Interest Limit"; Decimal)
        {
            Caption = 'Housing Loan Interest Limit';
            ToolTip = 'Specifies the maximum deductible housing loan interest amount.';
        }
        field(8; "Metro %"; Decimal)
        {
            Caption = 'Metro Percentage';
            ToolTip = 'Specifies the percentage of exemption applicable for metro cities.';
            MinValue = 0;
            MaxValue = 100;
        }
        field(9; "Non Metro %"; Decimal)
        {
            Caption = 'Non-Metro Percentage';
            ToolTip = 'Specifies the percentage of exemption applicable for non-metro cities.';
            MinValue = 0;
            MaxValue = 100;
        }
        field(10; "Excess of Rent Paid"; Decimal)
        {
            Caption = 'Excess of Rent Paid';
            ToolTip = 'Specifies the excess rent paid eligible for tax exemption.';
        }
        field(11; "Max. Conveyance"; Decimal)
        {
            Caption = 'Maximum Conveyance';
            ToolTip = 'Specifies the maximum conveyance allowance eligible for exemption.';
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
            IncomeTaxLine.Reset();
            IncomeTaxLine.SetRange("Assessment Year", "Assessment Year");
            IncomeTaxLine.SetRange("Location Code", "Location Code");
            IncomeTaxLine.SetRange("Salary Plan Code", "Salary Plan Code");
            if IncomeTaxLine.FindFirst() then begin
                IncomeTaxLine.LockTable();
                IncomeTaxLine.DeleteAll();
            end;
        end;
    end;

    var
        IncomeTaxLine: Record "Income Tax Line";
}

