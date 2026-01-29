table 72001 Departments
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    LookupPageID = 72001;

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            NotBlank = true;
        }
        field(3; "Active Employees"; Integer)
        {
            CalcFormula = Count (Employee WHERE ("Department Code" = FIELD (Code),
                                                Status = FILTER (Active)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Inactive Employees"; Integer)
        {
            CalcFormula = Count (Employee WHERE ("Department Code" = FIELD (Code),
                                                Status = FILTER (Inactive)));
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

