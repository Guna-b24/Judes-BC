page 70035 "Arrears Header List"
{
    PageType = List;
    SourceTable = "Arrears Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Arrears List';
    CardPageId = "Arrears Header Card";

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
                field("Arrears Process Date"; Rec."Arrears Process Date")
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
                field("Pay Revision Id"; Rec."Pay Revision Id")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
