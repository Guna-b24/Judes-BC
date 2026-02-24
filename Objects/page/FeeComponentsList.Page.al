page 71905 "Fee Components List"
{
    PageType = List;
    SourceTable = "Fee Components";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Fee Components Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; rec."Code") { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; }
                field("G/L Account"; rec."G/L Account") { ApplicationArea = All; }
                field("Fee Group"; rec."Fee Group") { ApplicationArea = All; }
                field("Check Duplication"; rec."Check Duplication") { ApplicationArea = All; }
                field("Portal ID"; rec."Portal ID") { ApplicationArea = All; }
            }
        }
    }
}
