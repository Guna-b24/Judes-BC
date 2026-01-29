table 72068 "Income Tax Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Income Tax Line';

    fields
    {
        field(1; "Assessment Year"; Code[20])
        {
            Caption = 'Assessment Year';
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
        field(4; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = 'Male,Female,Sr.Citizen';
            OptionMembers = Male,Female,"Sr.Citizen";
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
        field(8; "Tax %"; Decimal)
        {
            Caption = 'Tax %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(9; "Surcharge %"; Decimal)
        {
            Caption = 'Surcharge %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(10; "E-CESS %"; Decimal)
        {
            Caption = 'E-CESS %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(11; "SHE-CESS %"; Decimal)
        {
            Caption = 'SHE-CESS %';
            MaxValue = 100;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Assessment Year", "Location Code", "Salary Plan Code", Gender, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

