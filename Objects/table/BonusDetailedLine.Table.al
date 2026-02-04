table 72118 "Bonus Detailed Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Bonus Detailed Line';
    // DrillDownPageID = 72161;
    // LookupPageID = 72161;

    fields
    {
        field(1; "Bonus Id."; Code[20])
        {
            Caption = 'Bonus Id.';
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
        field(4; "Bonus Year"; Code[20])
        {
            Caption = 'Bonus Year';
        }
        field(5; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            TableRelation = "Payroll Month & Year" WHERE("Location Code" = FIELD("Location Code"),
                                                          "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(6; "Employee No"; Code[20])
        {
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    Name := Employee."First Name" + ' ' + Employee.Initials;
                    "Employee Category" := Employee."Employee Category";
                end
                else begin
                    Name := '';
                    "Employee Category" := "Employee Category"::" ";
                end;
            end;
        }
        field(7; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(8; "Days Worked"; Decimal)
        {
            Caption = 'Days Worked';
        }
        field(9; "Bonusable Earnings"; Decimal)
        {
            Caption = 'Bonusable Earnings';
        }
        field(10; "Projection Not Required"; Boolean)
        {
            Caption = 'Projection Not Required';
        }
        field(11; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Worker Permanent,Worker Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Worker Permanent","Worker Temporary";
        }
    }

    keys
    {
        key(Key1; "Employee No", "Bonus Id.", "Location Code", "Salary Plan Code", "Bonus Year", "Salary Cycle Code")
        {
            Clustered = true;
            SumIndexFields = "Days Worked", "Bonusable Earnings";
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
}

