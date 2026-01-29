table 72119 "Bonus Misc Add/Deductions"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Bonus Misc Add/Deductions';
    DrillDownPageID = 72163;
    LookupPageID = 72163;

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
        field(3; "Bonus ID."; Code[20])
        {
            Caption = 'Bonus ID.';
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then
                    Name := Employee."First Name" + ' ' + Employee.Initials
                else
                    Name := '';
            end;
        }
        field(5; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
        }
        field(6; "Bonus Year Code"; Code[20])
        {
            Caption = 'Bonus Year Code';
        }
        field(7; "Bonus Start Date"; Date)
        {
            Caption = 'Bonus Start Date';
        }
        field(8; "Bonus End Date"; Date)
        {
            Caption = 'Bonus End Date';
        }
        field(9; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(10; "Paid Category"; Option)
        {
            Caption = 'Paid Category';
            Editable = false;
            OptionCaption = 'Monthly,Yearly';
            OptionMembers = Monthly,Yearly;
        }
        field(11; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            Editable = false;
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(13; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(14; "User Id"; Code[20])
        {
            Caption = 'User Id';
        }
        field(15; Month; Integer)
        {
            Caption = 'Month';
        }
        field(16; Year; Integer)
        {
            Caption = 'Year';
        }
        field(17; "CL / EL Paid Days"; Decimal)
        {
            Caption = 'CL / EL Paid Days';
        }
        field(18; "System Generated"; Boolean)
        {
            Caption = 'System Generated';
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Bonus ID.", "Employee No.", "Pay Element Code")
        {
            Clustered = true;
        }
        key(Key2; "Pay Type")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
}

