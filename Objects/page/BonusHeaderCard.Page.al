page 70042 "Bonus Header Card"
{
    PageType = Document;
    SourceTable = "Bonus Header";
    ApplicationArea = All;
    Caption = 'Bonus Header';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Bonus Id."; Rec."Bonus Id.")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
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
                field("Employee Category"; Rec."Employee Category")
                {
                    ApplicationArea = All;
                }
            }

            group("Bonus Period")
            {
                field("Bonus Start Date"; Rec."Bonus Start Date")
                {
                    ApplicationArea = All;
                }
                field("Bonus End Date"; Rec."Bonus End Date")
                {
                    ApplicationArea = All;
                }
                field("Bonus Declare Date"; Rec."Bonus Declare Date")
                {
                    ApplicationArea = All;
                }
            }

            group("Eligibility Setup")
            {
                field("Bonus Min No of Years"; Rec."Bonus Min No of Years")
                {
                    ApplicationArea = All;
                }
                field("Bonus Max No of Years"; Rec."Bonus Max No of Years")
                {
                    ApplicationArea = All;
                }
                field("Bonusable Earnings Min Limit"; Rec."Bonusable Earnings Min Limit")
                {
                    ApplicationArea = All;
                }
                field("Bonusable Earnings Max Limit"; Rec."Bonusable Earnings Max Limit")
                {
                    ApplicationArea = All;
                }
            }

            group("Bonus Calculation")
            {
                field("Bonus (%)"; Rec."Bonus (%)")
                {
                    ApplicationArea = All;
                }
                field("Ex-Gratia (%)"; Rec."Ex-Gratia (%)")
                {
                    ApplicationArea = All;
                }
                field("Total Days In a Year"; Rec."Total Days In a Year")
                {
                    ApplicationArea = All;
                }
            }

            group("Leave Days Setup")
            {
                field("Staff Total EL Days"; Rec."Staff Total EL Days")
                {
                    ApplicationArea = All;
                }
                field("Staff Total CL Days"; Rec."Staff Total CL Days")
                {
                    ApplicationArea = All;
                }
                field("Worker Total EL Days"; Rec."Worker Total EL Days")
                {
                    ApplicationArea = All;
                }
                field("Worker Total CL Days"; Rec."Worker Total CL Days")
                {
                    ApplicationArea = All;
                }
            }
            part(BonusLines; "Bonus Line Subform")
            {
                SubPageLink =
        "Bonus Id." = FIELD("Bonus Id."),
        "Location Code" = FIELD("Location Code"),
        "Salary Plan Code" = FIELD("Salary Plan Code"),
        "Bonus Year" = FIELD("Bonus Year");
            }
        }
    }
}
