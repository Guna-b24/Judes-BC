page 70058 "Class Card Card"
{
    Caption = 'Class Card';
    PageType = Card;
    SourceTable = "Class Card";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }
                field(Curriculum; Rec.Curriculum)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                }
                field("Marks System"; Rec."Marks System")
                {
                    ApplicationArea = All;
                }
                field("Consolidated Grades"; Rec."Consolidated Grades")
                {
                    ApplicationArea = All;
                }
            }

            group("Fees & Costs")
            {
                field("Application Cost"; Rec."Application Cost")
                {
                    ApplicationArea = All;
                }
                field("Registration Cost"; Rec."Registration Cost")
                {
                    ApplicationArea = All;
                }
                field("Promotion Percentage"; Rec."Promotion Percentage")
                {
                    ApplicationArea = All;
                }
            }

            group("Age Limits")
            {
                field("Miniimum Age Limit"; Rec."Minimum Age Limit")
                {
                    ApplicationArea = All;
                }
                field("Maximum Age Limit"; Rec."Maximum Age Limit")
                {
                    ApplicationArea = All;
                }
                field("Cut Off Age as on"; Rec."Cut Off Age as on")
                {
                    ApplicationArea = All;
                }
            }

            group("Application Period")
            {
                field("Application Sale From"; Rec."Application Sale From")
                {
                    ApplicationArea = All;
                }
                field("Application Sale Till"; Rec."Application Sale Till")
                {
                    ApplicationArea = All;
                }
                field("Application Receive From"; Rec."Application Receive From")
                {
                    ApplicationArea = All;
                }
                field("Application Receive Till"; Rec."Application Receive Till")
                {
                    ApplicationArea = All;
                }
            }

            group("Statistics")
            {
                Editable = false;

                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                }
                field("Present Strength"; Rec."Present Strength")
                {
                    ApplicationArea = All;
                }
                field(Withdrawal; Rec.Withdrawal)
                {
                    ApplicationArea = All;
                }
            }

            group(Status)
            {
                field(Promoted; Rec.Promoted)
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}