page 70891 "Mother Tongue Card"
{
    PageType = Card;
    SourceTable = "Mother Tongue";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Code"; Rec."Code") { }
                field(Description; Rec.Description) { }
                field("Portal ID"; Rec."Portal ID") { }
            }
        }
    }
}