page 71913 "Exam Code Card"
{
    PageType = Card;
    SourceTable = "Exam Code";
    ApplicationArea = All;
    Caption = 'Exam Code Card';
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
                field("Exam Order"; Rec."Exam Order") { }
                field("Portal ID"; Rec."Portal ID") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}