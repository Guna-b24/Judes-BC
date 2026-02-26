page 72120 "Employee Loan Card"
{
    Caption = 'Employee Loan Card';
    PageType = Document;
    SourceTable = "Employee Loan";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Loan Id"; Rec."Loan Id")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                }

                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Loan Code"; Rec."Loan Code")
                {
                    ApplicationArea = All;
                }

                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = All;
                }

                field("Purpose of loan"; Rec."Purpose of loan")
                {
                    ApplicationArea = All;
                }
            }

            group("Loan Information")
            {
                field("Total Loan Amount"; Rec."Total Loan Amount")
                {
                    ApplicationArea = All;
                }

                field("Rate of Interest"; Rec."Rate of Interest")
                {
                    ApplicationArea = All;
                }

                field("Installment Amount"; Rec."Installment Amount")
                {
                    ApplicationArea = All;
                }

                field("No of Installment"; Rec."No of Installment")
                {
                    ApplicationArea = All;
                }

                field("Loan Starting Date"; Rec."Loan Starting Date")
                {
                    ApplicationArea = All;
                }

                field("Loan End Date"; Rec."Loan End Date")
                {
                    ApplicationArea = All;
                }

                field("Loan Plan"; Rec."Loan Plan")
                {
                    ApplicationArea = All;
                }
            }

            group("Balances")
            {
                field("Opening Loan Amount"; Rec."Opening Loan Amount")
                {
                    ApplicationArea = All;
                }

                field("Loans Deducted"; Rec."Loans Deducted")
                {
                    ApplicationArea = All;
                }

                field("Closing Balance Amount"; Rec."Closing Balance Amount")
                {
                    ApplicationArea = All;
                }

                field("Loan Balance Amount"; Rec."Loan Balance Amount")
                {
                    ApplicationArea = All;
                }

                field("Total Interest Amount"; Rec."Total Interest Amount")
                {
                    ApplicationArea = All;
                }

                field(Completed; Rec.Completed)
                {
                    ApplicationArea = All;
                }
            }
            part("Loan Details"; "Employee Loan Details ListPart")
            {
                ApplicationArea = All;
                SubPageLink = LoanId = FIELD("Loan Id");
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Loans Deducted", "Total Loans Deducted");
    end;
}