page 71036 "Daily Attendance List"
{
    Caption = 'Daily Attendance';
    PageType = List;
    SourceTable = "Daily Attendance";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Cyclic Code"; Rec."Salary Cyclic Code")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = All;
                }
                field("In Time"; Rec."In Time")
                {
                    ApplicationArea = All;
                }
                field("Out Time"; Rec."Out Time")
                {
                    ApplicationArea = All;
                }
                field("Hours Worked"; Rec."Hours Worked")
                {
                    ApplicationArea = All;
                }
                field("Total Hours Worked"; Rec."Total Hours Worked")
                {
                    ApplicationArea = All;
                }
                field("First Half Attendance Type"; Rec."First Half Attendance Type")
                {
                    ApplicationArea = All;
                }
                field("Second Half Attendance Type"; Rec."Second Half Attendance Type")
                {
                    ApplicationArea = All;
                }
                field("Payable Days"; Rec."Payable Days")
                {
                    ApplicationArea = All;
                }
                field("Salary Processed"; Rec."Salary Processed")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(EditAttendance)
            {
                Caption = 'Edit';
                ApplicationArea = All;
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    PAGE.Run(PAGE::"Daily Attendance List", Rec);
                end;
            }
        }
    }
}