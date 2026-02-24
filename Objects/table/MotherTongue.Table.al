table 71891 "Mother Tongue"
{
    Caption = 'Mother Tongue';
    DrillDownPageID = "Mother Tongue List";
    LookupPageID = "Mother Tongue List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Unique code for the mother tongue.';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Full description of the mother tongue.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'ID used in the portal system.';
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

