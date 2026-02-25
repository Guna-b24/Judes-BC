page 70141 "Pay Elements Card"
{
    PageType = Card;
    SourceTable = "Pay Elements";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Pay Elements Card';
    Editable = true;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    Caption = 'Salary Plan Code';
                }
                field("Pay Element Code"; Rec."Pay Element Code")
                {
                    Caption = 'Pay Element Code';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Paid Category"; Rec."Paid Category")
                {
                    Caption = 'Paid Category';
                }
                field("Pay Type"; Rec."Pay Type")
                {
                    Caption = 'Pay Type';
                }
                field("Fixed/Percent"; Rec."Fixed/Percent")
                {
                    Caption = 'Fixed/Percent';
                }
                field("Base Pay Elements"; Rec."Base Pay Elements")
                {
                    Caption = 'Base Pay Elements';
                }
                field("Base Amount ( For % )"; Rec."Base Amount ( For % )")
                {
                    Caption = 'Base Amount ( For % )';
                }
                field("Percent (%)"; Rec."Percent (%)")
                {
                    Caption = 'Percent (%)';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field("Amount Calculation Type"; Rec."Amount Calculation Type")
                {
                    Caption = 'Amount Calculation Type';
                }
            }

            group(Eligibility)
            {
                field("Regular Element"; Rec."Regular Element")
                {
                    Caption = 'Regular Element';
                }
                field("Variable Element"; Rec."Variable Element")
                {
                    Caption = 'Variable Element';
                }
                field("Loan Element"; Rec."Loan Element")
                {
                    Caption = 'Loan Element';
                }
                field("Eligible for ESI Earnings"; Rec."Eligible for ESI Earnings")
                {
                    Caption = 'Eligible for ESI Earnings';
                }
                field("Eligible for PF"; Rec."Eligible for PF")
                {
                    Caption = 'Eligible for PF';
                }
                field("Eligible for PT"; Rec."Eligible for PT")
                {
                    Caption = 'Eligible for PT';
                }
                field("Eligible for OT"; Rec."Eligible for OT")
                {
                    Caption = 'Eligible for OT';
                }
                field("Eligible for Bonus"; Rec."Eligible for Bonus")
                {
                    Caption = 'Eligible for Bonus';
                }
                field("Eligible for Leave Encashment"; Rec."Eligible for Leave Encashment")
                {
                    Caption = 'Eligible for Leave Encashment';
                }
                field("Eligible for Gratuity"; Rec."Eligible for Gratuity")
                {
                    Caption = 'Eligible for Gratuity';
                }
                field("Eligible for Income Tax"; Rec."Eligible for Income Tax")
                {
                    Caption = 'Eligible for Income Tax';
                }
            }
        }
    }
}