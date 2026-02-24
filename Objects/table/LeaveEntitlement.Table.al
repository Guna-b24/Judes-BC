table 72084 "Leave Entitlement"
{
    DrillDownPageId = "Leave Entitlement List";
    LookupPageId = "Leave Entitlement List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            TableRelation = "Salary Plan";
        }
        field(3; "Leave Year Code"; Code[20])
        {
            Editable = false;
        }
        field(4; "Employee No"; Code[20])
        {
            SQLDataType = Variant;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then
                    Name := Employee."First Name" + ' ' + Employee.Initials;
            end;
        }
        field(5; Name; Text[50])
        {
            Editable = false;
        }
        field(6; Probationary; Boolean)
        {
        }
        field(7; "Leave Code"; Code[20])
        {
            Editable = false;
        }
        field(8; "Leave Opening Balance"; Decimal)
        {

            trigger OnValidate()
            begin
                CalcFields("Total Leave Eligible for Year", "Total Leave Availed");
                "Total Leave Balance" := "Leave Opening Balance" + "Total Leave Eligible for Year";
                "Leave Closing Balance" := ("Total Leave Balance" - ("Total Leave Availed" + "Total Leave Encashed"));
            end;
        }
        field(9; "Total Leave Eligible for Year"; Decimal)
        {
            CalcFormula = Sum("Leave Credited"."No. of Leaves" WHERE("Location Code" = FIELD("Location Code"),
                                                                      "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                      "Employee No" = FIELD("Employee No"),
                                                                      "Leave Code" = FIELD("Leave Code"),
                                                                      "No. of Leaves" = FILTER(<> 0),
                                                                      "Leave Year Code" = FIELD("Leave Year Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Total Leave Balance"; Decimal)
        {
            Editable = false;
        }
        field(11; "Total Leave Availed"; Decimal)
        {
            CalcFormula = Sum("Daily Attendance"."Leave Availed" WHERE("Location Code" = FIELD("Location Code"),
                                                                        "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                        "Leave Code" = FIELD("Leave Code"),
                                                                        "Employee No" = FIELD("Employee No"),
                                                                        "Leave Year Code" = FIELD("Leave Year Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Total Leave Encashed"; Decimal)
        {
            Editable = false;
        }
        field(13; "Leave Closing Balance"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                CalcFields("Total Leave Eligible for Year", "Total Leave Availed");
                "Total Leave Balance" := "Leave Opening Balance" + "Total Leave Eligible for Year";
                "Leave Closing Balance" := ("Total Leave Balance" - ("Total Leave Availed" + "Total Leave Encashed"));
            end;
        }
        field(14; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(15; Synchronize; Boolean)
        {
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

    var
        Employee: Record Employee;
}

