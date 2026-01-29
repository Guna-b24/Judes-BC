table 72105 "Increment Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Increment Line';

    fields
    {
        field(1; "Pay Increment Id"; Code[20])
        {
            Caption = 'Pay Increment Id';
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
        field(4; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            Editable = false;
            TableRelation = Employee;
        }
        field(5; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(7; "Increment Date"; Date)
        {
            Caption = 'Increment Date';
            Editable = false;
        }
        field(8; "Basic Pay"; Decimal)
        {
            Caption = 'Basic Pay';
            Editable = false;
        }
        field(9; "Increment Amount"; Decimal)
        {
            Caption = 'Increment Amount';
            Editable = false;
        }
        field(10; "Revised Basic Pay"; Decimal)
        {
            Caption = 'Revised Basic Pay';
            Editable = false;
        }
        field(11; "Next Increment Date"; Date)
        {
            Caption = 'Next Increment Date';
            Editable = false;
        }
        field(12; "Note Order Printed"; Boolean)
        {
            Caption = 'Note Order Printed';
        }
        field(13; "Sanction Order Printed"; Boolean)
        {
            Caption = 'Sanction Order Printed';
        }
        field(14; "Increment Posted"; Boolean)
        {
            Caption = 'Increment Posted';
        }
        field(15; Month; Integer)
        {
            Caption = 'Month';
        }
        field(16; Year; Integer)
        {
            Caption = 'Year';
        }
    }

    keys
    {
        key(Key1; "Pay Increment Id", "Employee No", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

