table 60000 Menu
{
    DrillDownPageID = 60001;
    LookupPageID = 60001;

    fields
    {
        field(1; Date; Date)
        {
        }
        field(2; Campus; Option)
        {
            OptionCaption = ' ,MontFord,West Brook';
            OptionMembers = " ",MontFord,"West Brook";
        }
        field(3; "Food Time"; Option)
        {
            OptionCaption = ' ,BreakFast,Lunch,Evening Break,Dinner';
            OptionMembers = " ",BreakFast,Lunch,"Evening Break",Dinner;
        }
        field(4; Menu; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Date, Campus, "Food Time")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

