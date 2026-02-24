page 70028 "Income Tax List"
{
    PageType = List;
    SourceTable = "Income Tax";
    ApplicationArea = All;
    Caption = 'Income Tax';
    UsageCategory = Documents;
    CardPageId = "Income Tax Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Assessment Year"; Rec."Assessment Year") { ApplicationArea = All; }
                field("Employee No"; Rec."Employee No") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Salary Year"; Rec."Salary Year") { ApplicationArea = All; }
                field("Taxable Income"; Rec."Taxable Income") { ApplicationArea = All; }
                field("Total Tax Amount"; Rec."Total Tax Amount") { ApplicationArea = All; }
                field("Tax Paid"; Rec."Tax Paid") { ApplicationArea = All; }
                field("Tax Balance"; Rec."Tax Balance") { ApplicationArea = All; }
                field(Verified; Rec.Verified) { ApplicationArea = All; }
            }
        }
    }
}