page 71065 "Exam Schedule Head Card"
{
    PageType = Document;
    SourceTable = "Exam Schedule Head - SCH";
    ApplicationArea = All;
    Caption = 'Exam Schedule Head Card';
    Editable = true;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.") { }
                field(Date; Rec.Date) { }
                field("Exam Code"; Rec."Exam Code") { }
                field("Exam Slot"; Rec."Exam Slot") { }
                field("Start Time"; Rec."Start Time") { }
                field("End Time"; Rec."End Time") { }
                field("Academic Year"; Rec."Academic Year") { }
                field("No. Series"; Rec."No. Series") { }
                field("Portal ID"; Rec."Portal ID") { }
            }
            part(ExamScheduleLines; "Exam Schedule Line Part")
            {
                SubPageLink = "Document No." = field("No.");
            }

        }
    }

    actions
    {
        area(Navigation) { }
    }
}