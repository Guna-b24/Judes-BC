page 71091 "Event Master Card"
{
    PageType = Card;
    SourceTable = "Event Master";
    ApplicationArea = All;
    Caption = 'Event Master Card';
    Editable = true;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
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