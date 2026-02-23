page 70038 "Daily Punch Details List"
{
    Caption = 'Daily Punch Details';
    PageType = List;
    SourceTable = "Daily Punch Details";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Salary Cyclic Code"; Rec."Salary Cyclic Code") { ApplicationArea = All; }
                field("Employee No."; Rec."Employee No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Attendance Date"; Rec."Attendance Date") { ApplicationArea = All; }
                field("Line No."; Rec."Line No.") { ApplicationArea = All; }
                field("In Punch DateTime"; Rec."In Punch DateTime") { ApplicationArea = All; }
                field("Out Punch DateTime"; Rec."Out Punch DateTime") { ApplicationArea = All; }
                field("Total Hours"; Rec."Total Hours") { ApplicationArea = All; }
                field("No of Pieces"; Rec."No of Pieces") { ApplicationArea = All; }
                field("Department Code"; Rec."Department Code") { ApplicationArea = All; }
                field("Attendance Verified"; Rec."Attendance Verified") { ApplicationArea = All; }
            }
        }
    }
}