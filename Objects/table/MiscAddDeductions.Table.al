table 72089 "Misc Add/Deductions"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Misc Add/Deductions';

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
        }
        field(3; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
        }
        field(4; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
        }
        field(5; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
        }
        field(6; Year; Integer)
        {
            Caption = 'Year';
        }
        field(7; Month; Integer)
        {
            Caption = 'Month';
        }
        field(8; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;
        }
        field(9; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            TableRelation = "Pay Elements" WHERE ("Location Code" = FIELD ("Location Code"),
                                                  "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(10; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(11; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            Editable = false;
            OptionCaption = 'Monthly,Yearly';
            OptionMembers = Monthly,Yearly;
        }
        field(12; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            Editable = false;
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(14; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(15; "User Id"; Code[20])
        {
            Caption = 'User Id';
        }
        field(16; "Element Type"; Option)
        {
            Caption = 'Element Type';
            OptionCaption = ' ,OT Calculation';
            OptionMembers = " ","OT Calculation";
        }
        field(17; "Total OT Hours"; Decimal)
        {
            Caption = 'Total OT Hours';
        }
        field(18; "OT Type"; Option)
        {
            Caption = 'OT Type';
            OptionCaption = ' ,Fixed Amount,Hourly Based';
            OptionMembers = " ","Fixed Amount","Hourly Based";
        }
        field(19; "OT Fixed Amount"; Decimal)
        {
            Caption = 'OT Fixed Amount';
        }
        field(20; "Paid Category"; Option)
        {
            Caption = 'Paid Category';
            OptionCaption = 'Monthly,Yearly,Daily';
            OptionMembers = Monthly,Yearly,Daily;
        }
        field(30; Gender; Option)
        {
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(31; "Pay Category"; Option)
        {
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary";
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Salary Cycle Code", "Employee No", "Pay Element Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

