page 71907 "Fee Classification List"
{
    PageType = List;
    SourceTable = "Fee Classification";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Fee Classification Card";

    layout
    {
        area(content)
        {
            repeater(Group)
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
