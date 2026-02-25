table 71902 Section
{
    Caption = 'Section';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71906;
    LookupPageID = "Section List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Section Code';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique code for the section.';
        }

        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the section.';
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal reference ID associated with the section.';
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

