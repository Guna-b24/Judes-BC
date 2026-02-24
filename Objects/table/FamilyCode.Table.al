table 71920 "Family Code"
{
    Caption = 'Family Code';
    DataClassification = CustomerContent;
    DrillDownPageId = "Family Code List";
    LookupPageId = "Family Code List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Unique code identifying the family.';
        }

        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            ToolTip = 'Full name or description of the family.';
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

