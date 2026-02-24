page 72096 "Final Settlement Lines"
{
    PageType = List;
    SourceTable = "Final Settlement Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Final Settlement Lines';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Salary Cycle Code"; Rec."Salary Cycle Code") { ApplicationArea = All; }
                field("Payroll Start Date"; Rec."Payroll Start Date") { ApplicationArea = All; }
                field("Payroll End Date"; Rec."Payroll End Date") { ApplicationArea = All; }
                field(Year; Rec.Year) { ApplicationArea = All; }
                field(Month; Rec.Month) { ApplicationArea = All; }
                field("Employee No"; Rec."Employee No") { ApplicationArea = All; }
                field("Employee Category"; Rec."Employee Category") { ApplicationArea = All; }
                field("Pay Element Code"; Rec."Pay Element Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Paid Category"; Rec."Paid Category") { ApplicationArea = All; }
                field("Pay Type"; Rec."Pay Type") { ApplicationArea = All; }
                field("Fixed / Percent"; Rec."Fixed / Percent") { ApplicationArea = All; }
                field("Amount Calculation Type"; Rec."Amount Calculation Type") { ApplicationArea = All; }
                field("Base Pay Elements"; Rec."Base Pay Elements") { ApplicationArea = All; }
                field("Percentage (%)"; Rec."Percentage (%)") { ApplicationArea = All; }
                field("Total Days in a Month"; Rec."Total Days in a Month") { ApplicationArea = All; }
                field("Paid Days"; Rec."Paid Days") { ApplicationArea = All; }
                field("Actual Amount"; Rec."Actual Amount") { ApplicationArea = All; }
                field("Payable Amount"; Rec."Payable Amount") { ApplicationArea = All; }
                field("PF / ESI / PT Gross Earnings"; Rec."PF / ESI / PT Gross Earnings") { ApplicationArea = All; }
                field("EPS Gross Earnings"; Rec."EPS Gross Earnings") { ApplicationArea = All; }
                field("Account No."; Rec."Account No.") { ApplicationArea = All; }
                field("Employee VPF Amount"; Rec."Employee VPF Amount") { ApplicationArea = All; }
                field("Employee PF / ESI Amount"; Rec."Employee PF / ESI Amount") { ApplicationArea = All; }
                field("Employer PF / ESI Amount"; Rec."Employer PF / ESI Amount") { ApplicationArea = All; }
                field("Employer EPS Amount"; Rec."Employer EPS Amount") { ApplicationArea = All; }
                field("PF Admin Charges Amount"; Rec."PF Admin Charges Amount") { ApplicationArea = All; }
                field("PF EDLI Amount"; Rec."PF EDLI Amount") { ApplicationArea = All; }
                field("PF RIFA Amount"; Rec."PF RIFA Amount") { ApplicationArea = All; }
                field(Loan; Rec.Loan) { ApplicationArea = All; }
                field("Payment Type"; Rec."Payment Type") { ApplicationArea = All; }
                field("Included In Pay Slip"; Rec."Included In Pay Slip") { ApplicationArea = All; }
                field("Sorting Order"; Rec."Sorting Order") { ApplicationArea = All; }
                field("Salary Processed"; Rec."Salary Processed") { ApplicationArea = All; }
                field("Salary Posted"; Rec."Salary Posted") { ApplicationArea = All; }
            }
        }
    }
}
