page 70920 "Severity List"
{
    PageType = List;
    SourceTable = Severity;
    ApplicationArea = All;
    UsageCategory = Lists;

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