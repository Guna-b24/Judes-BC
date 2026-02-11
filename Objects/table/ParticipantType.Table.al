table 71074 "Participant Type"
{

    Caption = 'Participant Type';
    // DrillDownPageID = 71083;
    // LookupPageID = 71083;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            ToolTip = 'Unique code for the participant type.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            ToolTip = 'Description of the participant type.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = ToBeClassified;
            ToolTip = 'Portal reference ID for external integration.';
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

