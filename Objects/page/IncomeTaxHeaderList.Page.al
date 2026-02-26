page 72067 "Income Tax Header List"
{
    PageType = List;
    SourceTable = "Income Tax Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Income Tax Header';
    CardPageId = "Income Tax Header Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Assessment Year"; Rec."Assessment Year")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Deduction Limit"; Rec."Tax Deduction Limit")
                {
                    ApplicationArea = All;
                }
                field("Medical Claim Limit"; Rec."Medical Claim Limit")
                {
                    ApplicationArea = All;
                }
                field("Housing Loan Interest Limit"; Rec."Housing Loan Interest Limit")
                {
                    ApplicationArea = All;
                }
                field("Metro %"; Rec."Metro %")
                {
                    ApplicationArea = All;
                }
                field("Non Metro %"; Rec."Non Metro %")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}