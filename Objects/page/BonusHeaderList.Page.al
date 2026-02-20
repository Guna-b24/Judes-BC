page 70041 "Bonus Header List"
{
    PageType = List;
    SourceTable = "Bonus Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Bonus Header Card";
    Caption = 'Bonus Headers';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Bonus Id."; Rec."Bonus Id.")
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
                field("Bonus Year"; Rec."Bonus Year")
                {
                    ApplicationArea = All;
                }
                field("Bonus Start Date"; Rec."Bonus Start Date")
                {
                    ApplicationArea = All;
                }
                field("Bonus End Date"; Rec."Bonus End Date")
                {
                    ApplicationArea = All;
                }
                field("Bonus (%)"; Rec."Bonus (%)")
                {
                    ApplicationArea = All;
                }
                field("Ex-Gratia (%)"; Rec."Ex-Gratia (%)")
                {
                    ApplicationArea = All;
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
