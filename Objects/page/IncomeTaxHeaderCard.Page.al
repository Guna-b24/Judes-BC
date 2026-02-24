page 72068 "Income Tax Header Card"
{
    PageType = Card;
    SourceTable = "Income Tax Header";
    ApplicationArea = All;
    Caption = 'Income Tax Header';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
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
            }

            group(Limits)
            {
                field("Tax Deduction Limit"; Rec."Tax Deduction Limit")
                {
                    ApplicationArea = All;
                }
                field("Medical Claim Limit"; Rec."Medical Claim Limit")
                {
                    ApplicationArea = All;
                }
                field("Physically Handicapped Limit"; Rec."Physically Handicapped Limit")
                {
                    ApplicationArea = All;
                }
                field("Housing Loan Interest Limit"; Rec."Housing Loan Interest Limit")
                {
                    ApplicationArea = All;
                }
                field("Excess of Rent Paid"; Rec."Excess of Rent Paid")
                {
                    ApplicationArea = All;
                }
                field("Max. Conveyance"; Rec."Max. Conveyance")
                {
                    ApplicationArea = All;
                }
            }

            group(Percentage)
            {
                field("Metro %"; Rec."Metro %")
                {
                    ApplicationArea = All;
                }
                field("Non Metro %"; Rec."Non Metro %")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Income Tax Line Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Assessment Year" = field("Assessment Year"),
                                "Location Code" = field("Location Code"),
                                "Salary Plan Code" = field("Salary Plan Code");
            }
        }
    }
}