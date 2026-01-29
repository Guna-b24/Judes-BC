table 72071 "Insurance Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Insurance Line';

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(4; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(6; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            NotBlank = true;
        }
        field(7; "Policy No."; Text[30])
        {
            Caption = 'Policy No.';
        }
        field(8; "Policy Date"; Date)
        {
            Caption = 'Policy Date';
        }
        field(9; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; "Premium Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Premium Amount';
            MinValue = 0;
        }
        field(11; "Insured Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Insured Amount';
        }
        field(12; "Matured Date"; Date)
        {
            Caption = 'Matured Date';
        }
        field(13; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Pay Element Code", "Location Code", "Salary Plan Code", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Blocked)
        {
            SumIndexFields = "Premium Amount", "Insured Amount";
        }
    }

    fieldgroups
    {
    }
}

