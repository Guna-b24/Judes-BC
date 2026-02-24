page 70130 "Income Tax Challan List"
{
    PageType = List;
    SourceTable = "Income Tax Challan Details";
    ApplicationArea = All;
    Caption = 'Income Tax Challan Details';
    UsageCategory = Documents;
    CardPageId = "Income Tax Challan Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Assessment Year"; Rec."Assessment Year") { ApplicationArea = All; }
                field("Salary Cyclic Code"; Rec."Salary Cyclic Code") { ApplicationArea = All; }
                field("Employe No"; Rec."Employe No") { ApplicationArea = All; }
                field("Voucher / Challan No"; Rec."Voucher / Challan No") { ApplicationArea = All; }
                field("Voucher / Challan Date"; Rec."Voucher / Challan Date") { ApplicationArea = All; }
                field("Total Challan Amount"; Rec."Total Challan Amount") { ApplicationArea = All; }
                field("Quarterly Code"; Rec."Quarterly Code") { ApplicationArea = All; }
                field(Post; Rec.Post) { ApplicationArea = All; }
            }
        }
    }
}