page 70058 "Class Card Card"
{
    Caption = 'Class Card';
    PageType = Card;
    SourceTable = "Class Card";
    ApplicationArea = All;
    UsageCategory = Lists;

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
                field("Edu. Calendar Code"; Rec."Edu. Calendar Code")
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
    actions
    {
        area(Processing)
        {
            group("Class Setup")
            {
                action(Section)
                {
                    ApplicationArea = All;
                    Image = List;
                    ToolTip = 'Open the class sections for the selected class.';

                    RunObject = Page "Class Section List";
                    RunPageLink = "Class Code" = field(Class);
                }

                action("Optional Subject Group")
                {
                    ApplicationArea = All;
                    Image = List;
                    ToolTip = 'Open the optional subject groups for the selected class.';

                    RunObject = Page "Class Section Subjects List";
                    RunPageLink = "Class Code" = field("Class");
                }

                action("Class Subjects")
                {
                    ApplicationArea = All;
                    Image = List;
                    ToolTip = 'View the subjects assigned to the selected class.';

                    RunObject = Page "Class Subjects List";
                    RunPageLink = Class = field("Class");
                }

                action(Grade)
                {
                    ApplicationArea = All;
                    Image = List;
                    ToolTip = 'Open the grading setup for the selected class.';

                    RunObject = Page "Class Grade List";
                    RunPageLink = "Class" = field("Class");
                }

                action("Promotion Weightage")
                {
                    ApplicationArea = All;
                    Image = Calculate;
                    ToolTip = 'Open the promotion weightage setup for the selected class.';

                    RunObject = Page "Promotion Weightage";
                    RunPageLink = "Class Code" = field("Class");
                }

                action(Evaluation)
                {
                    ApplicationArea = All;
                    Image = View;
                    ToolTip = 'Open the evaluation setup for the selected class.';

                    RunObject = Page "Class Evaluation List";
                    RunPageLink = "Class" = field("Class");
                }
            }
        }
    }
}