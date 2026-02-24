page 71906 "Fee Components Card"
{
    PageType = Card;
    SourceTable = "Fee Components";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; rec."Code") { ApplicationArea = All; }
                field(Description; rec.Description) { ApplicationArea = All; }
                field("Fee Group"; rec."Fee Group") { ApplicationArea = All; }
                field("Check Duplication"; rec."Check Duplication") { ApplicationArea = All; }
            }

            group(Accounting)
            {
                field("G/L Account"; rec."G/L Account") { ApplicationArea = All; }
            }

            group(Integration)
            {
                field("Portal ID"; rec."Portal ID") { ApplicationArea = All; }
            }
        }
    }
}
