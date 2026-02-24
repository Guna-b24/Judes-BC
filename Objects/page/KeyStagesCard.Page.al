page 71045 "KeyStages Card"
{
    PageType = Card;
    SourceTable = KeyStages;
    ApplicationArea = All;
    Caption = 'Key Stage';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Divison Code"; Rec."Divison Code")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
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