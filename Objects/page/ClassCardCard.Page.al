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
                    ToolTip = 'Specifies the class code.';
                }
                field(Curriculum; Rec.Curriculum)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the curriculum associated with the class.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic year for the class.';
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sequence number of the class.';
                }
                field("Marks System"; Rec."Marks System")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the marks system used for the class.';
                }
                field("Consolidated Grades"; Rec."Consolidated Grades")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates if grades are consolidated for the class.';
                }
            }

            group("Fees & Costs")
            {
                field("Application Cost"; Rec."Application Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cost for application.';
                }
                field("Registration Cost"; Rec."Registration Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cost for registration.';
                }
                field("Promotion Percentage"; Rec."Promotion Percentage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the percentage required for promotion.';
                }
            }

            group("Age Limits")
            {
                field("Miniimum Age Limit"; Rec."Minimum Age Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum age limit for the class.';
                }
                field("Maximum Age Limit"; Rec."Maximum Age Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum age limit for the class.';
                }
                field("Cut Off Age as on"; Rec."Cut Off Age as on")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cut-off date for age calculation.';
                }
            }

            group("Application Period")
            {
                field("Application Sale From"; Rec."Application Sale From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date for application sale.';
                }
                field("Application Sale Till"; Rec."Application Sale Till")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end date for application sale.';
                }
                field("Application Receive From"; Rec."Application Receive From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date for receiving applications.';
                }
                field("Application Receive Till"; Rec."Application Receive Till")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end date for receiving applications.';
                }
            }

            group("Statistics")
            {
                Editable = false;

                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the capacity of the class.';
                }
                field("Present Strength"; Rec."Present Strength")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current number of students in the class.';
                }
                field(Withdrawal; Rec.Withdrawal)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of withdrawals from the class.';
                }
            }

            group(Status)
            {
                field(Promoted; Rec.Promoted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates if the class has been promoted.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates if the class is closed.';
                }
                field("Edu. Calendar Code"; Rec."Edu. Calendar Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the education calendar code.';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the portal ID for the class.';
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
                    ApplicationArea = all;
                    Image = List;
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