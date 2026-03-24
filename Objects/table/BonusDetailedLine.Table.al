table 72118 "Bonus Detailed Line"
{
    Caption = 'Bonus Detailed Line';
    DataClassification = CustomerContent;
    DrillDownPageID = "Bonus Detailed Line List";
    LookupPageID = "Bonus Detailed Line List";

    fields
    {
        field(1; "Bonus Id."; Code[20])
        {
            Caption = 'Bonus Id.';
            ToolTip = 'Specifies the bonus document identifier.';
            DataClassification = CustomerContent;
        }

        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the location applicable for the bonus calculation.';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            ToolTip = 'Specifies the salary plan under which the bonus is calculated.';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }

        field(4; "Bonus Year"; Code[20])
        {
            Caption = 'Bonus Year';
            ToolTip = 'Specifies the bonus year.';
            DataClassification = CustomerContent;
        }
        field(5; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            ToolTip = 'Specifies the salary cycle for the bonus calculation.';
            TableRelation = "Payroll Month & Year" WHERE(
                                "Location Code" = FIELD("Location Code"),
                                "Salary Plan Code" = FIELD("Salary Plan Code"));
            DataClassification = CustomerContent;
        }

        field(6; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            ToolTip = 'Specifies the employee number.';
            DataClassification = CustomerContent;


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
        field(7; Name; Text[100])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the name of the employee.';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(8; "Days Worked"; Decimal)
        {
            Caption = 'Days Worked';
            ToolTip = 'Specifies the number of days worked by the employee during the bonus period.';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }

        field(9; "Bonusable Earnings"; Decimal)
        {
            Caption = 'Bonusable Earnings';
            ToolTip = 'Specifies the earnings amount eligible for bonus calculation.';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }
        field(10; "Projection Not Required"; Boolean)
        {
            Caption = 'Projection Not Required';
            ToolTip = 'Specifies whether bonus projection is not required for this employee.';
            DataClassification = CustomerContent;
        }

        field(11; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            ToolTip = 'Specifies the employment category of the employee.';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Worker Permanent,Worker Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Worker Permanent","Worker Temporary";
            Editable = false;
            DataClassification = CustomerContent;
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

