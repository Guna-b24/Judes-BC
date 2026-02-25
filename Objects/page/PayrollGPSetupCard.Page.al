page 72180 "Payroll GP Setup Card"
{
    PageType = Card;
    SourceTable = "Payroll General Posting Setup";
    ApplicationArea = All;
    Caption = 'Payroll General Posting Setup';
    UsageCategory = Administration;
    Editable = true;

    layout
    {
        area(content)
        {
            group("General")
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Pay Bus.Posting Group"; Rec."Pay Bus.Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Pay Prod. Posting Group"; Rec."Pay Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("G/L Code"; Rec."G/L Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}