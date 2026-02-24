page 72069 "Income Tax Line Subpage"
{
    PageType = ListPart;
    SourceTable = "Income Tax Line";
    ApplicationArea = All;
    Caption = 'Income Tax Lines';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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