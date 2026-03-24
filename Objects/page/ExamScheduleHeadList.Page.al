page 71066 "Exam Schedule Head List"
{
    PageType = List;
    SourceTable = "Exam Schedule Head - SCH";
    ApplicationArea = All;
    Caption = 'Exam Schedule Head List';
    Editable = true;
    UsageCategory = Lists;
    CardPageId = "Exam Schedule Head Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the exam schedule number.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the exam date.';
                }
                field("Exam Code"; Rec."Exam Code")
                {
                    ToolTip = 'Specifies the exam code.';
                }
                field("Exam Slot"; Rec."Exam Slot")
                {
                    ToolTip = 'Specifies the exam slot.';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the exam start time.';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the exam end time.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the academic year.';
                }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}