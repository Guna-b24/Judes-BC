page 70031 "Application Optional Card"
{
    PageType = Card;
    SourceTable = "Application Optional Subjects";
    ApplicationArea = All;
    Caption = 'Application Optional Subject Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Subject Group"; Rec."Subject Group")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
