table 72063 "ESI Setup"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'ESI Setup';
    DataCaptionFields = "Effective Date", "Location Code", "Salary Plan Code";
    DrillDownPageID = 72081;
    LookupPageID = 72081;

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
        field(4; "ESI Gross Salary Amount"; Decimal)
        {
            Caption = 'ESI Gross Salary Amount';
        }
        field(5; "ESI % ( Employee )"; Decimal)
        {
            Caption = 'ESI % ( Employee )';
        }
        field(6; "ESI % ( Company )"; Decimal)
        {
            Caption = 'ESI % ( Company )';
        }
        field(7; "ESI Rounding Amount"; Decimal)
        {
            Caption = 'ESI Rounding Amount';
        }
        field(8; "ESI Rounding Type"; Option)
        {
            Caption = 'ESI Rounding Type';
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

