table 72114 "IF Form B Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'IF Form B Line';

    fields
    {
        field(1; "Form B Id"; Code[20])
        {
            Caption = 'Page B Id';
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
        field(4; Month; Integer)
        {
            Caption = 'Month';
            MaxValue = 12;
            MinValue = 0;
        }
        field(5; Year; Integer)
        {
            Caption = 'Year';
            MaxValue = 9999;
            MinValue = 0;
        }
        field(6; "Total No of Employees"; Integer)
        {
            Caption = 'Total No of Employees';
        }
        field(7; "Basic Wages"; Decimal)
        {
            Caption = 'Basic Wages';

            trigger OnValidate()
            begin
                Validate("Total Amount");
            end;
        }
        field(8; "D.A Amount"; Decimal)
        {
            Caption = 'D.A Amount';

            trigger OnValidate()
            begin
                Validate("Total Amount");
            end;
        }
        field(9; "Over Time Amount"; Decimal)
        {
            Caption = 'Over Time Amount';

            trigger OnValidate()
            begin
                Validate("Total Amount");
            end;
        }
        field(10; "Bonus Amount"; Decimal)
        {
            Caption = 'Bonus Amount';

            trigger OnValidate()
            begin
                Validate("Total Amount");
            end;
        }
        field(11; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;

            trigger OnValidate()
            begin
                "Total Amount" := "Basic Wages" + "D.A Amount" + "Over Time Amount" + "Bonus Amount";
            end;
        }
        field(12; "Fine Amount"; Decimal)
        {
            Caption = 'Fine Amount';
        }
        field(13; "Other Deductions"; Decimal)
        {
            Caption = 'Other Deductions';
        }
        field(14; "Amount Actually Paid"; Decimal)
        {
            Caption = 'Amount Actually Paid';
        }
        field(15; "Balance Due to the Employee"; Decimal)
        {
            Caption = 'Balance Due to the Employee';
        }
        field(16; Remarks; Text[50])
        {
            Caption = 'Remarks';
        }
    }

    keys
    {
        key(Key1; "Form B Id", "Location Code", "Salary Plan Code", Month, Year)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

