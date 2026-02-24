page 72169 "Income Tax Line List"
{
    PageType = List;
    SourceTable = "Income Tax Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Income Tax Lines';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Assessment Year"; Rec."Assessment Year")
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
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Income From"; Rec."Income From")
                {
                    ApplicationArea = All;
                }
                field("Income To"; Rec."Income To")
                {
                    ApplicationArea = All;
                }
                field("Tax %"; Rec."Tax %")
                {
                    ApplicationArea = All;
                }
                field("Surcharge %"; Rec."Surcharge %")
                {
                    ApplicationArea = All;
                }
                field("E-CESS %"; Rec."E-CESS %")
                {
                    ApplicationArea = All;
                }
                field("SHE-CESS %"; Rec."SHE-CESS %")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
