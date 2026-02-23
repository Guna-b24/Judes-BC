page 70066 "Class Section Card"
{
    Caption = 'Class Section Card';
    PageType = Card;
    SourceTable = "Class Section";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                }
                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
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
            }

            group("Capacity & Strength")
            {
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                }
                field("Present Strength"; Rec."Present Strength")
                {
                    ApplicationArea = All;
                }
            }

            group("Academic Settings")
            {
                field("Marks System"; Rec."Marks System")
                {
                    ApplicationArea = All;
                }
                field("Promotion Percentage"; Rec."Promotion Percentage")
                {
                    ApplicationArea = All;
                }
                field("Consolidated Grades"; Rec."Consolidated Grades")
                {
                    ApplicationArea = All;
                }
            }

            group("Teacher Details")
            {
                field("Class Teacher"; Rec."Class Teacher")
                {
                    ApplicationArea = All;
                }
                field("Home Work Duration"; Rec."Home Work Duration")
                {
                    ApplicationArea = All;
                }
            }

            group("Group Limits")
            {
                field("Max Group 2 Count"; Rec."Max Group 2 Count")
                {
                    ApplicationArea = All;
                }
                field("Max Group 3 Count"; Rec."Max Group 3 Count")
                {
                    ApplicationArea = All;
                }
            }

            group(Integration)
            {
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}