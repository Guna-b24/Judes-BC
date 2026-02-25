page 71029 "Student Attendance Lines"
{
    PageType = ListPart;
    SourceTable = "Student Attendance Line";
    ApplicationArea = All;
    Caption = 'Attendance Lines';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.") { ApplicationArea = All; }
                field("Student No."; Rec."Student No.") { ApplicationArea = All; }
                field("Student Name"; Rec."Student Name") { ApplicationArea = All; }
                field("Attendance Type"; Rec."Attendance Type") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
            }
        }
    }
}