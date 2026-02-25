page 72054 "Salary Plan Card"
{
    PageType = Card;
    SourceTable = "Salary Plan";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Salary Plan';

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
                field("Date Interval"; Rec."Date Interval")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}