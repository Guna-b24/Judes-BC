page 72074 "Shift List"
{
    PageType = List;
    SourceTable = Shift;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Shift Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Code"; Rec."Code") { }
                field(Description; Rec.Description) { }
                field("Total Hours"; Rec."Total Hours") { }
                field("Punch Time Applicable"; Rec."Punch Time Applicable") { }
            }
        }
    }
}