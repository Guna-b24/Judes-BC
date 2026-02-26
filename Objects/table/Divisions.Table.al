table 72029 Divisions
{
    // DrillDownPageID = 72039;
    LookupPageID = "Divisions List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(3; "Active Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Division Code" = FIELD(Code),
                                                Status = FILTER(Active)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Inactive Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Division Code" = FIELD(Code),
                                                Status = FILTER(Inactive)));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

