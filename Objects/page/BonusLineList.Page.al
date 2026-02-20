page 70043 "Bonus Line List"
{
    PageType = List;
    SourceTable = "Bonus Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Bonus Lines';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Select (Y/N)"; Rec."Select (Y/N)")
                {
                    ApplicationArea = All;
                }

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

                field("Service Year"; Rec."Service Year")
                {
                    ApplicationArea = All;
                }

                field("Service Month"; Rec."Service Month")
                {
                    ApplicationArea = All;
                }

                field("No of Days Worked"; Rec."No of Days Worked")
                {
                    ApplicationArea = All;
                }

                field("Bonusable Earnings"; Rec."Bonusable Earnings")
                {
                    ApplicationArea = All;
                }

                field("Bonus %"; Rec."Bonus %")
                {
                    ApplicationArea = All;
                }

                field("Bonus Amt"; Rec."Bonus Amt")
                {
                    ApplicationArea = All;
                }

                field("Ex-Gratia %"; Rec."Ex-Gratia %")
                {
                    ApplicationArea = All;
                }

                field("Ex-Gratia Amt"; Rec."Ex-Gratia Amt")
                {
                    ApplicationArea = All;
                }

                field("Gross Bonus Amt"; Rec."Gross Bonus Amt")
                {
                    ApplicationArea = All;
                }

                field("Deduction Amt"; Rec."Deduction Amt")
                {
                    ApplicationArea = All;
                }

                field("Total Net Bonus Amt"; Rec."Total Net Bonus Amt")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
