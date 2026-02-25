page 72088 "Performance Appraisal Card"
{
    PageType = Card;
    SourceTable = "Performance Appraisal";
    ApplicationArea = All;
    Caption = 'Performance Appraisal';
    UsageCategory = Administration;
    Editable = true;

    layout
    {
        area(content)
        {
            group("General")
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
            }
        }
    }
}