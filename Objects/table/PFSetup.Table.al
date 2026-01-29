table 72064 "PF Setup"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'PF Setup';
    DataCaptionFields = "Effective Date", "Location Code", "Salary Plan Code", "PF Gross Salary Limit";
    DrillDownPageID = 72083;
    LookupPageID = 72083;

    fields
    {
        field(1; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
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
        field(4; "PF Gross Salary Limit"; Decimal)
        {
            Caption = 'PF Gross Salary Limit';
        }
        field(5; "EPS Gross Salary Limit"; Decimal)
        {
            Caption = 'EPS Gross Salary Limit';
        }
        field(6; "Employee PF (Employee) %"; Decimal)
        {
            Caption = 'Employee PF (Employee) %';
        }
        field(7; "Employer PF (Company) %"; Decimal)
        {
            Caption = 'Employer PF (Company) %';
        }
        field(8; "Employer EPS ( Company) %"; Decimal)
        {
            Caption = 'Employer EPS ( Company) %';
        }
        field(9; "Employee VPF ( Employee) %"; Decimal)
        {
            Caption = 'Employee VPF ( Employee) %';
        }
        field(10; "PF Admin Charges %"; Decimal)
        {
            Caption = 'PF Admin Charges %';
        }
        field(11; "PF EDLI %"; Decimal)
        {
            Caption = 'PF EDLI %';
        }
        field(12; "PF RIFA %"; Decimal)
        {
            Caption = 'PF RIFA %';
        }
        field(13; "PF Rounding Amount"; Decimal)
        {
            Caption = 'PF Rounding Amount';
        }
        field(14; "PF Rounding Type"; Option)
        {
            Caption = 'PF Rounding Type';
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
        }
    }

    keys
    {
        key(Key1; "Effective Date", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

