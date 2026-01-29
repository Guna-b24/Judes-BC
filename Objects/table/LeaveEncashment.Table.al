table 72086 "Leave Encashment"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Leave Encashment';

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
        field(3; "Leave Year Code"; Code[20])
        {
            Caption = 'Leave Year Code';
        }
        field(4; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;
        }
        field(5; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(6; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            TableRelation = "Leave Master" WHERE ("Location Code" = FIELD ("Location Code"),
                                                  "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(7; "No of Leave to Encash"; Decimal)
        {
            Caption = 'No of Leave to Encash';

            trigger OnValidate()
            begin
                if "No of Leave to Encash" > "Encash Leave Balance" then
                    Error('No of Leave Encash is Greater than Leave Balance');

                "Encashment Amount" := "No of Leave to Encash" * "Earnings Per Day";
                "Encashment Amount" := Round("Encashment Amount", 1, '=');
            end;
        }
        field(8; "Encash Leave Balance"; Decimal)
        {
            Caption = 'Encash Leave Balance';
        }
        field(9; "Earnings Per Day"; Decimal)
        {
            Caption = 'Earnings Per Day';
        }
        field(10; "Encashment Amount"; Decimal)
        {
            Caption = 'Encashment Amount';
        }
        field(11; "Pay Date"; Date)
        {
            Caption = 'Pay Date';
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Leave Year Code", "Employee No", "Leave Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

