page 70039 "Arrears Line List"
{
    PageType = List;
    SourceTable = "Arrears Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Arrears Lines';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Arrears Id"; Rec."Arrears Id")
                {
                    ApplicationArea = All;
                }
                field("Salary Cycle Code"; Rec."Salary Cycle Code")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Pay Element Code"; Rec."Pay Element Code")
                {
                    ApplicationArea = All;
                }
                field("Actual Amount"; Rec."Actual Amount")
                {
                    ApplicationArea = All;
                }
                field("Payable Amount"; Rec."Payable Amount")
                {
                    ApplicationArea = All;
                }
                field("Arrear Amount"; Rec."Arrear Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
