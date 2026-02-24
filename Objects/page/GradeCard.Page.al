page 71890 "Grade Card"
{
    PageType = Card;
    SourceTable = Grade;
    ApplicationArea = All;
    Caption = 'Grade';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
            }

            group("Percentage Range")
            {
                field("Min Percentage"; Rec."Min Percentage") { ApplicationArea = All; }
                field("Max Percentage"; Rec."Max Percentage") { ApplicationArea = All; }
                field(Points; Rec.Points) { ApplicationArea = All; }
            }

            group("Additional Info")
            {
                field("Portal ID"; Rec."Portal ID") { ApplicationArea = All; }
            }
        }
    }
}
