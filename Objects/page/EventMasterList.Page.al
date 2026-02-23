page 70099 "Event Master List"
{
    PageType = List;
    SourceTable = "Event Master";
    ApplicationArea = All;
    Caption = 'Event Master List';
    Editable = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { }
                field(Description; Rec.Description) { }
                field(IsSportsAndGames; Rec.IsSportsAndGames) { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}