table 72073 "Medical Reimbu. Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Medical Reimbu. Line';

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
        field(6; "Reimburesment Date"; Date)
        {
            Caption = 'Reimburesment Date';
            NotBlank = true;
        }
        field(7; "Bill No."; Text[30])
        {
            Caption = 'Bill No.';
            NotBlank = true;
        }
        field(8; "Bill Date"; Date)
        {
            Caption = 'Bill Date';
        }
        field(9; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; "Bill Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Bill Amount';
            MinValue = 0;
        }
        field(11; Blocked; Boolean)
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
            SumIndexFields = "Bill Amount";
        }
    }

    fieldgroups
    {
    }
}

