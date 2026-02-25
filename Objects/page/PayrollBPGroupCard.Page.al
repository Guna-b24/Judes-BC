page 72075 "Payroll BP Group Card"
{
    PageType = Card;
    SourceTable = "Payroll Business Posting Group";
    ApplicationArea = All;
    Caption = 'Payroll Business Posting Group';
    UsageCategory = Administration;
    Editable = true;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}