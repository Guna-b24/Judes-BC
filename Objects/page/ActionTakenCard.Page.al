page 71917 "Action Taken Card"
{
    PageType = Card;
    SourceTable = "Action Taken";
    ApplicationArea = All;
    Caption = 'Action Taken';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the action taken.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }

            group(Integration)
            {
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
