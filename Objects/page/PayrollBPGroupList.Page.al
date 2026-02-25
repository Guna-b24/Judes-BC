page 72076 "Payroll BP Group List"
{
    PageType = List;
    SourceTable = "Payroll Business Posting Group";
    ApplicationArea = All;
    Caption = 'Payroll Business Posting Group';
    UsageCategory = Administration;
    CardPageID = "Payroll BP Group Card";

    layout
    {
        area(content)
        {
            repeater(Group)
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