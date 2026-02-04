table 72094 "Arrears Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Arrears Line';
    // DrillDownPageID = 72136;
    // LookupPageID = 72136;

    fields
    {
        field(1; "Arrears Id"; Code[20])
        {
            Caption = 'Arrears Id';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
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
        field(5; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
        }
        field(6; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
        }
        field(7; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
        }
        field(8; Year; Integer)
        {
            Caption = 'Year';
        }
        field(9; Month; Integer)
        {
            Caption = 'Month';
        }
        field(10; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(11; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            NotBlank = true;
            TableRelation = "Professional Tax Line";
        }
        field(12; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
        }
        field(13; "Total Days in a Month"; Integer)
        {
            Caption = 'Total Days in a Month';
        }
        field(14; "Paid Days"; Decimal)
        {
            Caption = 'Paid Days';
        }
        field(15; "Actual Amount"; Decimal)
        {
            Caption = 'Actual Amount';
        }
        field(16; "Payable Amount"; Decimal)
        {
            Caption = 'Payable Amount';
        }
        field(17; "Difference Amount / Percent(%)"; Decimal)
        {
            Caption = 'Difference Amount / Percent(%)';
        }
        field(18; "Arrear Amount"; Decimal)
        {
            Caption = 'Arrear Amount';
        }
        field(19; "PF Gross Earnings"; Decimal)
        {
            Caption = 'PF Gross Earnings';
        }
        field(20; "Employee PF Amount"; Decimal)
        {
            Caption = 'Employee PF Amount';
        }
        field(21; "Employer PF Amount"; Decimal)
        {
            Caption = 'Employer PF Amount';
        }
        field(22; "Employer EPS Amount"; Decimal)
        {
            Caption = 'Employer EPS Amount';
        }
        field(23; "PF Admin Charges Amount"; Decimal)
        {
            Caption = 'PF Admin Charges Amount';
        }
        field(24; "PF EDLI Amount"; Decimal)
        {
            Caption = 'PF EDLI Amount';
        }
        field(25; "PF RIFA Amount"; Decimal)
        {
            Caption = 'PF RIFA Amount';
        }
        field(26; "Fixed/Percent"; Option)
        {
            Caption = 'Fixed/Percent';
            Editable = false;
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
        }
    }

    keys
    {
        key(Key1; "Arrears Id", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No")
        {
            SumIndexFields = "Arrear Amount";
        }
        key(Key3; "Salary Cycle Code", "Employee No", "Sorting Order")
        {
        }
    }

    fieldgroups
    {
    }
}

