page 72189 "Employee Loan Details List"
{
    PageType = List;
    SourceTable = "Employee Loan Details";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Employee Loan Details';
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Loan Code"; Rec."Loan Code")
                {
                    ApplicationArea = All;
                }
                field(LoanId; Rec.LoanId)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Salary Process Date"; Rec."Salary Process Date")
                {
                    ApplicationArea = All;
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                    ApplicationArea = All;
                }
                field("EMI Amount"; Rec."EMI Amount")
                {
                    ApplicationArea = All;
                }
                field("EMI Deducted"; Rec."EMI Deducted")
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
                field("Payment Due"; Rec."Payment Due")
                {
                    ApplicationArea = All;
                }
                field("Balance Amount"; Rec."Balance Amount")
                {
                    ApplicationArea = All;
                }
                field("Repayment Date"; Rec."Repayment Date")
                {
                    ApplicationArea = All;
                }
                field("Loan Closed"; Rec."Loan Closed")
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
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}