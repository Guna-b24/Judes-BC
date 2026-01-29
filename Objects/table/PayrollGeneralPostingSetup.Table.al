table 72076 "Payroll General Posting Setup"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Payroll General Posting Setup';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Pay Bus.Posting Group", "Pay Prod. Posting Group", "G/L Code";
    DrillDownPageID = 72104;
    LookupPageID = 72104;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(3; "Pay Bus.Posting Group"; Code[20])
        {
            Caption = 'Pay Bus.Posting Group';
            TableRelation = "Payroll Business Posting Group" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                    "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(4; "Pay Prod. Posting Group"; Code[20])
        {
            Caption = 'Pay Prod. Posting Group';
            TableRelation = "Payroll Product Posting Group" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                   "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(5; "G/L Code"; Code[20])
        {
            Caption = 'G/L Code';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Pay Bus.Posting Group", "Pay Prod. Posting Group", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

