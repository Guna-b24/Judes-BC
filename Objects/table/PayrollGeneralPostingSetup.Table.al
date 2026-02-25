table 72076 "Payroll General Posting Setup"
{
    Caption = 'Payroll General Posting Setup';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Location Code", "Salary Plan Code", "Pay Bus.Posting Group", "Pay Prod. Posting Group", "G/L Code";
    // DrillDownPageID = 72104;
    LookupPageID = "Payroll GP Setup List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the payroll location.';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the salary plan.';
        }
        field(3; "Pay Bus.Posting Group"; Code[20])
        {
            Caption = 'Pay Bus.Posting Group';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the payroll business posting group.';
            TableRelation = "Payroll Business Posting Group" WHERE("Location Code" = FIELD("Location Code"),
                                                                    "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(4; "Pay Prod. Posting Group"; Code[20])
        {
            Caption = 'Pay Prod. Posting Group';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the payroll product posting group.';
            TableRelation = "Payroll Product Posting Group" WHERE("Location Code" = FIELD("Location Code"),
                                                                   "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(5; "G/L Code"; Code[20])
        {
            Caption = 'G/L Code';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the G/L account used for payroll posting.';
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

