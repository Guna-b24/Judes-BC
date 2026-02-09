table 72119 "Bonus Misc Add/Deductions"
{
    Caption = 'Bonus Misc Add/Deductions';
    // DrillDownPageID = 72163;
    // LookupPageID = 72163;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }
        field(3; "Bonus ID."; Code[20])
        {
            Caption = 'Bonus ID.';
            DataClassification = CustomerContent;
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
            DataClassification = CustomerContent;

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
            DataClassification = CustomerContent;
        }
        field(6; "Bonus Year Code"; Code[20])
        {
            Caption = 'Bonus Year Code';
            DataClassification = CustomerContent;
        }
        field(7; "Bonus Start Date"; Date)
        {
            Caption = 'Bonus Start Date';
            DataClassification = CustomerContent;
        }
        field(8; "Bonus End Date"; Date)
        {
            Caption = 'Bonus End Date';
            DataClassification = CustomerContent;
        }
        field(9; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(10; "Paid Category"; Option)
        {
            Caption = 'Paid Category';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Monthly,Yearly';
            OptionMembers = Monthly,Yearly;
        }
        field(11; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(13; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(16; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(17; "CL / EL Paid Days"; Decimal)
        {
            Caption = 'CL / EL Paid Days';
            DataClassification = CustomerContent;
        }
        field(18; "System Generated"; Boolean)
        {
            Caption = 'System Generated';
            DataClassification = SystemMetadata;
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

