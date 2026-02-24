page 71908 "Fee Classification Card"
{
    PageType = Card;
    SourceTable = "Fee Classification";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
