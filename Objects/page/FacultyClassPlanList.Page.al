page 71173 "Faculty Class Plan List"
{
    PageType = List;
    SourceTable = "Faculty Class Plan Header";
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageId = "Faculty Class Plan Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the plan number.';
                }
                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the class.';
                }
                field(Curriculum; Rec.Curriculum)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the curriculum.';
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the subject code.';
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the faculty assigned.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic year.';
                }
                field("Plan Status"; Rec."Plan Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the plan.';
                }
            }
        }
    }
}