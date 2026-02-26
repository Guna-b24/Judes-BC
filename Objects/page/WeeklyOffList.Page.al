page 72056 "Weekly Off List"
{
    PageType = List;
    SourceTable = "Weekly Off";
    Caption = 'Weekly Off';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                }
                field("Calendar Year"; Rec."Calendar Year")
                {
                }
                field(Day; Rec.Day)
                {
                }
                field("Week Wise (Weekly Off)"; Rec."Week Wise (Weekly Off)")
                {
                }
                field("First Half (Weekly Off)"; Rec."First Half (Weekly Off)")
                {
                }
                field("Second Half (Weekly Off)"; Rec."Second Half (Weekly Off)")
                {
                }
                field("Non Working Days"; Rec."Non Working Days")
                {
                }
            }
        }
    }
}