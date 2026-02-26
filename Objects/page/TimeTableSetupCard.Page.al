page 71153 "Time Table Setup Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Time Table Setup";
    Caption = 'Time Table Setup';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Primary Key"; Rec."Primary Key")
                {
                }
                field("Academic Year"; Rec."Academic Year")
                {
                }
                field("Time Table Theory Code"; Rec."Time Table Theory Code")
                {
                }
                field("Time Table Lab Code"; Rec."Time Table Lab Code")
                {
                }
                field("Portal ID"; Rec."Portal ID")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // action(Refresh)
            // {
            //     Caption = 'Refresh';
            //     Image = Refresh;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     begin
            //         CurrPage.Update();
            //     end;
            // }
        }
    }
}