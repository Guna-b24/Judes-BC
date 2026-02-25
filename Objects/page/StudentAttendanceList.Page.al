page 71028 "Student Attendance List"
{
    PageType = List;
    SourceTable = "Student Attendance Header";
    ApplicationArea = All;
    Caption = 'Student Attendance List';
    UsageCategory = Lists;
    CardPageId = "Student Attendance Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Class Code"; Rec."Class Code") { ApplicationArea = All; }
                field(Class; Rec.Class) { ApplicationArea = All; }
                field(Section; Rec.Section) { ApplicationArea = All; }
                field(Curriculum; Rec.Curriculum) { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field("Subject Code"; Rec."Subject Code") { ApplicationArea = All; }
                field(Date; Rec.Date) { ApplicationArea = All; }
                field("FN/AN"; Rec."FN/AN") { ApplicationArea = All; }
                field(Hour; Rec.Hour) { ApplicationArea = All; }
                field("Staff Code"; Rec."Staff Code") { ApplicationArea = All; }
            }
        }
    }
}