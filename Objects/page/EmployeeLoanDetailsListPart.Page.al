page 72121 "Employee Loan Details ListPart"
{
    Caption = 'Loan Installments';
    PageType = ListPart;
    SourceTable = "Employee Loan Details";
    ApplicationArea = All;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Salary Process Date"; Rec."Salary Process Date")
                {
                    ApplicationArea = All;
                }

                field("Repayment Date"; Rec."Repayment Date")
                {
                    ApplicationArea = All;
                }

                field("EMI Amount"; Rec."EMI Amount")
                {
                    ApplicationArea = All;
                }

                field(Principal; Rec.Principal)
                {
                    ApplicationArea = All;
                }

                field(Interest; Rec.Interest)
                {
                    ApplicationArea = All;
                }

                field("Balance Amount"; Rec."Balance Amount")
                {
                    ApplicationArea = All;
                }

                field("Loan Closed"; Rec."Loan Closed")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}