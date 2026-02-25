page 71030 "Student Attendance Line List"
{
    PageType = List;
    SourceTable = "Student Attendance Line";
    ApplicationArea = All;
    Caption = 'Student Attendance Line List';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                field("Line No."; Rec."Line No.") { ApplicationArea = All; }
                field("Student No."; Rec."Student No.") { ApplicationArea = All; }
                field("Student Name"; Rec."Student Name") { ApplicationArea = All; }
                field("Attendance Type"; Rec."Attendance Type") { ApplicationArea = All; }
                field(Class; Rec.Class) { ApplicationArea = All; }
                field(Section; Rec.Section) { ApplicationArea = All; }
                field(Curriculum; Rec.Curriculum) { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field(Date; Rec.Date) { ApplicationArea = All; }
                field(Hour; Rec.Hour) { ApplicationArea = All; }
            }
        }
    }
}