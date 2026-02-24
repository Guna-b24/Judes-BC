page 70029 "Income Tax Card"
{
    PageType = Card;
    SourceTable = "Income Tax";
    ApplicationArea = All;
    Caption = 'Income Tax';
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group("Employee Information")
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Assessment Year"; Rec."Assessment Year") { ApplicationArea = All; }
                field("Salary Year"; Rec."Salary Year") { ApplicationArea = All; }
                field("Salary Cyclic Code"; Rec."Salary Cyclic Code") { ApplicationArea = All; }
                field("Employee No"; Rec."Employee No") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(Designation; Rec.Designation) { ApplicationArea = All; }
                field("P.A.N.No"; Rec."P.A.N.No") { ApplicationArea = All; }
                field(Sex; Rec.Sex) { ApplicationArea = All; }
                field("Physically Handicapped"; Rec."Physically Handicapped") { ApplicationArea = All; }
                field("Senior Citizen"; Rec."Senior Citizen") { ApplicationArea = All; }
            }

            group("Gross Salary Details")
            {
                field("Salary Gross Earning Actual"; Rec."Salary Gross Earning Actual") { ApplicationArea = All; }
                field("Salary Gross Earning Projected"; Rec."Salary Gross Earning Projected") { ApplicationArea = All; }
                field("Salary Gross Earning Total"; Rec."Salary Gross Earning Total") { ApplicationArea = All; }
                field(Bonus; Rec.Bonus) { ApplicationArea = All; }
                field("Leave Salary"; Rec."Leave Salary") { ApplicationArea = All; }
                field("Arrears Amount"; Rec."Arrears Amount") { ApplicationArea = All; }
            }

            group("Income & Exemptions")
            {
                field("Other Earnings Total"; Rec."Other Earnings Total") { ApplicationArea = All; }
                field("Exemptions Totals"; Rec."Exemptions Totals") { ApplicationArea = All; }
                field("Gross Salary Income"; Rec."Gross Salary Income") { ApplicationArea = All; }
                field("Gross Total Income"; Rec."Gross Total Income") { ApplicationArea = All; }
                field("Taxable Income"; Rec."Taxable Income") { ApplicationArea = All; }
            }

            group("Tax Calculation")
            {
                field("Income Tax Amount"; Rec."Income Tax Amount") { ApplicationArea = All; }
                field("Higher Edu Cess Amount"; Rec."Higher Edu Cess Amount") { ApplicationArea = All; }
                field("Cess Amount"; Rec."Cess Amount") { ApplicationArea = All; }
                field("Surcharge Amount"; Rec."Surcharge Amount") { ApplicationArea = All; }
                field("Total Tax Amount"; Rec."Total Tax Amount") { ApplicationArea = All; }
                field("Tax Paid"; Rec."Tax Paid") { ApplicationArea = All; }
                field("Tax Refund"; Rec."Tax Refund") { ApplicationArea = All; }
                field("Tax Balance"; Rec."Tax Balance") { ApplicationArea = All; }
                field("Tax Per Month"; Rec."Tax Per Month") { ApplicationArea = All; }
                field(Verified; Rec.Verified) { ApplicationArea = All; }
                field(Printed; Rec.Printed) { ApplicationArea = All; }
            }
        }
    }
}