page 71027 "Student Attendance Card"
{
    PageType = Document;
    SourceTable = "Student Attendance Header";
    ApplicationArea = All;
    Caption = 'Student Attendance';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
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
                field("Staff Name"; Rec."Staff Name") { ApplicationArea = All; }
                field("Present All"; Rec."Present All") { ApplicationArea = All; }
            }

            part(Lines; "Student Attendance Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }
}