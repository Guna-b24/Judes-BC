table 72074 "Payroll Business Posting Group"
{

    Caption = 'Payroll Business Posting Group';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Code", Description;
    // DrillDownPageID = 72100;
    // LookupPageID = 72100;

    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = ToBeClassified;
            ToolTip = 'Location to which this payroll business posting group applies.';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = ToBeClassified;
            ToolTip = 'Salary plan associated with this payroll business posting group.';
        }
        field(3; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = ToBeClassified;
            ToolTip = 'Unique code for the payroll business posting group.';
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            ToolTip = 'Description of the payroll business posting group.';
        }
    }

    keys
    {
        key(Key1; "Code", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

