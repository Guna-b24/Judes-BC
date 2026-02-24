table 60000 Menu
{
    Caption = 'Menu';
    DataClassification = CustomerContent;
    // DrillDownPageID = 60001;
    LookupPageID = "Menu List";

    fields
    {
        field(1; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date for which the menu is planned.';

        }
        field(2; Campus; Option)
        {
            Caption = 'Campus';
            DataClassification = CustomerContent;
            OptionCaption = ' ,MontFord,West Brook';
            OptionMembers = " ",MontFord,"West Brook";
            ToolTip = 'Select the campus for this menu.';

        }
        field(3; "Food Time"; Option)
        {
            Caption = 'Food Time';
            DataClassification = CustomerContent;
            OptionCaption = ' ,BreakFast,Lunch,Evening Break,Dinner';
            OptionMembers = " ",BreakFast,Lunch,"Evening Break",Dinner;
            ToolTip = 'Select the meal time for this menu.';

        }
        field(4; Menu; Text[250])
        {
            Caption = 'Menu Details';
            DataClassification = CustomerContent;
            ToolTip = 'Enter the menu items for the selected date, campus, and food time.';

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

