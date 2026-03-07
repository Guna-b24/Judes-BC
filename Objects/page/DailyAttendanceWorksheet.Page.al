page 71128 "Daily Attendance Worksheet"
{
    PageType = Worksheet;
    SourceTable = "Daily Attendance";
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Daily Attendance';

    layout
    {
        area(Content)
        {
            // =========================
            // HEADER SECTION
            // =========================
            group(General)
            {
                Caption = 'General';

                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location of the employee.';
                }

                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    Caption = 'Salary Plan Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the salary plan assigned to the employee.';
                }

                field("Salary Cyclic Code"; Rec."Salary Cyclic Code")
                {
                    Caption = 'Salary Cycle Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the salary cycle code for the employee.';
                }

                field("Employee No"; Rec."Employee No")
                {
                    Caption = 'Employee Number';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique employee number.';
                }

                field(Name; Rec.Name)
                {
                    Caption = 'Employee Name';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Displays the name of the employee.';
                }

                field("Attendance Verified"; Rec."Attendance Verified")
                {
                    Caption = 'Attendance Verified';
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether the attendance has been verified.';
                }
            }

            // =========================
            // LINES SECTION (REPEATER)
            // =========================
            repeater(AttendanceLines)
            {
                Caption = 'Attendance Lines';


                field("Attendance Date"; Rec."Attendance Date")
                {
                    Caption = 'Attendance Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of attendance.';
                }

                field("Shift Code"; Rec."Shift Code")
                {
                    Caption = 'Shift Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shift assigned for this attendance.';
                }

                field("In Time"; Rec."In Time")
                {
                    Caption = 'In Time';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the clock-in time of the employee.';
                }

                field("Out Time"; Rec."Out Time")
                {
                    Caption = 'Out Time';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the clock-out time of the employee.';
                }

                field("Hours Worked"; Rec."Hours Worked")
                {
                    Caption = 'Hours Worked';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Displays total hours worked by the employee.';
                }

                field("Total Break Hours"; Rec."Total Break Hours")
                {
                    Caption = 'Total Break Hours';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Displays total break hours taken by the employee.';
                }

                field("Late Coming Hours"; Rec."Late Coming Hours")
                {
                    Caption = 'Late Coming Hours';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Displays hours of late arrival.';
                }

                field("Early Going Hours"; Rec."Early Going Hours")
                {
                    Caption = 'Early Going Hours';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Displays hours of early departure.';
                }

                field("Early OT Hours"; Rec."Early OT Hours")
                {
                    Caption = 'Early OT Hours';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Displays early overtime hours.';
                }

                field("Late OT Hours"; Rec."Late OT Hours")
                {
                    Caption = 'Late OT Hours';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Displays late overtime hours.';
                }

                field("Total OT In Mins"; Rec."Total OT In Mins")
                {
                    Caption = 'Total OT (Minutes)';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Displays total overtime in minutes.';
                }

                field("First Half Attendance Type"; Rec."First Half Attendance Type")
                {
                    Caption = 'First Half Attendance Type';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the attendance type for the first half of the day.';
                }

                field("Second Half Attendance Type"; Rec."Second Half Attendance Type")
                {
                    Caption = 'Second Half Attendance Type';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the attendance type for the second half of the day.';
                }

                field("Lay Off (Yes/No)"; Rec."Lay Off (Yes/No)")
                {
                    Caption = 'Lay Off';
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether it is a layoff day (Yes/No).';
                }

                field("Non Working Day"; Rec."Non Working Day")
                {
                    Caption = 'Non-Working Day';
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether it is a non-working day.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(VerifyAttendance)
            {
                Caption = 'Verify Attendance';
                Image = Confirm;
                ApplicationArea = All;
                ToolTip = 'Mark selected attendance records as verified.';

                trigger OnAction()
                var
                    AttendanceMgt: Codeunit "Attendance Creation";
                begin
                    AttendanceMgt.ConfirmAndVerifyAttendance(
                        Rec."Location Code",
                        Rec."Salary Plan Code",
                        Rec."Salary Cyclic Code",
                        Rec."Employee No");

                    CurrPage.UPDATE(FALSE);
                end;
            }
            action(PunchInfo)
            {
                Caption = 'Punch Info';
                Image = Refresh;
                ApplicationArea = All;
                ToolTip = 'Show punch/shift information for the selected employee.';

                trigger OnAction()
                var
                    AttendanceMgt: Codeunit "Attendance Creation";
                begin
                    AttendanceMgt.GetPunchInfo(
                        Rec."Location Code",
                        Rec."Salary Plan Code",
                        Rec."Salary Cyclic Code",
                        Rec."Employee No",
                        Rec."Shift Code");

                    CurrPage.UPDATE(FALSE);
                end;
            }
            action(UpdateBlankTime)
            {
                Caption = 'Update Blank Time';
                Image = Calculate; // standard BC icon
                ApplicationArea = All;
                ToolTip = 'Fill blank In/Out times for the selected employee.';

                trigger OnAction()
                var
                    employee: Record "Employee Alll";
                    AttendanceMgmt: Codeunit "Attendance Creation";


                begin
                    // 1. Confirm with user
                    if not Confirm('Are you sure to update blank times <Yes/No>?') then
                        exit;

                    // 2. Call the existing procedure in your Codeunit
                    AttendanceMgmt.UpdateBlankTime(
                        Rec."Location Code",
                        Rec."Salary Plan Code",
                        Rec."Salary Cyclic Code",
                        Rec."Employee No",
                        rec."Attendance Date",
                        rec."Attendance Date",
                        Employee."Employee Category");

                    // 3. Refresh the page
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action(UpdateDefaultTime)
            {
                Caption = 'Update Default Time';
                Image = Calculate; // standard BC icon
                ApplicationArea = All;
                ToolTip = 'Fill default In/Out times for the selected employee.';

                trigger OnAction()
                var
                    AttendanceMgmt: Codeunit "Attendance Creation";
                    Employee: Record "Employee Alll";
                begin
                    // 1. Confirm with user
                    if not Confirm('Are you sure to update default times <Yes/No>?') then
                        exit;

                    // 2. Call the existing procedure in your Codeunit
                    AttendanceMgmt.UpdateDefaultTime(
                        Rec."Location Code",
                        Rec."Salary Plan Code",
                        Rec."Salary Cyclic Code",
                        Rec."Employee No", Rec."Attendance Date", rec."Attendance Date", Employee."Employee Category");

                    // 3. Refresh page to show updated data
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action(UpdateShiftTime)
            {
                Caption = 'Update Shift Time';
                Image = Calculate; // standard BC icon
                ApplicationArea = All;
                ToolTip = 'Update shift In/Out times for the selected employee.';

                trigger OnAction()
                var
                    Employee: Record "Employee Alll";
                    AttendanceMgmt: Codeunit "Attendance Creation";

                begin
                    // 1. Confirm with user
                    if not Confirm('Are you sure to update shift times <Yes/No>?') then
                        exit;

                    // 2. Call existing Codeunit procedure
                    AttendanceMgmt.UpdateShiftTime(
                        Rec."Location Code",
                        Rec."Salary Plan Code",
                        Rec."Salary Cyclic Code",
                        Rec."Employee No",
                        Rec."Attendance Date",
                        Rec."Attendance Date",
                        Rec."Shift Code",
                        Employee."Employee Category");

                    // 3. Refresh the page to show updated data
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action(GetPunchTime)
            {
                Caption = 'Get Punch Time';
                Image = Calculate; // standard BC icon
                ApplicationArea = All;
                ToolTip = 'Update blank or punch times for the selected employee.';

                trigger OnAction()
                var
                    Employee: Record "Employee Alll";
                    AttendanceMgmt: Codeunit "Attendance Creation";

                begin
                    // 1. Confirm with user
                    if not Confirm('Are you sure to update punch times <Yes/No>?') then
                        exit;

                    // 2. Call existing Codeunit procedure
                    AttendanceMgmt.UpdateBlankTime(
                        Rec."Location Code",
                        Rec."Salary Plan Code",
                        Rec."Salary Cyclic Code",
                        Rec."Employee No",
                        Rec."Attendance Date",
                        Rec."Attendance Date",
                        Employee."Employee Category");

                    // 3. Refresh page to show updated data
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
    }
}
