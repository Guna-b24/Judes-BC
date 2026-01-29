table 72026 "Employee Skill - Certification"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Employee Skill - Certification';
    DrillDownPageID = 72038;
    LookupPageID = 72038;

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            Editable = false;
        }
        field(2; "Skills Code"; Code[120])
        {
            Caption = 'Skills Code';
            TableRelation = Skill;
            ValidateTableRelation = false;
        }
        field(3; "Certifications Code"; Code[100])
        {
            Caption = 'Certifications Code';
            TableRelation = Certification;
            ValidateTableRelation = false;
        }
        field(4; "Experience in Skills"; Decimal)
        {
            Caption = 'Experience in Skills';
        }
    }

    keys
    {
        key(Key1; "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

