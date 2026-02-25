table 72075 "Payroll Product Posting Group"
{
    Caption = 'Payroll Product Posting Group';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Location Code", "Salary Plan Code", "Code", Description;
    // DrillDownPageID = 72102;
    LookupPageID = "Payroll PP Group List";

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
        field(3; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the pay element code for this product posting group.';
            TableRelation = "Pay Elements" WHERE("Location Code" = FIELD("Location Code"),
                                                  "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the description of the payroll product posting group.';
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

