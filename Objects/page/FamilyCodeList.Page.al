page 71920 "Family Code List"
{
    PageType = List;
    SourceTable = "Family Code";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Family Code Card";

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
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
