page 71006 "Subject Card"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'Subject';
    SourceTable = Subject;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Subject Group"; Rec."Subject Group")
                {
                }
                field(Compulsory; Rec.Compulsory)
                {
                }
                field("Period Length"; Rec."Period Length")
                {
                }
                field("II Lang Type"; Rec."II Lang Type")
                {
                }
                field("Subject Order"; Rec."Subject Order")
                {
                }
                field("Portal ID"; Rec."Portal ID")
                {
                }
            }
        }
    }
}