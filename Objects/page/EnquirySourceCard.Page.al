page 71883 "Enquiry Source Card"
{
    PageType = Card;
    SourceTable = "Enquiry Source";
    ApplicationArea = All;
    Caption = 'Enquiry Source Card';
    Editable = true;
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

    actions
    {
        area(Navigation) { }
    }
}