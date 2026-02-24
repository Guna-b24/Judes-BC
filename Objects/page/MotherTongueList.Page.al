page 71892 "Mother Tongue List"
{
    PageType = List;
    SourceTable = "Mother Tongue";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Mother Tongue Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { }
                field(Description; Rec.Description) { }
                field("Portal ID"; Rec."Portal ID") { }
            }
        }
    }
}