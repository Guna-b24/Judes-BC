table 72085 "Leave Credited"
{
    Caption = 'Leave Credited';
    // DrillDownPageID = 72117;
    // LookupPageID = 72117;

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
        field(3; "Leave Start Date"; Date)
        {
            Caption = 'Leave Start Date';
        }
        field(4; "Leave End Date"; Date)
        {
            Caption = 'Leave End Date';
        }
        field(5; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;
        }
        field(6; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
        }
        field(7; "No. of Leaves"; Decimal)
        {
            Caption = 'No. of Leaves';
        }
        field(8; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(9; "Leave Year Code"; Code[20])
        {
            Caption = 'Leave Year Code';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Employee No", "Leave Code", "Leave Start Date", "Leave End Date", "Leave Year Code")
        {
            Clustered = true;
        }
        key(Key2; "No. of Leaves")
        {
            SumIndexFields = "No. of Leaves";
        }
    }

    fieldgroups
    {
    }
}

