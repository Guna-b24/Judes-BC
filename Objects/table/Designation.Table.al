table 72002 Designation
{
    LookupPageID = "Designation List";
    Caption = 'Designation';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(3; "Active Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Designation Code" = FIELD(Code),
                                                Status = FILTER(Active)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Inactive Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Designation Code" = FIELD(Code),
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

