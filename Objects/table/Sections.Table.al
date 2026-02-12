table 72030 Sections
{
    Caption = 'Sections';
    DataClassification = CustomerContent;
    // DrillDownPageID = 72040;
    // LookupPageID = 72040;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            ToolTip = 'Specifies the unique code for the section.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            NotBlank = true;
            ToolTip = 'Specifies the description of the section.';
        }
        field(3; "Active Employees"; Integer)
        {
            Caption = 'Active Employees';
            CalcFormula = Count(Employee WHERE("Section Code" = FIELD(Code),
                                                Status = FILTER(Active)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Inactive Employees"; Integer)
        {
            Caption = 'Inactive Employees';
            CalcFormula = Count(Employee WHERE("Section Code" = FIELD(Code),
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

