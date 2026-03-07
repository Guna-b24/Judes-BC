codeunit 72001 "Attendance Creation"
{
    trigger OnRun()
    begin
        HRPayrollSetup.Get(UserId);

        PayrollYear.Reset();
        PayrollYear.SetRange("Location Code", HRPayrollSetup."Location Code");
        PayrollYear.SetRange("Salary Plan Code", HRPayrollSetup."Salary Plan Code");
        PayrollYear.SetRange("Year Code", HRPayrollSetup."Salary Year Code");
        PayrollYear.SetRange("Year Type", PayrollYear."Year Type"::"Salary Year");
        PayrollYear.SetRange(Closed, false);
        PayrollYear.SetRange(Created, true);
        if PayrollYear.FindFirst() then begin
            Message('Daily Attendance Creation \\Start Date => %1 \\End Date => %2',
              PayrollYear."Year Start Date", PayrollYear."Year End Date");

            if not Confirm('Do you want Create Daily Attendance for the Leave Year', false) then
                exit;

            StartDateTime := CurrentDateTime;
            "Create Daily Attendance"(PayrollYear);
            EndDateTime := CurrentDateTime;
            ElaspedTime := EndDateTime - StartDateTime;

            Message('Daily Attendance Creation Completed \\ Starting Date & Time => %1 \\ Ending Date & Time => %2 \\ Time Elasped => %3',
              StartDateTime, EndDateTime, ElaspedTime);

            PayrollYear.Created := true;
            PayrollYear.Modify();
        end else
            Error('Daily Attendance Already Generated..!!');
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        PayrollYear: Record "Payroll Year";
        Employee: Record Employee;
        CUGeneralFunctions: Codeunit "General Functions";
        DateCheck: Date;
        EndDateTime: DateTime;
        StartDateTime: DateTime;
        ElaspedTime: Duration;


    procedure "Create Daily Attendance"(PayrollYear: Record "Payroll Year") Status: Boolean
    var
        VarEmployee: Record Employee;
        PayrollYear1: Record "Payroll Year";
        PayrollMonthYear: Record "Payroll Month & Year";
        Calendar: Record Calendar;
        Shift: Record Shift;
        DailyAttendance: Record "Daily Attendance";
        RecordCount: Integer;
    begin
        VarEmployee.Reset();
        VarEmployee.SetRange("Salary Plan Code", PayrollYear."Salary Plan Code");
        VarEmployee.SetRange("Location Code", PayrollYear."Location Code");
        VarEmployee.SetRange(Status, Employee.Status::Active);
        VarEmployee.SetRange("Attendance Generated", false);
        if VarEmployee.FindFirst() then begin
            CUGeneralFunctions.OpenWindow('Daily Attedance Creation\\', 'Progress');
            RecordCount := Employee.Count;
            repeat
                "Mantory Field Checkup"(Employee."No.");
                Calendar.Reset();
                Calendar.SetRange("Location Code", PayrollYear."Location Code");
                Calendar.SetRange("Salary Plan Code", PayrollYear."Salary Plan Code");
                Calendar.SetRange(Date, PayrollYear."Year Start Date", PayrollYear."Year End Date");
                if Calendar.FindFirst() then
                    repeat
                        DailyAttendance.Init();
                        DailyAttendance."Location Code" := Employee."Location Code";
                        DailyAttendance."Salary Plan Code" := Employee."Salary Plan Code";
                        DailyAttendance."Employee No" := Employee."No.";
                        DailyAttendance.Name := Employee."First Name" + ' ' + Employee.Initials;
                        DailyAttendance."Attendance Date" := Calendar.Date;
                        DailyAttendance."Day No." := Calendar."Day No.";
                        DailyAttendance."Week No" := Date2DWY(Calendar.Date, 2);
                        DailyAttendance.Month := Date2DMY(Calendar.Date, 2);
                        DailyAttendance.Year := Date2DMY(Calendar.Date, 3);
                        DailyAttendance."Employee Category" := Employee."Employee Category";
                        DailyAttendance."Weekly Off Status" := Calendar.WeeklyOff;
                        DailyAttendance."Holiday Status" := Calendar.Holiday;
                        DailyAttendance."Non Working Day" := Calendar."Non-Working Days";

                        PayrollYear1.Reset();
                        PayrollYear1.SetRange("Location Code", Employee."Location Code");
                        PayrollYear1.SetRange("Salary Plan Code", Employee."Salary Plan Code");
                        PayrollYear1.SetRange("Year Type", PayrollYear1."Year Type"::"Leave Year");
                        PayrollYear1.SetRange(Closed, false);
                        if PayrollYear1.Find('-') then
                            DailyAttendance."Leave Year Code" := PayrollYear1."Year Code";

                        PayrollYear.Reset();
                        PayrollYear.SetRange("Location Code", Employee."Location Code");
                        PayrollYear.SetRange("Salary Plan Code", Employee."Salary Plan Code");
                        PayrollYear.SetRange("Year Type", PayrollYear."Year Type"::"Leave Year");
                        PayrollYear.SetRange(Closed, false);
                        if PayrollYear.FindFirst() then
                            DailyAttendance."Leave Year Code" := PayrollYear."Year Code";

                        PayrollMonthYear.Reset();
                        PayrollMonthYear.SetRange("Location Code", Employee."Location Code");
                        PayrollMonthYear.SetRange("Salary Plan Code", Employee."Salary Plan Code");
                        PayrollMonthYear.SetRange("Salary Start Date", DailyAttendance."Attendance Date");
                        if PayrollMonthYear.FindFirst() then
                            DailyAttendance."Salary Cyclic Code" := PayrollMonthYear."Salary Cyclic Code"
                        else
                            DateCheck := PayrollMonthYear."Salary End Date";

                        if DailyAttendance."Attendance Date" <= DateCheck then
                            DailyAttendance."Salary Cyclic Code" := PayrollMonthYear."Salary Cyclic Code";

                        HRPayrollSetup.Get(UserId);
                        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");

                        if not Calendar."Non-Working Days" then
                            DailyAttendance."OT Approved Hrs" := LocationHRPayrollSetup."Over Time Max Minutes";

                        if not Calendar."Non-Working Days" then begin
                            Shift.Get(Employee."Working Shift Code", Employee."Location Code", Employee."Salary Plan Code");
                            DailyAttendance."Shift Code" := Shift.Code;

                            if LocationHRPayrollSetup."Default Attendance Type" = LocationHRPayrollSetup."Default Attendance Type"::" "
                            then begin
                                DailyAttendance."In Time" := 0T;
                                DailyAttendance."Out Time" := 0T;
                            end
                            else begin
                                DailyAttendance."In Time" := Shift."First Half Starting Time";
                                DailyAttendance."Out Time" := Shift."Second Half Ending Time";
                            end;
                            DailyAttendance."Actual Time In" := Shift."First Half Starting Time";
                            DailyAttendance."Actual Time Out" := Shift."Second Half Ending Time";
                            DailyAttendance."Total Break Hours" := Shift."Break Total Hours";
                            DailyAttendance."First Half Attendance Type" := LocationHRPayrollSetup."Default Attendance Type";
                            DailyAttendance."Second Half Attendance Type" := LocationHRPayrollSetup."Default Attendance Type";
                            DailyAttendance."Actual Hrs" := LocationHRPayrollSetup."No of Hours Per Day";
                        end;

                        if (Calendar."Non-Working Days") and (Calendar."First Half (Weekly Off)" = false) then
                            if Shift.Get(Employee."Working Shift Code", Employee."Location Code", Employee."Salary Plan Code") then begin
                                DailyAttendance."Shift Code" := Shift.Code;
                                if LocationHRPayrollSetup."Default Attendance Type" = LocationHRPayrollSetup."Default Attendance Type"::" "
                                   then begin
                                    DailyAttendance."In Time" := 0T;
                                    DailyAttendance."Out Time" := 0T;
                                end
                                else begin
                                    DailyAttendance."In Time" := Shift."First Half Starting Time";
                                    DailyAttendance."Out Time" := Shift."Second Half Ending Time";
                                end;
                                DailyAttendance."Actual Time In" := Shift."First Half Starting Time";
                                DailyAttendance."Actual Time Out" := Shift."First Half Ending Time";
                                DailyAttendance."First Half Attendance Type" := LocationHRPayrollSetup."Default Attendance Type";
                                DailyAttendance."Actual Hrs" := LocationHRPayrollSetup."No of Hours in Half Day";
                            end;

                        if Calendar."First Half (Holiday)" then begin
                            DailyAttendance."In Time" := 0T;
                            DailyAttendance."Out Time" := 0T;
                            DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::Holiday;
                        end;

                        if Calendar."Second Half (Holiday)" then begin
                            DailyAttendance."In Time" := 0T;
                            DailyAttendance."Out Time" := 0T;
                            DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::Holiday;
                        end;

                        if Calendar."First Half (Weekly Off)" then
                            DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::"Weekly Off";

                        if Calendar."Second Half (Weekly Off)" then
                            DailyAttendance."Second Half Attendance Type" := DailyAttendance."First Half Attendance Type"::"Weekly Off";

                        //----------- Not Joined Updating for Newly Joined Peoples.

                        if DailyAttendance."Attendance Date" < Employee."Employment Date" then begin
                            DailyAttendance."In Time" := 0T;
                            DailyAttendance."Out Time" := 0T;
                            DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::"Not Joined";
                            DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::"Not Joined";
                            DailyAttendance."Non Working Day" := true;
                        end;
                        //------------
                        if (Calendar."First Half (Weekly Off)") or (Calendar."Second Half (Weekly Off)") then
                            DailyAttendance."Weekly Off Status" := true;

                        if (Calendar."First Half (Holiday)") or (Calendar."Second Half (Holiday)") then
                            DailyAttendance."Holiday Status" := true;

                        if (DailyAttendance."Weekly Off Status") or (DailyAttendance."Holiday Status") then
                            DailyAttendance."Non Working Day" := true;

                        DailyAttendance.Validate("In Time");
                        DailyAttendance.Validate("Out Time");
                        DailyAttendance.Validate("First Half Attendance Type");
                        DailyAttendance.Validate("Second Half Attendance Type");

                        if DailyAttendance.Insert() then;

                    until Calendar.Next() = 0;

                "Create Monthly Attendance"(Employee, PayrollYear);

                Employee."Attendance Generated" := true;

                if Employee.Modify() then;

                CUGeneralFunctions.UpdateWindow(Employee."No.", RecordCount);

            until Employee.Next() = 0;
            CUGeneralFunctions.CloseWindow();
        end else
            Error('No Records found..!!');
    end;

    local procedure "Create Monthly Attendance"(Employee: Record Employee; PayrollYear: Record "Payroll Year")
    var
        PayrollMonthYear: Record "Payroll Month & Year";
        MonthlyAttendance: Record "Monthly Attendance";
    begin
        PayrollMonthYear.Reset();
        PayrollMonthYear.SetRange("Location Code", Employee."Location Code");
        PayrollMonthYear.SetRange("Salary Plan Code", Employee."Salary Plan Code");
        PayrollMonthYear.SetRange("Salary Year Code", PayrollYear."Year Code");
        if PayrollMonthYear.FindFirst then
            repeat
                MonthlyAttendance.Init();
                MonthlyAttendance."Location Code" := PayrollYear."Location Code";
                MonthlyAttendance."Salary Plan Code" := PayrollYear."Salary Plan Code";
                MonthlyAttendance."Salary Cycle Code" := PayrollMonthYear."Salary Cyclic Code";
                MonthlyAttendance.Year := PayrollMonthYear."Salary Year";
                MonthlyAttendance.Month := PayrollMonthYear."Salary Month";
                MonthlyAttendance."Payroll Start Date" := PayrollMonthYear."Salary Start Date";
                MonthlyAttendance."Payroll End Date" := PayrollMonthYear."Salary End Date";
                MonthlyAttendance."Employee No" := Employee."No.";
                MonthlyAttendance.Name := Employee."First Name" + ' ' + Employee.Initials;
                MonthlyAttendance."Employee Category" := Employee."Employee Category";
                if MonthlyAttendance.Insert() then;
            until PayrollMonthYear.Next() = 0;
    end;

    local procedure "Mantory Field Checkup"(EmployeeNo: Code[20])
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmployeeNo) then begin
            Employee.TestField("Location Code");
            Employee.TestField("Salary Plan Code");
            Employee.TestField("No.");
            Employee.TestField("First Name");
            //  Employee.TESTFIELD(Initials);
            Employee.TestField("Employment Date");
            Employee.TestField("Working Shift Code");
            //  Employee.TESTFIELD("Birth Date");
            Employee.TestField("Employee Category");
            //  Employee.TESTFIELD("Division Code");
            //  Employee.TESTFIELD("Department Code");
            //  Employee.TESTFIELD("Section Code");
            //  Employee.TESTFIELD("Emp Posting Group");
            //  Employee.TESTFIELD("Pay Bus. Posting Group");
        end;
    end;

    procedure UpdateBlankTime(LocationCode: Code[20]; SalaryPlanCode: Code[20]; SalaryCylicCode: Code[20]; EmployeeNo: Code[20]; StartDate: Date; EndDate: Date; EmployeeCategory: Option " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary")
    var
        DailyAttendance: Record "Daily Attendance";
        RecordCount: Integer;
    begin
        if EmployeeNo = 'ALL' then
            CUGeneralFunctions.OpenWindow('Daily Attendance Update Blank Time\\', 'Progress');

        DailyAttendance.Reset();
        DailyAttendance.SetRange("Location Code", LocationCode);
        DailyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        DailyAttendance.SetRange("Salary Cyclic Code", SalaryCylicCode);
        if EmployeeNo <> 'ALL' then
            DailyAttendance.SetRange("Employee No", EmployeeNo);
        DailyAttendance.SetRange("Attendance Date", StartDate, EndDate);
        //DailyAttendance.SETRANGE("Employee Category", EmployeeCategory);
        DailyAttendance.SetRange("Attendance Verified", false);
        DailyAttendance.SetRange("Manual Entry", false);
        RecordCount := DailyAttendance.Count;
        if DailyAttendance.FindFirst() then
            repeat
                DailyAttendance."In Time" := 0T;
                DailyAttendance."Out Time" := 0T;
                DailyAttendance."Total Permission In Mins" := 0;
                DailyAttendance."Total OT In Mins" := 0;
                DailyAttendance."Late Coming Hours" := 0;
                DailyAttendance."Early Going Hours" := 0;
                DailyAttendance."Early OT Hours" := 0;
                DailyAttendance."Late OT Hours" := 0;
                DailyAttendance."Manual Entry" := false;
                if Employee.Get(DailyAttendance."Employee No") then
                    if DailyAttendance."Attendance Date" < Employee."Employment Date" then begin
                        DailyAttendance."In Time" := 0T;
                        DailyAttendance."Out Time" := 0T;
                        DailyAttendance."Weekly Off Status" := false;
                        DailyAttendance."Holiday Status" := false;
                        DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::"Not Joined";
                        DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::"Not Joined";
                        DailyAttendance."Non Working Day" := true;
                    end;

                DailyAttendance.Validate("First Half Attendance Type");
                DailyAttendance.Validate("Second Half Attendance Type");
                DailyAttendance.Validate("In Time");
                DailyAttendance.Validate("Out Time");
                DailyAttendance.Modify();

                if EmployeeNo = 'ALL' then
                    CUGeneralFunctions.UpdateWindow(DailyAttendance."Employee No", RecordCount);

            until DailyAttendance.Next() = 0;

        if EmployeeNo = 'ALL' then
            CUGeneralFunctions.CloseWindow();
    end;

    procedure UpdateDefaultTime(LocationCode: Code[20]; SalaryPlanCode: Code[20]; SalaryCylicCode: Code[20]; EmployeeNo: Code[20]; StartDate: Date; EndDate: Date; EmployeeCategory: Option " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary")
    var
        Shift: Record Shift;
        DailyAttendance: Record "Daily Attendance";
        RecordCount: Integer;
    begin
        CUGeneralFunctions.OpenWindow('Daily Attedance Update Default Time\\', 'Progress');

        HRPayrollSetup.Get(UserId);
        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
        DailyAttendance.Reset();
        DailyAttendance.SetRange("Location Code", LocationCode);
        DailyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        DailyAttendance.SetRange("Salary Cyclic Code", SalaryCylicCode);
        if EmployeeNo <> 'ALL' then
            DailyAttendance.SetRange("Employee No", EmployeeNo);
        DailyAttendance.SetRange("Attendance Date", StartDate, EndDate);
        DailyAttendance.SetRange("Employee Category", EmployeeCategory);
        DailyAttendance.SetRange("Attendance Verified", false);
        DailyAttendance.SetRange("Manual Entry", false);
        RecordCount := DailyAttendance.Count;
        if DailyAttendance.FindFirst() then
            repeat
                if DailyAttendance."Shift Code" <> '' then begin
                    Shift.Get(DailyAttendance."Shift Code", LocationCode, SalaryPlanCode);
                    DailyAttendance."Shift Code" := Shift.Code;
                    DailyAttendance."In Time" := Shift."First Half Starting Time";
                    DailyAttendance."Out Time" := Shift."Second Half Ending Time";
                    DailyAttendance."Actual Time In" := Shift."First Half Starting Time";
                    DailyAttendance."Actual Time Out" := Shift."Second Half Ending Time";
                    DailyAttendance."Total Break Hours" := Shift."Break Total Hours";
                    DailyAttendance."First Half Attendance Type" := LocationHRPayrollSetup."Default Attendance Type";
                    DailyAttendance."Second Half Attendance Type" := LocationHRPayrollSetup."Default Attendance Type";
                    DailyAttendance."Actual Hrs" := LocationHRPayrollSetup."No of Hours Per Day";
                    if DailyAttendance."Holiday Status" then begin
                        DailyAttendance."In Time" := 0T;
                        DailyAttendance."Out Time" := 0T;
                    end;
                end;

                if Employee.Get(DailyAttendance."Employee No") then
                    if DailyAttendance."Attendance Date" < Employee."Employment Date" then begin
                        DailyAttendance."In Time" := 0T;
                        DailyAttendance."Out Time" := 0T;
                        DailyAttendance."Weekly Off Status" := false;
                        DailyAttendance."Holiday Status" := false;
                        DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::"Not Joined";
                        DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::"Not Joined";
                        DailyAttendance."Non Working Day" := true;
                    end;

                DailyAttendance.Validate("First Half Attendance Type");
                DailyAttendance.Validate("Second Half Attendance Type");
                DailyAttendance.Validate("In Time");
                DailyAttendance.Validate("Out Time");
                DailyAttendance.Modify();
                CUGeneralFunctions.UpdateWindow(DailyAttendance."Employee No", RecordCount);
            until DailyAttendance.Next() = 0;
        CUGeneralFunctions.CloseWindow();
    end;


    procedure UpdateShiftTime(LocationCode: Code[20]; SalaryPlanCode: Code[20]; SalaryCylicCode: Code[20]; EmployeeNo: Code[20]; StartDate: Date; EndDate: Date; ShiftCode: Code[20]; EmployeeCategory: Option " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary")
    var
        Shift: Record Shift;
        DailyAttendance: Record "Daily Attendance";
        RecordCount: Integer;
    begin
        CUGeneralFunctions.OpenWindow('Daily Attedance Update Shift Time\\', 'Progress');
        DailyAttendance.Reset();
        DailyAttendance.SetRange("Location Code", LocationCode);
        DailyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        DailyAttendance.SetRange("Salary Cyclic Code", SalaryCylicCode);
        if EmployeeNo <> 'ALL' then
            DailyAttendance.SetRange("Employee No", EmployeeNo);
        DailyAttendance.SetRange("Attendance Date", StartDate, EndDate);
        DailyAttendance.SetRange("Employee Category", EmployeeCategory);
        DailyAttendance.SetFilter(Present, '=%1', 1);
        DailyAttendance.SetRange("Manual Entry", false);
        RecordCount := DailyAttendance.Count;
        if DailyAttendance.FindFirst() then
            Shift.Get(ShiftCode, LocationCode, SalaryPlanCode);
        repeat
            if DailyAttendance."Shift Code" <> '' then begin
                DailyAttendance."Shift Code" := Shift.Code;
                DailyAttendance."In Time" := Shift."First Half Starting Time";
                DailyAttendance."Out Time" := Shift."Second Half Ending Time";
                DailyAttendance."Actual Time In" := Shift."First Half Starting Time";
                DailyAttendance."Actual Time Out" := Shift."Second Half Ending Time";
                DailyAttendance."Total Break Hours" := Shift."Break Total Hours";
                DailyAttendance."First Half Attendance Type" := LocationHRPayrollSetup."Default Attendance Type";
                DailyAttendance."Second Half Attendance Type" := LocationHRPayrollSetup."Default Attendance Type";
                DailyAttendance."Actual Hrs" := LocationHRPayrollSetup."No of Hours Per Day";
                if DailyAttendance."Holiday Status" then begin
                    DailyAttendance."In Time" := 0T;
                    DailyAttendance."Out Time" := 0T;
                end;
                if Employee.Get(DailyAttendance."Employee No") then
                    if DailyAttendance."Attendance Date" < Employee."Employment Date" then begin
                        DailyAttendance."In Time" := 0T;
                        DailyAttendance."Out Time" := 0T;
                        DailyAttendance."Weekly Off Status" := false;
                        DailyAttendance."Holiday Status" := false;
                        DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::"Not Joined";
                        DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::"Not Joined";
                        DailyAttendance."Non Working Day" := true;
                    end;

                DailyAttendance.Validate("First Half Attendance Type");
                DailyAttendance.Validate("Second Half Attendance Type");
                DailyAttendance.Validate("In Time");
                DailyAttendance.Validate("Out Time");
                DailyAttendance.Modify();
                CUGeneralFunctions.UpdateWindow(DailyAttendance."Employee No", RecordCount);
            end;
        until DailyAttendance.Next() = 0;
        CUGeneralFunctions.CloseWindow();
    end;


    procedure "Validate Attendance Time"(LocationCode: Code[20]; SalaryPlanCode: Code[20]; SalaryCylicCode: Code[20]; EmployeeNo: Code[20]; StartDate: Date; EndDate: Date; EmployeeCategory: Option " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary")
    var
        DailyAttendance: Record "Daily Attendance";
        RecordCount: Integer;
    begin
        CUGeneralFunctions.OpenWindow('Update First Half Second Half Type\\', 'Progress');

        DailyAttendance.Reset();
        DailyAttendance.SetRange("Location Code", LocationCode);
        DailyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        DailyAttendance.SetRange("Salary Cyclic Code", SalaryCylicCode);
        if EmployeeNo <> 'ALL' then
            DailyAttendance.SetRange("Employee No", EmployeeNo);
        DailyAttendance.SetRange("Attendance Date", StartDate, EndDate);
        DailyAttendance.SetRange("Employee Category", EmployeeCategory);
        RecordCount := DailyAttendance.Count;
        if DailyAttendance.FindFirst() then
            repeat
                if Employee.Get(DailyAttendance."Employee No") then
                    if DailyAttendance."Attendance Date" < Employee."Employment Date" then begin
                        DailyAttendance."In Time" := 0T;
                        DailyAttendance."Out Time" := 0T;
                        DailyAttendance."Weekly Off Status" := false;
                        DailyAttendance."Holiday Status" := false;
                        DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::"Not Joined";
                        DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::"Not Joined";
                        DailyAttendance."Non Working Day" := true;
                    end;
                DailyAttendance.Validate("First Half Attendance Type");
                DailyAttendance.Validate("Second Half Attendance Type");
                DailyAttendance.Validate("In Time");
                DailyAttendance.Validate("Out Time");
                DailyAttendance.Modify();
                CUGeneralFunctions.UpdateWindow(DailyAttendance."Employee No", RecordCount);
            until DailyAttendance.Next() = 0;

        CUGeneralFunctions.CloseWindow();
    end;

    procedure UpdateEmployeeShiftTime(LocationCode: Code[20]; SalaryPlanCode: Code[20]; SalaryCylicCode: Code[20]; EmployeeNo: Code[20]; StartDate: Date; EndDate: Date; ShiftCode: Code[20]; EmployeeCategory: Option " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary")
    var
        DailyAttendance: Record "Daily Attendance";
        Shift: Record Shift;
        RecordCount: Integer;
    begin
        CUGeneralFunctions.OpenWindow('Daily Attedance Update Shift Time\\', 'Progress');
        DailyAttendance.Reset();
        DailyAttendance.SetRange("Location Code", LocationCode);
        DailyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        DailyAttendance.SetRange("Salary Cyclic Code", SalaryCylicCode);
        if (EmployeeNo <> 'ALL') then
            DailyAttendance.SetRange("Employee No", EmployeeNo);
        DailyAttendance.SetRange("Attendance Date", StartDate, EndDate);
        DailyAttendance.SetRange("Employee Category", EmployeeCategory);
        RecordCount := DailyAttendance.Count;
        if DailyAttendance.Find('-') then
            repeat

                DailyAttendance."Shift Code" := ShiftCode;
                Shift.Get(DailyAttendance."Shift Code", LocationCode, SalaryPlanCode);
                if DailyAttendance."Non Working Day" = false then begin
                    DailyAttendance."Actual Time In" := Shift."First Half Starting Time";
                    DailyAttendance."Actual Time Out" := Shift."Second Half Ending Time";
                    DailyAttendance."Total Break Hours" := Shift."Break Total Hours";
                end;

                if DailyAttendance."Non Working Day" then begin
                    DailyAttendance."Shift Code" := '';
                end;

                if Employee.Get(DailyAttendance."Employee No") then
                    if DailyAttendance."Attendance Date" < Employee."Employment Date" then begin
                        DailyAttendance."In Time" := 0T;
                        DailyAttendance."Out Time" := 0T;
                        DailyAttendance."Weekly Off Status" := false;
                        DailyAttendance."Holiday Status" := false;
                        DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::"Not Joined";
                        DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::"Not Joined";
                        DailyAttendance."Non Working Day" := true;
                    end;

                DailyAttendance.Validate("First Half Attendance Type");
                DailyAttendance.Validate("Second Half Attendance Type");
                DailyAttendance.Validate("In Time");
                DailyAttendance.Validate("Out Time");
                DailyAttendance.Modify();

                CUGeneralFunctions.UpdateWindow(DailyAttendance."Employee No", RecordCount);

            until DailyAttendance.Next() = 0;
        CUGeneralFunctions.CloseWindow();
    end;

    //DailyAttendance worksheet page code
    procedure VerifyAttendance(
       LocationCode: Code[20];
       SalaryPlanCode: Code[20];
       SalaryCycleCode: Code[20];
       EmployeeNo: Code[20];
       AttendanceVerified: Boolean)
    var
        DailyAttendance: Record "Daily Attendance";
    begin
        DailyAttendance.Reset();
        DailyAttendance.SetRange("Location Code", LocationCode);
        DailyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        DailyAttendance.SetRange("Salary Cyclic Code", SalaryCycleCode);
        DailyAttendance.SetRange("Employee No", EmployeeNo);

        if DailyAttendance.Find('-') then
            repeat
                DailyAttendance.Validate("Attendance Verified", AttendanceVerified);
                DailyAttendance.Modify();
            until DailyAttendance.Next() = 0;
    end;

    // =========================
    // Confirm & Verify Procedure
    // =========================
    procedure ConfirmAndVerifyAttendance(
        LocationCode: Code[20];
        SalaryPlanCode: Code[20];
        SalaryCycleCode: Code[20];
        EmployeeNo: Code[20])
    var
        AttendanceVerified: Boolean;
    begin
        if not Confirm('Attendance Checked <Yes/No>?') then
            exit;

        AttendanceVerified := true; // Can be dynamic if needed
        VerifyAttendance(LocationCode, SalaryPlanCode, SalaryCycleCode, EmployeeNo, AttendanceVerified);

        Message('Attendance Verified Successfully!');
    end;

    // Get Punch / Shift Info Procedure
    // =========================
    procedure GetPunchInfo(
        LocationCode: Code[20];
        SalaryPlanCode: Code[20];
        SalaryCycleCode: Code[20];
        EmployeeNo: Code[20];
        var ShiftCode: Code[20])
    var
        DailyAttendance: Record "Daily Attendance";
    begin
        DailyAttendance.Reset();
        DailyAttendance.SetRange("Location Code", LocationCode);
        DailyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        DailyAttendance.SetRange("Salary Cyclic Code", SalaryCycleCode);
        DailyAttendance.SetRange("Employee No", EmployeeNo);

        if DailyAttendance.FindFirst() then
            ShiftCode := DailyAttendance."Shift Code";
    end;

}

