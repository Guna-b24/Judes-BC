table 71907 "Fee Classification"
{
    Caption = 'Fee Classification';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71911;
    // LookupPageID = 71911;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Fee Classification Code';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique code for the fee classification.';
        }

        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the fee classification.';
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal reference ID associated with the fee classification.';
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

