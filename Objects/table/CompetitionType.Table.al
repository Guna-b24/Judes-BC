table 71075 "Competition Type"
{
    Caption = 'Competition Type';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71084;
    // LookupPageID = 71084;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique code that identifies the competition type.';
        }

        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the competition type.';
        }

        field(3; "Entire Class"; Boolean)
        {
            Caption = 'Entire Class';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the competition applies to the entire class.';
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier used for integration or tracking.';
        }

        field(70122; IsExternalType; Boolean)
        {
            Caption = 'Is External Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the competition type is external.';
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

