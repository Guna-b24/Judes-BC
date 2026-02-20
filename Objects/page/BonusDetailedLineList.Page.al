page 70040 "Bonus Detailed Line List"
{
    PageType = List;
    SourceTable = "Bonus Detailed Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Bonus Detailed Lines';

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
                field("Bonus Year"; Rec."Bonus Year")
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
                field("Salary Cycle Code"; Rec."Salary Cycle Code")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    ApplicationArea = All;
                }
                field("Days Worked"; Rec."Days Worked")
                {
                    ApplicationArea = All;
                }
                field("Bonusable Earnings"; Rec."Bonusable Earnings")
                {
                    ApplicationArea = All;
                }
                field("Projection Not Required"; Rec."Projection Not Required")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
