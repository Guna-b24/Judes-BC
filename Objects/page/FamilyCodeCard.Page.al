page 71921 "Family Code Card"
{
    PageType = Card;
    SourceTable = "Family Code";
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
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
