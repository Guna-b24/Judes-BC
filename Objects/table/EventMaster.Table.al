table 71090 "Event Master"
{
    // DrillDownPageID = 71113;
    LookupPageID = "Event Master List";
    Caption = 'Event Master';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; IsSportsAndGames; Boolean)
        {
            Caption = 'Sports / Games Event';
            ToolTip = 'Specifies whether the event belongs to sports or games category.';
            DataClassification = CustomerContent;
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

