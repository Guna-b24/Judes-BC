table 71042 Curriculum
{
    Caption = 'Curriculum';
    DataClassification = CustomerContent;
    LookupPageID = "Curriculum List";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique code for the curriculum.';
        }

        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the curriculum.';
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier linked to this curriculum.';
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

