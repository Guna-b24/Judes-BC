page 70131 "Income Tax Challan Card"
{
    PageType = Card;
    SourceTable = "Income Tax Challan Details";
    ApplicationArea = All;
    Caption = 'Income Tax Challan Details';
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group("Basic Information")
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Assessment Year"; Rec."Assessment Year") { ApplicationArea = All; }
                field("Salary Year"; Rec."Salary Year") { ApplicationArea = All; }
                field("Salary Cyclic Code"; Rec."Salary Cyclic Code") { ApplicationArea = All; }
                field("Employe No"; Rec."Employe No") { ApplicationArea = All; }
                field("Employee Code"; Rec."Employee Code") { ApplicationArea = All; }
                field("Section Code"; Rec."Section Code") { ApplicationArea = All; }
                field("Pay Element Code"; Rec."Pay Element Code") { ApplicationArea = All; }
                field("Quarterly Code"; Rec."Quarterly Code") { ApplicationArea = All; }
            }

            group("Challan Details")
            {
                field("Voucher / Challan No"; Rec."Voucher / Challan No") { ApplicationArea = All; }
                field("Voucher / Challan Date"; Rec."Voucher / Challan Date") { ApplicationArea = All; }
                field("Bank Code"; Rec."Bank Code") { ApplicationArea = All; }
                field("Cheque / DD No."; Rec."Cheque / DD No.") { ApplicationArea = All; }
                field("Bank/Cash"; Rec."Bank/Cash") { ApplicationArea = All; }
                field("Salary Paid Date"; Rec."Salary Paid Date") { ApplicationArea = All; }
            }

            group("Challan Payment Breakup")
            {
                field("Challan Income Tax"; Rec."Challan Income Tax") { ApplicationArea = All; }
                field("Challan Surcharge"; Rec."Challan Surcharge") { ApplicationArea = All; }
                field("Challan ECess"; Rec."Challan ECess") { ApplicationArea = All; }
                field("Challan Interest Amount"; Rec."Challan Interest Amount") { ApplicationArea = All; }
                field("Challan Other Amount"; Rec."Challan Other Amount") { ApplicationArea = All; }
                field("Total Deposit Amount as Vouche"; Rec."Total Deposit Amount as Vouche") { ApplicationArea = All; }
                field("Total Deposit as Deductee"; Rec."Total Deposit as Deductee") { ApplicationArea = All; }
                field("Total Challan Amount"; Rec."Total Challan Amount") { ApplicationArea = All; }
            }

            group("TDS / TCS Details")
            {
                field("TDS/TCS Income Tax"; Rec."TDS/TCS Income Tax") { ApplicationArea = All; }
                field("TDS/TCS Surcharge"; Rec."TDS/TCS Surcharge") { ApplicationArea = All; }
                field("TDS/TCS Cess"; Rec."TDS/TCS Cess") { ApplicationArea = All; }
                field("Total Income Tax"; Rec."Total Income Tax") { ApplicationArea = All; }
                field("TDS/TCS Interest Amount"; Rec."TDS/TCS Interest Amount") { ApplicationArea = All; }
                field("TDS/TCS Others"; Rec."TDS/TCS Others") { ApplicationArea = All; }
            }

            group("Status")
            {
                field(Post; Rec.Post) { ApplicationArea = All; }
                field(Select; Rec.Select) { ApplicationArea = All; }
            }
        }
    }
}