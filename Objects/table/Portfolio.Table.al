table 71934 Portfolio
{
    // DrillDownPageID = 33010301;
    // LookupPageID = 33010301; 
    Caption = 'Portfolio';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Portfolio; Text[60])
        {
            Caption = 'Portfolio';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portfolio name.';
        }
    }

    keys
    {
        key(Key1; Portfolio)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

