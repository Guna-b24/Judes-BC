page 71040 "Academics Setup"
{
    PageType = Card;
    SourceTable = "Academics Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Academics Setup';

    layout
    {
        area(Content)
        {
            group("Number Series")
            {
                field("Marks No."; Rec."Marks No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used for marks.';
                }
                field("Attendance No."; Rec."Attendance No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for attendance documents.';
                }
                field("Withdrawl No."; Rec."Withdrawl No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for Withdrawl No.';
                }
                field("TC No."; Rec."TC No.")
                {
                    ApplicationArea = All;
                }
                field("Class Syllabus No."; Rec."Class Syllabus No.")
                {
                    ApplicationArea = All;
                }
                field("Faculty Class Plan No."; Rec."Faculty Class Plan No.")
                {
                    ApplicationArea = All;
                }
                field("Exam Schedule No."; Rec."Exam Schedule No.")
                {
                    ApplicationArea = All;
                }
                field("Student Leave Application No."; Rec."Student Leave Application No.")
                {
                    ApplicationArea = All;
                }
                field("Prescription Nos."; Rec."Prescription Nos.")
                {
                    ApplicationArea = All;
                }
                field("Edu. Calender No."; Rec."Edu. Calender No.")
                {
                    ApplicationArea = All;
                }
            }

            group("Attendance Setup")
            {
                field(Attendance; Rec.Attendance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether attendance is tracked daily or hourly.';
                }
                field("Fore Noon Attendance Hour"; Rec."Fore Noon Attendance Hour")
                {
                    ApplicationArea = All;
                }
                field("After Noon Attendance Hour"; Rec."After Noon Attendance Hour")
                {
                    ApplicationArea = All;
                }
            }

            group("Permissions")
            {
                field("Mark Super User"; Rec."Mark Super User")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the portal user who has super user rights for marks.';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
