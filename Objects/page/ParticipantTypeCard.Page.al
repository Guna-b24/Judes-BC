page 71125 "Participant Type Card"
{
    PageType = Card;
    SourceTable = "Participant Type";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Participant Type Card';
    Editable = true;


    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    Caption = 'Portal ID';
                }
            }
        }
    }
}