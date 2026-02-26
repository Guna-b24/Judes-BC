page 72182 "TimeSheet Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Time Sheet";
    Caption = 'Time Sheet';

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Attend Date"; Rec."Attend Date")
                {
                }
                field("Line No"; Rec."Line No")
                {
                }
                field("Time From"; Rec."Time From")
                {
                }
                field("Time To"; Rec."Time To")
                {
                }
                field("Total Hours"; Rec."Total Hours")
                {
                    Editable = false;
                }
                field("Name of the Task"; Rec."Name of the Task")
                {
                }
                field(Completed; Rec.Completed)
                {
                }
            }
        }
    }
}