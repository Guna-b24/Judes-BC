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
                field("No."; Rec."No.") { }
                field(Date; Rec.Date) { }
                field("Exam Code"; Rec."Exam Code") { }
                field("Exam Slot"; Rec."Exam Slot") { }
                field("Start Time"; Rec."Start Time") { }
                field("End Time"; Rec."End Time") { }
                field("Academic Year"; Rec."Academic Year") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}