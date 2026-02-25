page 71916 "Section Card"
{
    PageType = Card;
    SourceTable = Section;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Section';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}