codeunit 72000 "Calendar Creation"
{

    trigger OnRun()
    begin
        HRPayrollSetup.Get(UserId);

        PayrollYear.Reset;
        PayrollYear.SetRange("Location Code", HRPayrollSetup."Location Code");
        PayrollYear.SetRange("Salary Plan Code", HRPayrollSetup."Salary Plan Code");
        PayrollYear.SetRange("Year Code", HRPayrollSetup."Salary Year Code");
        PayrollYear.SetRange("Year Type", PayrollYear."Year Type"::"Salary Year");
        PayrollYear.SetRange(Closed, false);
        PayrollYear.SetRange(Created, true);
        if PayrollYear.FindFirst then begin
            Message('Calendar Year \\Start Date => %1 \\End Date => %2', PayrollYear."Year Start Date", PayrollYear."Year End Date");

            if not Confirm('Do you want Create Calendar for the Year', false) then
                exit;

            StartDateTime := CurrentDateTime;
            "Create Calendar Year"(PayrollYear);
            "Weekly Off Updation"(PayrollYear);
            "Hoilday Updation"(PayrollYear);

            EndDateTime := CurrentDateTime;
            ElaspedTime := EndDateTime - StartDateTime;
            Message('Calendar Year Creation Completed \\ Starting Date & Time => %1 \\ Ending Date & Time => %2 \\ Time Elasped => %3',
            StartDateTime, EndDateTime, ElaspedTime);
            PayrollYear.Created := true;
            PayrollYear.Modify;
        end else
            Error('Calendar Year Already Generated..!!');
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        PayrollYear: Record "Payroll Year";
        CUGeneralFunctions: Codeunit "General Functions";
        EndDateTime: DateTime;
        StartDateTime: DateTime;
        ElaspedTime: Duration;

    local procedure "Create Calendar Year"(PayrollYear: Record "Payroll Year") Status: Boolean
    var
        Calendar: Record Calendar;
        Date: Record Date;
        RecordCnt: Integer;
    begin
        Clear(RecordCnt);

        Calendar.Reset;
        Calendar.SetRange("Location Code", PayrollYear."Location Code");
        Calendar.SetRange("Salary Plan Code", PayrollYear."Salary Plan Code");
        Calendar.SetRange("Calendar Year", PayrollYear."Year Code");
        RecordCnt := Calendar.Count;

        if RecordCnt > 0 then
            Calendar.DeleteAll;

        CUGeneralFunctions.OpenWindow('Calender Year Creation\\', 'Progress');

        Date.Reset;
        Date.SetRange("Period Type", Date."Period Type"::Date);
        Date.SetRange("Period Start", PayrollYear."Year Start Date", PayrollYear."Year End Date");
        RecordCnt := Date.Count;
        if Date.FindFirst then
            repeat
                Calendar.Init;
                Calendar."Location Code" := PayrollYear."Location Code";
                Calendar."Salary Plan Code" := PayrollYear."Salary Plan Code";
                Calendar."Calendar Year" := PayrollYear."Year Code";
                Calendar.Date := Date."Period Start";
                Calendar.Description := Date."Period Name";
                Calendar."Day No." := Date."Period No.";
                Calendar."Week No." := Round((Date2DMY(Calendar.Date, 1) / 7), 1, '>');
                if Calendar.Insert then;

                CUGeneralFunctions.UpdateWindow(Format(Calendar.Date), RecordCnt);

            until Date.Next = 0;

        CUGeneralFunctions.CloseWindow;
        exit(true);
    end;

    local procedure "Weekly Off Updation"(PayrollYear: Record "Payroll Year") Status: Boolean
    var
        WeeklyOff: Record "Weekly Off";
        Calendar: Record Calendar;
    begin
        WeeklyOff.Reset;
        WeeklyOff.SetRange("Location Code", PayrollYear."Location Code");
        WeeklyOff.SetRange("Salary Plan Code", PayrollYear."Salary Plan Code");
        WeeklyOff.SetRange("Calendar Year", PayrollYear."Year Code");
        if WeeklyOff.FindFirst then
            repeat
                if WeeklyOff."Week Wise (Weekly Off)" = WeeklyOff."Week Wise (Weekly Off)"::"All Week" then begin
                    Calendar.Reset;
                    Calendar.SetRange("Location Code", WeeklyOff."Location Code");
                    Calendar.SetRange("Salary Plan Code", WeeklyOff."Salary Plan Code");
                    Calendar.SetRange("Calendar Year", WeeklyOff."Calendar Year");
                    Calendar.SetRange("Day No.", WeeklyOff."Day No.");
                    if Calendar.FindFirst then
                        repeat
                            Calendar.WeeklyOff := true;
                            Calendar."First Half (Weekly Off)" := WeeklyOff."First Half (Weekly Off)";
                            Calendar."Second Half (Weekly Off)" := WeeklyOff."Second Half (Weekly Off)";
                            Calendar."Non-Working Days" := true;
                            Calendar.Modify;
                        until Calendar.Next = 0;
                end;

                if WeeklyOff."Week Wise (Weekly Off)" <> WeeklyOff."Week Wise (Weekly Off)"::"All Week" then begin
                    Calendar.Reset;
                    Calendar.SetRange("Location Code", WeeklyOff."Location Code");
                    Calendar.SetRange("Salary Plan Code", WeeklyOff."Salary Plan Code");
                    Calendar.SetRange("Calendar Year", WeeklyOff."Calendar Year");
                    Calendar.SetRange("Day No.", WeeklyOff."Day No.");
                    Calendar.SetRange("Week No.", WeeklyOff."Week Wise (Weekly Off)");
                    if Calendar.FindFirst then
                        repeat
                            Calendar.WeeklyOff := true;
                            Calendar."First Half (Weekly Off)" := WeeklyOff."First Half (Weekly Off)";
                            Calendar."Second Half (Weekly Off)" := WeeklyOff."Second Half (Weekly Off)";
                            Calendar."Non-Working Days" := true;
                            Calendar.Modify;
                        until Calendar.Next = 0;
                end;
            until WeeklyOff.Next = 0;
        exit(true);
    end;

    local procedure "Hoilday Updation"(PayrollYear: Record "Payroll Year") Status: Boolean
    var
        Hoildays: Record Holidays;
        Calendar: Record Calendar;
    begin
        Calendar.Reset;
        Calendar.SetRange("Location Code", PayrollYear."Location Code");
        Calendar.SetRange("Salary Plan Code", PayrollYear."Salary Plan Code");
        Calendar.SetRange("Calendar Year", PayrollYear."Year Code");
        if Calendar.FindFirst then
            repeat
                if Hoildays.Get(Calendar.Date, PayrollYear."Location Code",
                   PayrollYear."Salary Plan Code", PayrollYear."Year Code")
                then begin
                    Calendar.Description := Hoildays."Holiday Name" + ' - ' + Calendar.Description;
                    Calendar.Holiday := true;
                    Calendar."First Half (Holiday)" := Hoildays."First Half (Holiday)";
                    Calendar."Second Half (Holiday)" := Hoildays."Second Half (Holiday)";
                    Calendar."Non-Working Days" := true;
                    Calendar."OT Applicable for the Day" := Hoildays."OT Applicable for the Day";
                    Calendar.Modify;
                end;
            until Calendar.Next = 0;
        exit(true);
    end;
}

