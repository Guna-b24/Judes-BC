page 72178 "Payroll EP Group Card"
{
    PageType = Card;
    SourceTable = "Payroll Employee Posting Group";
    ApplicationArea = All;
    Caption = 'Payroll Employee Posting Group';
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
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }

            group("Payable Accounts")
            {
                field("Salary Payable1 A/c"; Rec."Salary Payable1 A/c") { ApplicationArea = All; }
                field("Salary Payable2 A/c"; Rec."Salary Payable2 A/c") { ApplicationArea = All; }
                field("ESI Payable A/c"; Rec."ESI Payable A/c") { ApplicationArea = All; }
                field("PF Payable A/c"; Rec."PF Payable A/c") { ApplicationArea = All; }
                field("EPS Payable A/c"; Rec."EPS Payable A/c") { ApplicationArea = All; }
                field("PF Admin Charge Payable A/c"; Rec."PF Admin Charge Payable A/c") { ApplicationArea = All; }
                field("EDLI Payable A/c"; Rec."EDLI Payable A/c") { ApplicationArea = All; }
                field("RIFA Payable A/c"; Rec."RIFA Payable A/c") { ApplicationArea = All; }
                field("PT Payable A/c"; Rec."PT Payable A/c") { ApplicationArea = All; }
                field("TDS Payable A/c"; Rec."TDS Payable A/c") { ApplicationArea = All; }
                field("Bonus Payable A/c"; Rec."Bonus Payable A/c") { ApplicationArea = All; }
                field("Arrear Salary Payable A/c"; Rec."Arrear Salary Payable A/c") { ApplicationArea = All; }
                field("Loan Refundable A/c"; Rec."Loan Refundable A/c") { ApplicationArea = All; }
            }
        }
    }
}