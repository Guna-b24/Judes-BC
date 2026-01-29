table 72066 "Professional Tax Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Professional Tax Line';

    fields
    {
        field(1; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
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
        field(4; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(6; "Income From"; Decimal)
        {
            Caption = 'Income From';
        }
        field(7; "Income To"; Decimal)
        {
            Caption = 'Income To';
        }
        field(8; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';
        }
    }

    keys
    {
        key(Key1; "Effective Date", "Location Code", "Salary Plan Code", "Branch Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

