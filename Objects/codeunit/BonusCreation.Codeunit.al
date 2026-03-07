codeunit 72011 "Bonus Creation"
{
    var
        CUGeneralFunctions: Codeunit "General Functions";
        BonusId: Code[20];
        LocationCode: Code[20];
        SalaryPlanCode: Code[20];
        BonusYear: Code[20];
        BonusStartDate: Date;
        BonusEndDate: Date;


    procedure "Create Bonus Records"(LBonusId: Code[20]; LEmployeeNo: Code[20])
    var
        BonusHeader: Record "Bonus Header";
        Employee: Record Employee;
        RecordCount: Integer;
    begin
        if not Confirm('Do You Want Create Bonus', false) then
            exit;

        BonusHeader.Reset();
        BonusHeader.SetRange("Bonus Id.", LBonusId);
        if BonusHeader.FindFirst() then begin
            BonusId := BonusHeader."Bonus Id.";
            LocationCode := BonusHeader."Location Code";
            SalaryPlanCode := BonusHeader."Salary Plan Code";
            BonusYear := BonusHeader."Bonus Year";
            BonusStartDate := BonusHeader."Bonus Start Date";
            BonusEndDate := BonusHeader."Bonus End Date";
        end;

        CUGeneralFunctions.OpenWindow('Bonus Creation\\', 'Progress');

        Employee.Reset();
        if LEmployeeNo <> 'ALL' then
            Employee.SetRange("No.", LEmployeeNo);

        Employee.SetRange("Location Code", LocationCode);
        Employee.SetRange("Salary Plan Code", SalaryPlanCode);
        Employee.SetRange(Status, Employee.Status::Active);
        Employee.SetRange("Bonus Applicable", true);
        if Employee.FindFirst() then begin
            RecordCount := Employee.Count;
            repeat
                CUGeneralFunctions.UpdateWindow(Employee."No.", RecordCount);
                "Delete Bonus Lines"(Employee."No.");
                "Insert Bonus Line Records"(Employee."No.");
                "Transfer Bonus to PayElements"(Employee."No.");
                "Transfer CL Amt to PayElements"(Employee."No.");
                "Transfer EL Amt to PayElements"(Employee."No.");
                "Bonus Calculation"(Employee."No.");
            until Employee.Next() = 0;
        end;
        CUGeneralFunctions.CloseWindow();
        Message('Process Completed..');
    end;


    procedure "Insert Bonus Line Records"(LEmployeeNo: Code[20])
    var
        Employee: Record Employee;
        BonusHeader: Record "Bonus Header";
        BonusLine: Record "Bonus Line";
        PayElements: Record "Pay Elements";
    begin
        if not PayElements.Get('BONUS', LocationCode, SalaryPlanCode) then
            Error('%1', 'BONUS Pay Element not Defined in the Pay Element Card');

        Employee.Get(LEmployeeNo);
        BonusHeader.Reset();
        BonusHeader.SetRange("Bonus Id.", BonusId);
        if BonusHeader.FindFirst() then;

        BonusLine.Init();
        BonusLine."Bonus Id." := BonusId;
        BonusLine."Location Code" := LocationCode;
        BonusLine."Salary Plan Code" := SalaryPlanCode;
        BonusLine."Bonus Year" := BonusYear;
        BonusLine."Employee No" := LEmployeeNo;
        BonusLine.Name := Employee."First Name" + ' ' + Employee.Initials;
        BonusLine."Pay Element Code" := 'BONUS';
        BonusLine."Service Year" := "Service Year Calculation"(LEmployeeNo);
        BonusLine."Bonus %" := BonusHeader."Bonus (%)";
        BonusLine."Ex-Gratia %" := BonusHeader."Ex-Gratia (%)";
        BonusLine."Select (Y/N)" := true;
        BonusLine."Employee Category" := Employee."Employee Category";

        if BonusLine.Insert() then;

        "Insert Bonus Dtl. Line Records"(LEmployeeNo);
    end;

    procedure "Insert Bonus Dtl. Line Records"(LEmployeeNo: Code[20])
    var
        Employee: Record Employee;
        MonthlyAttendance: Record "Monthly Attendance";
        BonusDetailedLine: Record "Bonus Detailed Line";
    begin
        Clear(MonthlyAttendance);
        Employee.Get(LEmployeeNo);

        MonthlyAttendance.Reset();
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Employee No", LEmployeeNo);
        MonthlyAttendance.SetRange("Payroll End Date", BonusStartDate, BonusEndDate);
        if MonthlyAttendance.FindFirst() then
            repeat
                MonthlyAttendance.CalcFields("Total Payable Days");

                BonusDetailedLine.Init();
                BonusDetailedLine."Bonus Id." := BonusId;
                BonusDetailedLine."Location Code" := LocationCode;
                BonusDetailedLine."Salary Plan Code" := SalaryPlanCode;
                BonusDetailedLine."Bonus Year" := BonusYear;
                BonusDetailedLine."Salary Cycle Code" := MonthlyAttendance."Salary Cycle Code";
                BonusDetailedLine."Employee No" := MonthlyAttendance."Employee No";
                BonusDetailedLine.Name := Employee."First Name" + ' ' + Employee.Initials;
                BonusDetailedLine."Days Worked" := MonthlyAttendance."Total Payable Days";
                BonusDetailedLine."Bonusable Earnings" :=
                "Bonuable Earning Calculation"(LEmployeeNo,
                   MonthlyAttendance."Salary Cycle Code");
                BonusDetailedLine."Projection Not Required" := false;
                if BonusDetailedLine.Insert() then;

            until MonthlyAttendance.Next() = 0;
    end;


    procedure "Service Year Calculation"(LEmployeeNo: Code[20]): Integer
    var
        Employee: Record Employee;
        ServiceYear: Integer;
    begin
        if Employee.Get(LEmployeeNo) then
            ServiceYear := Round(((Today - Employee."Employment Date") / 365.2364), 1, '=');

        exit(ServiceYear);
    end;


    procedure "Bonuable Earning Calculation"(LEmployeeNo: Code[20]; LSalaryCyclicCode: Code[20]): Decimal
    var
        ProcessedSalary: Record "Processed Salary";
        PayElements: Record "Pay Elements";
        BonusableEarnings: Decimal;
    begin
        Clear(BonusableEarnings);

        ProcessedSalary.Reset();
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", LSalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetRange("Pay Type", ProcessedSalary."Pay Type"::Addition);
        if ProcessedSalary.FindFirst() then
            repeat
                PayElements.Get(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
                if PayElements."Eligible for Bonus" then
                    BonusableEarnings += ProcessedSalary."Payable Amount";
            until ProcessedSalary.Next() = 0;
        exit(BonusableEarnings);
    end;


    procedure "Transfer Bonus to PayElements"(LEmployeeNo: Code[20])
    var
        BonusLine: Record "Bonus Line";
        BonusMiscAddDeductions: Record "Bonus Misc Add/Deductions";
    begin
        BonusLine.Reset();
        BonusLine.SetRange("Bonus Id.", BonusId);
        BonusLine.SetRange("Employee No", LEmployeeNo);
        if BonusLine.FindFirst() then
            repeat
                BonusLine.CalcFields("Bonusable Earnings");
                BonusLine."Bonus Amt" := Round(((BonusLine."Bonusable Earnings" * BonusLine."Bonus %") / 100), 0.01, '=');
                BonusLine."Ex-Gratia Amt" := Round(((BonusLine."Bonusable Earnings" * BonusLine."Ex-Gratia %") / 100), 0.01, '=');
                BonusLine.Modify();

                BonusMiscAddDeductions.Init();
                BonusMiscAddDeductions."Location Code" := LocationCode;
                BonusMiscAddDeductions."Salary Plan Code" := SalaryPlanCode;
                BonusMiscAddDeductions."Bonus ID." := BonusId;
                BonusMiscAddDeductions."Employee No." := BonusLine."Employee No";
                BonusMiscAddDeductions."Pay Element Code" := BonusLine."Pay Element Code";
                BonusMiscAddDeductions."Bonus Year Code" := BonusYear;
                BonusMiscAddDeductions."Bonus Start Date" := BonusStartDate;
                BonusMiscAddDeductions."Bonus End Date" := BonusEndDate;
                BonusMiscAddDeductions.Name := BonusLine.Name;
                BonusMiscAddDeductions."Paid Category" := BonusMiscAddDeductions."Paid Category"::Yearly;
                BonusMiscAddDeductions."Pay Type" := BonusMiscAddDeductions."Pay Type";
                BonusMiscAddDeductions.Amount := Round((BonusLine."Bonus Amt" + BonusLine."Ex-Gratia Amt"), 1, '=');
                BonusMiscAddDeductions."Created Date" := Today;
                //BonusMiscAddDeductions."User Id" := UserId;
                BonusMiscAddDeductions.Month := Date2DMY(BonusEndDate, 2);
                BonusMiscAddDeductions.Year := Date2DMY(BonusEndDate, 3);
                BonusMiscAddDeductions."System Generated" := true;

                if BonusLine."Service Year" < 1 then
                    if BonusLine."Service Month" < 3 then begin
                        BonusMiscAddDeductions.Amount := 0;
                        BonusLine."Select (Y/N)" := false;
                    end;

                BonusLine.CalcFields("Gross Bonus Amt");
                BonusLine.CalcFields("Deduction Amt");

                BonusLine."Total Net Bonus Amt" := Round((BonusLine."Gross Bonus Amt" - BonusLine."Deduction Amt"), 0.01, '=');
                BonusLine.Modify();

                if BonusMiscAddDeductions.Amount > 0 then begin
                    BonusLine."Select (Y/N)" := true;
                    BonusMiscAddDeductions.Insert();
                end;

            until BonusLine.Next() = 0;
    end;


    procedure "Transfer CL Amt to PayElements"(LEmployeeNo: Code[20])
    var
        BonusHeader: Record "Bonus Header";
        BonusLine: Record "Bonus Line";
        BonusMiscAddDeductions: Record "Bonus Misc Add/Deductions";
        CLDays: Decimal;
        CLAmount: Decimal;
    begin
        Clear(CLDays);
        Clear(CLAmount);
        BonusLine.Reset();
        BonusLine.SetRange("Bonus Id.", BonusId);
        BonusLine.SetRange("Employee No", LEmployeeNo);
        if BonusLine.FindFirst() then
            repeat
                BonusLine.CalcFields("No of Days Worked");

                if BonusLine."No of Days Worked" > 0 then
                    BonusLine."No of Days Worked" := BonusLine."No of Days Worked" + 9;

                BonusHeader.Reset();
                BonusHeader.SetRange("Bonus Id.", BonusLine."Bonus Id.");
                if BonusHeader.FindFirst() then;

                if BonusLine."Employee Category" in [BonusLine."Employee Category"::"Staff Permanent",
                   BonusLine."Employee Category"::"Staff Temporary"]
                then begin
                    if BonusHeader."Staff Total CL Days" > 0 then
                        CLDays := Round((BonusLine."No of Days Worked" / BonusHeader."Staff Total CL Days"), 1, '=');
                    if CLDays >= 14 then
                        CLDays := 14;
                end;

                if BonusLine."Employee Category" in [BonusLine."Employee Category"::"Worker Permanent",
                   BonusLine."Employee Category"::"Worker Temporary"]
                then begin
                    if BonusHeader."Worker Total CL Days" > 0 then
                        CLDays := Round((BonusLine."No of Days Worked" / BonusHeader."Worker Total CL Days"), 1, '=');
                    if CLDays >= 12 then
                        CLDays := 12;
                end;

                CLAmount := Round((CLDays * "Read Per Day Salary"(LEmployeeNo)), 1, '=');

                if BonusLine."Service Year" <= 0 then
                    CLAmount := 0;

                BonusMiscAddDeductions.Init();
                BonusMiscAddDeductions."Location Code" := LocationCode;
                BonusMiscAddDeductions."Salary Plan Code" := SalaryPlanCode;
                BonusMiscAddDeductions."Bonus ID." := BonusId;
                BonusMiscAddDeductions."Employee No." := BonusLine."Employee No";
                BonusMiscAddDeductions."Pay Element Code" := 'CL AMOUNT';
                BonusMiscAddDeductions."Bonus Year Code" := BonusYear;
                BonusMiscAddDeductions."Bonus Start Date" := BonusStartDate;
                BonusMiscAddDeductions."Bonus End Date" := BonusEndDate;
                BonusMiscAddDeductions.Name := BonusLine.Name;
                BonusMiscAddDeductions."Paid Category" := BonusMiscAddDeductions."Paid Category"::Yearly;
                BonusMiscAddDeductions."Pay Type" := BonusMiscAddDeductions."Pay Type";
                BonusMiscAddDeductions.Amount := CLAmount;
                BonusMiscAddDeductions."Created Date" := Today;
                // BonusMiscAddDeductions."User Id" := UserId;
                BonusMiscAddDeductions.Month := Date2DMY(BonusEndDate, 2);
                BonusMiscAddDeductions.Year := Date2DMY(BonusEndDate, 3);
                BonusMiscAddDeductions."CL / EL Paid Days" := CLDays;
                BonusMiscAddDeductions."System Generated" := true;

                BonusLine.CalcFields("Gross Bonus Amt");
                BonusLine.CalcFields("Deduction Amt");
                BonusLine."Total Net Bonus Amt" := Round((BonusLine."Gross Bonus Amt" - BonusLine."Deduction Amt"), 0.01, '=');
                BonusLine.Modify();

                if BonusMiscAddDeductions.Amount > 0 then
                    if BonusMiscAddDeductions.Insert() then;

            until BonusLine.Next() = 0;
    end;

    procedure "Transfer EL Amt to PayElements"(LEmployeeNo: Code[20])
    var
        BonusHeader: Record "Bonus Header";
        BonusLine: Record "Bonus Line";
        BonusMiscAddDeductions: Record "Bonus Misc Add/Deductions";
        ELDays: Decimal;
        ELAmount: Decimal;

    begin
        Clear(ELDays);
        Clear(ELAmount);
        BonusLine.Reset();
        BonusLine.SetRange("Bonus Id.", BonusId);
        BonusLine.SetRange("Employee No", LEmployeeNo);
        if BonusLine.FindFirst() then
            repeat
                BonusLine.CalcFields("No of Days Worked");
                if BonusLine."No of Days Worked" > 0 then
                    BonusLine."No of Days Worked" := BonusLine."No of Days Worked" + 9;

                BonusHeader.Reset();
                BonusHeader.SetRange("Bonus Id.", BonusLine."Bonus Id.");
                if BonusHeader.FindFirst() then;

                if BonusLine."Employee Category" in [BonusLine."Employee Category"::"Staff Permanent",
                   BonusLine."Employee Category"::"Staff Temporary"]
                then begin

                    if BonusHeader."Staff Total EL Days" > 0 then
                        ELDays := Round((BonusLine."No of Days Worked" / BonusHeader."Staff Total EL Days"), 1, '=');

                    if ELDays >= 15 then
                        ELDays := 15;
                end;

                if BonusLine."Employee Category" in [BonusLine."Employee Category"::"Worker Permanent",
                   BonusLine."Employee Category"::"Worker Temporary"]
                then begin
                    if BonusHeader."Worker Total EL Days" > 0 then
                        ELDays := Round((BonusLine."No of Days Worked" / BonusHeader."Worker Total EL Days"), 1, '=');

                    if ELDays >= 15 then
                        ELDays := 15;
                end;

                ELAmount := Round((ELDays * "Read Per Day Salary"(LEmployeeNo)), 1, '=');

                if BonusLine."Service Year" <= 0 then
                    ELAmount := 0;

                BonusMiscAddDeductions."Location Code" := LocationCode;
                BonusMiscAddDeductions."Salary Plan Code" := SalaryPlanCode;
                BonusMiscAddDeductions."Bonus ID." := BonusId;
                BonusMiscAddDeductions."Employee No." := BonusLine."Employee No";
                BonusMiscAddDeductions."Pay Element Code" := 'EL AMOUNT';
                BonusMiscAddDeductions."Bonus Year Code" := BonusYear;
                BonusMiscAddDeductions."Bonus Start Date" := BonusStartDate;
                BonusMiscAddDeductions."Bonus End Date" := BonusEndDate;
                BonusMiscAddDeductions.Name := BonusLine.Name;
                BonusMiscAddDeductions."Paid Category" := BonusMiscAddDeductions."Paid Category"::Yearly;
                BonusMiscAddDeductions."Pay Type" := BonusMiscAddDeductions."Pay Type";
                BonusMiscAddDeductions.Amount := ELAmount;
                BonusMiscAddDeductions."Created Date" := Today;
                // BonusMiscAddDeductions."User Id" := UserId;
                BonusMiscAddDeductions.Month := Date2DMY(BonusEndDate, 2);
                BonusMiscAddDeductions.Year := Date2DMY(BonusEndDate, 3);
                BonusMiscAddDeductions."CL / EL Paid Days" := ELDays;
                BonusMiscAddDeductions."System Generated" := true;

                BonusLine.CalcFields("Gross Bonus Amt");
                BonusLine.CalcFields("Deduction Amt");
                BonusLine."Total Net Bonus Amt" := Round((BonusLine."Gross Bonus Amt" - BonusLine."Deduction Amt"), 0.01, '=');
                BonusLine.Modify();

                if BonusMiscAddDeductions.Amount > 0 then
                    if BonusMiscAddDeductions.Insert() then;

            until BonusLine.Next() = 0;
    end;

    procedure "Bonus Calculation"(LEmployeeNo: Code[20])
    var
        BonusLine: Record "Bonus Line";
        BonusMiscAddDeductions: Record "Bonus Misc Add/Deductions";
    begin
        BonusLine.Reset();
        BonusLine.SetRange("Bonus Id.", BonusId);
        BonusLine.SetRange("Employee No", LEmployeeNo);
        if BonusLine.FindFirst() then
            repeat
                BonusLine.CalcFields("No of Days Worked");

                if BonusLine."No of Days Worked" <= 0 then begin
                    BonusMiscAddDeductions.Reset();
                    BonusMiscAddDeductions.SetRange("Location Code", BonusLine."Location Code");
                    BonusMiscAddDeductions.SetRange("Salary Plan Code", BonusLine."Salary Plan Code");
                    BonusMiscAddDeductions.SetRange("Bonus ID.", BonusLine."Bonus Id.");
                    BonusMiscAddDeductions.SetRange("Employee No.", BonusLine."Employee No");
                    BonusMiscAddDeductions.SetRange("System Generated", false);
                    if BonusMiscAddDeductions.FindFirst() then
                        BonusMiscAddDeductions.DeleteAll();
                end;

                if BonusLine."Employee Category" = BonusLine."Employee Category"::"Worker Temporary" then
                    if BonusLine."Service Year" <= 0 then begin
                        BonusMiscAddDeductions.Reset();
                        BonusMiscAddDeductions.SetRange("Location Code", BonusLine."Location Code");
                        BonusMiscAddDeductions.SetRange("Salary Plan Code", BonusLine."Salary Plan Code");
                        BonusMiscAddDeductions.SetRange("Bonus ID.", BonusLine."Bonus Id.");
                        BonusMiscAddDeductions.SetRange("Employee No.", BonusLine."Employee No");
                        BonusMiscAddDeductions.SetRange("Pay Type", BonusMiscAddDeductions."Pay Type"::Addition);
                        BonusMiscAddDeductions.SetRange("System Generated", false);
                        if BonusMiscAddDeductions.FindFirst() then
                            BonusMiscAddDeductions.DeleteAll();
                    end;
                BonusLine.CalcFields("Gross Bonus Amt");
                BonusLine.CalcFields("Deduction Amt");
                BonusLine."Total Net Bonus Amt" := Round((BonusLine."Gross Bonus Amt" - BonusLine."Deduction Amt"), 0.01, '=');

                if BonusLine."Total Net Bonus Amt" > 0 then
                    BonusLine."Select (Y/N)" := true
                else
                    BonusLine."Select (Y/N)" := false;

                BonusLine.Modify();
            until BonusLine.Next() = 0;
    end;

    procedure "Delete Bonus Lines"(LEmployeeNo: Code[20])
    var
        BonusMiscAddDeductions: Record "Bonus Misc Add/Deductions";
    begin

        BonusMiscAddDeductions.Reset();
        BonusMiscAddDeductions.SetRange("Bonus ID.", BonusId);
        BonusMiscAddDeductions.SetRange("Employee No.", LEmployeeNo);
        BonusMiscAddDeductions.SetRange("System Generated", true);
        if BonusMiscAddDeductions.FindFirst() then
            BonusMiscAddDeductions.DeleteAll();

    end;

    procedure "Read Per Day Salary"(LEmployeeNo: Code[20]): Decimal
    var
        PayElements: Record "Pay Elements";
        EmployeePayElements: Record "Employee Pay Elements";
        Employee: Record Employee;
        LastEffectiveDate: Date;
        TotalMonthlySalary: Decimal;
        PerDaySalary: Decimal;
        TotalDaysMonth: Integer;
    begin
        Clear(TotalMonthlySalary);
        Clear(PerDaySalary);
        Clear(TotalDaysMonth);
        EmployeePayElements.Reset();
        EmployeePayElements.SetRange("Location Code", LocationCode);
        EmployeePayElements.SetRange("Salary Plan Code", SalaryPlanCode);
        EmployeePayElements.SetRange("Employee No", LEmployeeNo);
        EmployeePayElements.SetFilter("Effective Date", '<=%1', BonusEndDate);
        EmployeePayElements.SetRange("Pay Type", EmployeePayElements."Pay Type"::Addition);
        if EmployeePayElements.FindLast() then
            LastEffectiveDate := EmployeePayElements."Effective Date";

        EmployeePayElements.Reset();
        EmployeePayElements.SetRange("Location Code", LocationCode);
        EmployeePayElements.SetRange("Salary Plan Code", SalaryPlanCode);
        EmployeePayElements.SetRange("Employee No", LEmployeeNo);
        EmployeePayElements.SetRange("Effective Date", LastEffectiveDate);
        EmployeePayElements.SetRange("Pay Type", EmployeePayElements."Pay Type"::Addition);
        if EmployeePayElements.FindFirst() then
            repeat
                PayElements.Get(EmployeePayElements."Pay Element Code", LocationCode, SalaryPlanCode);
                TotalMonthlySalary += EmployeePayElements.Amount;
            until EmployeePayElements.Next() = 0;

        Employee.Get(LEmployeeNo);

        exit(PerDaySalary);

    end;

    procedure GetEmployees(var BonusHeader: Record "Bonus Misc Add/Deductions")
    var
        Employee: Record Employee;
        BonusLine: Record "Bonus Misc Add/Deductions";
    begin
        // Validation
        if (BonusHeader."Bonus Start Date" = 0D) or
           (BonusHeader."Bonus End Date" = 0D) or
           (BonusHeader."Pay Element Code" = '') then
            Error('Enter the Start Date, End Date and Element Code.');

        // Filter employees
        Employee.Reset();
        Employee.SetRange("Location Code", BonusHeader."Location Code");
        Employee.SetRange("Salary Plan Code", BonusHeader."Salary Plan Code");

        if Employee.FindSet() then
            repeat
                // Prevent duplicates
                BonusLine.Reset();
                BonusLine.SetRange("Bonus ID.", BonusHeader."Bonus ID.");
                BonusLine.SetRange("Employee No.", Employee."No.");

                if not BonusLine.IsEmpty() then
                    continue;

                BonusLine.Init();
                BonusLine.TransferFields(BonusHeader);
                BonusLine."Employee No." := Employee."No.";
                BonusLine.Name := Employee."First Name";
                BonusLine."Created Date" := Today();
                BonusLine.Insert();
            until Employee.Next() = 0;
    end;
}

