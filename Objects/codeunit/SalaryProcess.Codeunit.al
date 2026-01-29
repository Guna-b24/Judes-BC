codeunit 72002 "Salary Process"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Codeunit Created for PAYROLL Module
    // -----------------------------------------------------------------------------------------------


    trigger OnRun()
    begin
        if not Confirm('Do U Want (Payroll for the Year)', false) then
            exit;
    end;

    var
        Employee: Record Employee;
        CUGeneralFunctions: Codeunit "General Functions";
        LocationCode: Code[20];
        SalaryPlanCode: Code[20];
        SalaryCyclicCode: Code[20];
        PayStartDate: Date;
        PayEndDate: Date;
        TotalDaysinAMonth: Decimal;
        BaseTotalAmount: Decimal;
        ActualBaseTotalAmount: Decimal;
        PayableBaseTotalAmount: Decimal;
        TotalPayableDays: Decimal;
        TotalLOPDays: Decimal;
        FalseLastEffectiveDate: Date;
        NegativePay: Boolean;

    [Scope('Internal')]
    procedure "Process Monthly Salary"(LLocationCode: Code[20]; LSalaryPlanCode: Code[20]; LSalaryCyclicCode: Code[20]; LPayStartDate: Date; LPayEndDate: Date; LEmployeeNo: Code[20]; LEmployeeType: Option " ","Staff Permanent","Staff Temporary","Worker Permanent","Worker Temporary") LVStatus: Boolean
    var
        DialogWindow: Dialog;
        CurrentRecord: Integer;
        RecordCount: Integer;
        RecordCnt: Integer;
    begin
        CUGeneralFunctions.OpenWindow('Salary Process..\\', 'Progress');

        LocationCode := LLocationCode;
        SalaryPlanCode := LSalaryPlanCode;
        SalaryCyclicCode := LSalaryCyclicCode;
        PayStartDate := LPayStartDate;
        PayEndDate := LPayEndDate;
        TotalDaysinAMonth := (PayEndDate - PayStartDate) + 1;

        Employee.Reset;
        if LEmployeeNo = 'ALL' then begin
            Employee.SetRange("Location Code", LocationCode);
            Employee.SetRange("Salary Plan Code", SalaryPlanCode);
            if LEmployeeType <> LEmployeeType::" " then
                Employee.SetRange("Employee Category", LEmployeeType);
        end else begin
            Employee.SetRange("Location Code", LocationCode);
            Employee.SetRange("Salary Plan Code", SalaryPlanCode);
            Employee.SetRange("No.", LEmployeeNo);
        end;

        if Employee.FindFirst then begin
            RecordCnt := Employee.Count;
            repeat

                if not "Checking for Posted Employee"(Employee."No.") then
                    if Employee.Status = Employee.Status::Inactive then
                        "Delete Current Employee"(Employee."No.")
                    else begin
                        "Delete Current Employee"(Employee."No.");
                        "Weekly Off Creation"(Employee."No.");
                        "Weekly Off / Holiday Cut"(Employee."No.");
                        "Get Total Payable Days"(Employee."No.");
                        "Get Last Effective Date"(Employee."No.");
                        //      "Read Gross/Daily Pay Elements"(Employee."No.");
                        "Read Employee Pay Elements"(Employee."No.");
                        "Read Pay Loan Details"(Employee."No.");
                        "Read Pay Emp Misc Deductions"(Employee."No.");
                        "Update Pay Elements"(Employee."No.");
                        "Layoff Calculation"(Employee."No.");
                        "Credit Days Calculation"(Employee."No.");
                        "Attendance Bonus Calculation"(Employee."No.");
                        "Extra Wages Calculation"(Employee."No.");
                        "OT Calculation"(Employee."No.");
                        "PF Calculation"(Employee."No.");
                        "ESI Calculation"(Employee."No.");
                        "PT Calculation"(Employee."No.");
                        "LIC Calculation"(Employee."No.");
                        "Medical Reimbu Calculation"(Employee."No.");
                        "Net Amount Calculation"(Employee."No.");
                        if NegativePay then
                            "Net Amount Calculation"(Employee."No.");
                        "First Second Amt Calculation"(Employee."No.");
                        "Update Processed Flag"(Employee."No.");
                        CUGeneralFunctions.UpdateWindow(Employee."No.", RecordCnt);
                    end;
            until Employee.Next = 0;
        end;
        CUGeneralFunctions.CloseWindow;
    end;

    [Scope('Internal')]
    procedure "Read Employee Pay Elements"(LEmployeeNo: Code[20])
    var
        EmployeePayElements: Record "Employee Pay Elements";
        ProcessedSalary: Record "Processed Salary";
    begin
        EmployeePayElements.Reset;
        EmployeePayElements.SetRange("Location Code", LocationCode);
        EmployeePayElements.SetRange("Salary Plan Code", SalaryPlanCode);
        EmployeePayElements.SetRange("Employee No", LEmployeeNo);
        EmployeePayElements.SetRange("Effective Date", FalseLastEffectiveDate);
        EmployeePayElements.SetRange("Excluded In Pay Slip", false);
        if EmployeePayElements.FindFirst then
            repeat
                Clear(ProcessedSalary);
                ProcessedSalary."Employee No" := LEmployeeNo;
                ProcessedSalary."Pay Element Code" := EmployeePayElements."Pay Element Code";
                ProcessedSalary."Paid Category" := 0;
                ProcessedSalary."Pay Type" := EmployeePayElements."Pay Type";
                ProcessedSalary."Fixed / Percent" := EmployeePayElements."Fixed/Percent";
                ProcessedSalary."Percentage (%)" := EmployeePayElements."Percent (%)";
                ProcessedSalary."Actual Amount" := EmployeePayElements.Amount;
                if ProcessedSalary."Percentage (%)" > 0 then
                    ProcessedSalary."Actual Amount" := ProcessedSalary."Percentage (%)";
                "Insert Pay Processed Salary"(ProcessedSalary);
            until EmployeePayElements.Next = 0;
    end;

    [Scope('Internal')]
    procedure "Read Pay Loan Details"(LEmployeeNo: Code[20])
    var
        ProcessedSalary: Record "Processed Salary";
        EmployeeLoan: Record "Employee Loan";
        EmployeeLoanDetails: Record "Employee Loan Details";
        EmployeeLoans: Record "Employee Loans";
    begin
        EmployeeLoan.Reset;
        EmployeeLoan.SetRange("Location Code", LocationCode);
        EmployeeLoan.SetRange("Salary Plan Code", SalaryPlanCode);
        EmployeeLoan.SetRange("Employee No", LEmployeeNo);
        EmployeeLoan.SetRange("No Deduction Request", false);
        if EmployeeLoan.FindFirst then begin
            EmployeeLoanDetails.Reset;
            EmployeeLoanDetails.SetRange("Location Code", LocationCode);
            EmployeeLoanDetails.SetRange("Salary Plan Code", SalaryPlanCode);
            EmployeeLoanDetails.SetRange("Employee No", LEmployeeNo);
            EmployeeLoanDetails.SetRange("Salary Process Date", PayEndDate);
            if EmployeeLoanDetails.FindFirst then
                repeat
                    Clear(ProcessedSalary);
                    ProcessedSalary."Employee No" := LEmployeeNo;
                    ProcessedSalary."Pay Element Code" := EmployeeLoanDetails."Loan Code";
                    ProcessedSalary."Paid Category" := 0;
                    ProcessedSalary."Pay Type" := 1;
                    ProcessedSalary."Actual Amount" := EmployeeLoanDetails."EMI Amount";
                    "Insert Pay Processed Salary"(ProcessedSalary);
                until EmployeeLoanDetails.Next = 0;
        end;
        /*
        EmployeeLoans.RESET;
        EmployeeLoans.SETRANGE("Location Code",LocationCode);
        EmployeeLoans.SETRANGE("Salary Plan Code",SalaryPlanCode);
        EmployeeLoans.SETRANGE("Employee No",LEmployeeNo);
        EmployeeLoans.SETRANGE("No Deduction Request",FALSE);
        EmployeeLoans.SETRANGE(Completed,FALSE);
        IF EmployeeLoans.FINDFIRST THEN
          REPEAT
            EmployeeLoans.ValidateBalanceAmount;
            IF EmployeeLoans."Loan Balance Amount" > 0 THEN BEGIN
              IF EmployeeLoans."Deduction Amount" > EmployeeLoans."Loan Balance Amount" THEN
                EmployeeLoans."Deduction Amount" := EmployeeLoans."Loan Balance Amount";
              ProcessedSalary."Employee No" := LEmployeeNo;
              ProcessedSalary."Pay Element Code" := EmployeeLoans."Loan Code";
              ProcessedSalary."Paid Category" := 0;
              ProcessedSalary."Pay Type" := 1;
              ProcessedSalary."Actual Amount" += EmployeeLoans."Deduction Amount";
              ProcessedSalary."Loan Id" := EmployeeLoans."Loan Id";
              IF ProcessedSalary."Actual Amount" > 0 THEN
                "Insert Pay Processed Salary"(ProcessedSalary);
            END;
        
            IF EmployeeLoans."Loan Balance Amount" <= 0 THEN BEGIN
              EmployeeLoans.Completed := TRUE;
              EmployeeLoans.MODIFY;
            END;
          UNTIL EmployeeLoans.NEXT = 0;
        */

    end;

    [Scope('Internal')]
    procedure "Read Pay Emp Misc Deductions"(LEmployeeNo: Code[20])
    var
        MiscAddDeductions: Record "Misc Add/Deductions";
        ProcessedSalary: Record "Processed Salary";
    begin
        MiscAddDeductions.Reset;
        MiscAddDeductions.SetRange("Location Code", LocationCode);
        MiscAddDeductions.SetRange("Salary Plan Code", SalaryPlanCode);
        MiscAddDeductions.SetRange("Salary Cycle Code", SalaryCyclicCode);
        MiscAddDeductions.SetRange("Employee No", LEmployeeNo);
        if MiscAddDeductions.FindFirst then
            repeat
                Clear(ProcessedSalary);
                ProcessedSalary."Employee No" := LEmployeeNo;
                ProcessedSalary."Pay Element Code" := MiscAddDeductions."Pay Element Code";
                ProcessedSalary."Paid Category" := MiscAddDeductions."Paid Category";
                ProcessedSalary."Pay Type" := MiscAddDeductions."Pay Type";
                ProcessedSalary."Actual Amount" := MiscAddDeductions.Amount;
                "Insert Pay Processed Salary"(ProcessedSalary);
            until MiscAddDeductions.Next = 0;
    end;

    [Scope('Internal')]
    procedure "Insert Pay Processed Salary"(ProcessedSalary: Record "Processed Salary")
    var
        LProcessedSalary: Record "Processed Salary";
    begin
        ProcessedSalary."Location Code" := LocationCode;
        ProcessedSalary."Salary Plan Code" := SalaryPlanCode;
        ProcessedSalary."Salary Cycle Code" := SalaryCyclicCode;
        ProcessedSalary."Payroll Start Date" := PayStartDate;
        ProcessedSalary."Payroll End Date" := PayEndDate;
        ProcessedSalary.Year := Date2DMY(PayEndDate, 3);
        ProcessedSalary.Month := Date2DMY(PayEndDate, 2);
        ProcessedSalary."Total Days in a Month" := TotalDaysinAMonth;
        ProcessedSalary."Employee Category" := Employee."Employee Category";
        ProcessedSalary."Salary Processed" := true;

        if ProcessedSalary."Pay Element Code" <> '' then
            if ProcessedSalary."Actual Amount" > 0 then begin
                LProcessedSalary.Init;
                ProcessedSalary."Actual Amount" := "General Rounding Off"(ProcessedSalary."Actual Amount");
                ProcessedSalary."Payable Amount" := "General Rounding Off"(ProcessedSalary."Payable Amount");
                LProcessedSalary := ProcessedSalary;
                if LProcessedSalary.Insert then;
            end;
    end;

    [Scope('Internal')]
    procedure "Update Pay Elements"(LEmployeeNo: Code[20])
    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        ProcessedSalary: Record "Processed Salary";
        PayElements: Record "Pay Elements";
        MonthlyAttendance: Record "Monthly Attendance";
        TempNoDays: Decimal;
    begin
        HRPayrollSetup.Get(UserId);
        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");

        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        if ProcessedSalary.FindFirst then
            repeat
                //-- Updating of Pay Elements.

                PayElements.Get(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
                ProcessedSalary."Paid Category" := PayElements."Paid Category";
                ProcessedSalary."Pay Type" := PayElements."Pay Type";
                ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
                ProcessedSalary."Amount Calculation Type" := PayElements."Amount Calculation Type";
                ProcessedSalary."Base Pay Elements" := PayElements."Base Pay Elements";
                ProcessedSalary."Included In Pay Slip" := PayElements."Included In Pay Slip";
                ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
                ProcessedSalary."Payment Type" := PayElements."Payment Type";
                //      ProcessedSalary."Paid Days" := TotalPayableDays;

                // - Judes Manual Lop Days Calculation.
                ProcessedSalary."Paid Days" := (TotalPayableDays - TotalLOPDays);

                if ProcessedSalary."Total Days in a Month" = ProcessedSalary."Paid Days" then
                    ProcessedSalary."Payable Amount" := ProcessedSalary."Actual Amount";

                if ProcessedSalary."Total Days in a Month" <> ProcessedSalary."Paid Days" then begin
                    ProcessedSalary."Payable Amount" :=
                    ((ProcessedSalary."Actual Amount" /
                    ProcessedSalary."Total Days in a Month") *
                    ProcessedSalary."Paid Days");

                    if ProcessedSalary."Amount Calculation Type" = ProcessedSalary."Amount Calculation Type"::"Full Amount" then
                        ProcessedSalary."Payable Amount" := ProcessedSalary."Actual Amount";

                    ProcessedSalary."Actual Amount" := "General Rounding Off"(ProcessedSalary."Actual Amount");
                    ProcessedSalary."Payable Amount" := "General Rounding Off"(ProcessedSalary."Payable Amount");
                end;
                ProcessedSalary.Modify;

            until ProcessedSalary.Next = 0;

        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetFilter("Fixed / Percent", '%1', ProcessedSalary."Fixed / Percent"::Percent);
        if ProcessedSalary.FindFirst then
            repeat
                "Calculate Percentage"(LEmployeeNo, ProcessedSalary."Base Pay Elements");
                ProcessedSalary."Actual Amount" := ActualBaseTotalAmount * ProcessedSalary."Percentage (%)" / 100;
                ProcessedSalary."Actual Amount" := "General Rounding Off"(ProcessedSalary."Actual Amount");
                ProcessedSalary."Payable Amount" := PayableBaseTotalAmount * ProcessedSalary."Percentage (%)" / 100;
                ProcessedSalary."Payable Amount" := "General Rounding Off"(ProcessedSalary."Payable Amount");
                ProcessedSalary.Modify;
            until ProcessedSalary.Next = 0;
    end;

    [Scope('Internal')]
    procedure "Calculate Percentage"(LEmployeeNo: Code[20]; LBasePayElement: Text[250])
    var
        ProcessedSalary: Record "Processed Salary";
        PayElements: Record "Pay Elements";
    begin
        Clear(ActualBaseTotalAmount);
        Clear(PayableBaseTotalAmount);
        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetFilter("Pay Element Code", LBasePayElement);
        if ProcessedSalary.FindFirst then
            repeat
                ActualBaseTotalAmount += ProcessedSalary."Actual Amount";
                PayableBaseTotalAmount += ProcessedSalary."Payable Amount";
            until ProcessedSalary.Next = 0;
    end;

    [Scope('Internal')]
    procedure "Net Amount Calculation"(LEmployeeNo: Code[20])
    var
        MonthlyAttendance: Record "Monthly Attendance";
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        RoundingType: Code[1];
    begin
        HRPayrollSetup.Get(UserId);
        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");

        MonthlyAttendance.Reset;
        MonthlyAttendance.SetRange("Employee No", LEmployeeNo);
        MonthlyAttendance.SetRange("Payroll End Date", PayEndDate);
        if MonthlyAttendance.FindFirst then begin
            if Employee.Get(MonthlyAttendance."Employee No") then begin
                MonthlyAttendance."Pay Method" := Employee."Payment Method";
                MonthlyAttendance.Blocked := Employee.Blocked;
                MonthlyAttendance."Stop Payment" := Employee."Stop Payment";

                if Employee."Payment Method" = Employee."Payment Method"::Cash then begin
                    MonthlyAttendance."Account Type" := MonthlyAttendance."Account Type"::"G/L Account";
                    MonthlyAttendance."Account No." := LocationHRPayrollSetup."Cash Account GL Code";
                    MonthlyAttendance."Pay Method" := Employee."Payment Method"::Cash;
                end;

                if Employee."Payment Method" in [Employee."Payment Method"::Cheque,
                   Employee."Payment Method"::"Bank Transfer"]
                then begin
                    MonthlyAttendance."Account Type" := MonthlyAttendance."Account Type"::"Bank Account";
                    MonthlyAttendance."Account No." := LocationHRPayrollSetup."Bank Account GL Code";
                    MonthlyAttendance."Pay Method" := Employee."Payment Method"::"Bank Transfer";
                end;
            end;

            MonthlyAttendance.CalcFields("Actual Gross Amount");
            MonthlyAttendance.CalcFields("Actual Reimburesment Amount");
            MonthlyAttendance.CalcFields("Actual Deduction Amount");
            MonthlyAttendance.CalcFields("Payable Gross Amount");
            MonthlyAttendance.CalcFields("Payable Reimburesment Amount");
            MonthlyAttendance.CalcFields("Payable Deduction Amount");

            MonthlyAttendance."Actual Net Amount" :=
              (MonthlyAttendance."Actual Gross Amount" +
               MonthlyAttendance."Actual Reimburesment Amount" -
               MonthlyAttendance."Actual Deduction Amount");

            MonthlyAttendance."Payable Net Amount" :=
            (MonthlyAttendance."Payable Gross Amount" +
               MonthlyAttendance."Payable Reimburesment Amount" -
               MonthlyAttendance."Payable Deduction Amount");

            NegativePay := false;
            if MonthlyAttendance."Payable Net Amount" < 0 then begin
                MonthlyAttendance."Payable Net Amount" := 0;
                MonthlyAttendance."Negative Pay" := true;
                "Negative Pay Checking"(LEmployeeNo);
                NegativePay := true;
            end;
            //--------------- HR Setup Rounding Off ------------------
            if LocationHRPayrollSetup."Net Salary Rounding Type" = LocationHRPayrollSetup."Net Salary Rounding Type"::Nearest then
                RoundingType := '=';
            if LocationHRPayrollSetup."Net Salary Rounding Type" = LocationHRPayrollSetup."Net Salary Rounding Type"::Up then
                RoundingType := '>';
            if LocationHRPayrollSetup."Net Salary Rounding Type" = LocationHRPayrollSetup."Net Salary Rounding Type"::Down then
                RoundingType := '<';

            MonthlyAttendance."Payable Net Amount" :=
              "Rounding Off"(MonthlyAttendance."Payable Net Amount",
              LocationHRPayrollSetup."Net Salary Rounding Amount", RoundingType);
            MonthlyAttendance.Modify;
        end;
    end;

    [Scope('Internal')]
    procedure "Layoff Calculation"(LEmployeeNo: Code[20])
    var
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        PayElements: Record "Pay Elements";
        ProcessedSalary: Record "Processed Salary";
        MonthlyAttendance: Record "Monthly Attendance";
        LayoffDaysGrossEarnings: Decimal;
        LayoffDaysAmount: Decimal;
        TotalLayoffDays: Decimal;
    begin
        if Employee.Get(LEmployeeNo) then
            if not Employee."Layoff Applicable" then
                exit;

        if not PayElements.Get('LAYOFF', LocationCode, SalaryPlanCode) then
            Error('%1', 'LAYOFF Pay Element not Defined in the Pay Element Card');

        Clear(LayoffDaysAmount);
        Clear(LayoffDaysGrossEarnings);
        Clear(TotalLayoffDays);
        MonthlyAttendance.Reset;
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Salary Cycle Code", SalaryCyclicCode);
        MonthlyAttendance.SetRange("Employee No", LEmployeeNo);
        if MonthlyAttendance.FindFirst then begin
            MonthlyAttendance.CalcFields("Lay Off");
            if MonthlyAttendance."Lay Off" <> 0 then
                TotalLayoffDays := MonthlyAttendance."Lay Off" / 2;
        end;

        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetRange("Pay Type", ProcessedSalary."Pay Type"::Addition);
        if ProcessedSalary.FindFirst then
            repeat
                PayElements.Get(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
                if PayElements."Eligible for Layoff" then
                    LayoffDaysGrossEarnings += ProcessedSalary."Actual Amount";
            until ProcessedSalary.Next = 0;
        if LayoffDaysGrossEarnings > 0 then begin
            LayoffDaysAmount := ((LayoffDaysGrossEarnings / TotalDaysinAMonth) *
                TotalLayoffDays);
            LayoffDaysAmount := Round(LayoffDaysAmount, 1, '=');
            LayoffDaysGrossEarnings := "General Rounding Off"(LayoffDaysGrossEarnings);
        end;

        PayElements.Get('LAYOFF', LocationCode, SalaryPlanCode);
        Clear(ProcessedSalary);
        ProcessedSalary."Employee No" := LEmployeeNo;
        ProcessedSalary."Pay Element Code" := PayElements."Pay Element Code";
        ProcessedSalary."Paid Category" := PayElements."Paid Category";
        ProcessedSalary."Pay Type" := PayElements."Pay Type";
        ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
        ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
        ProcessedSalary."Base Pay Elements" := '';
        ProcessedSalary."PF / ESI / PT Gross Earnings" := LayoffDaysGrossEarnings;
        ProcessedSalary."Paid Days" := MonthlyAttendance."Lay Off";
        ProcessedSalary."Actual Amount" := LayoffDaysAmount;
        ProcessedSalary."Payable Amount" := LayoffDaysAmount;
        ProcessedSalary."Payment Type" := PayElements."Payment Type";

        "Insert Pay Processed Salary"(ProcessedSalary);
    end;

    [Scope('Internal')]
    procedure "Credit Days Calculation"(LEmployeeNo: Code[20])
    var
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        PayElements: Record "Pay Elements";
        ProcessedSalary: Record "Processed Salary";
        CreditDaysGrossEarnings: Decimal;
        CreditDaysAmount: Decimal;
        CreditDays: Decimal;
    begin
        if Employee.Get(LEmployeeNo) then
            if not Employee."Credit Days Applicable" then
                exit;

        if not PayElements.Get('CREDIT DAYS', LocationCode, SalaryPlanCode) then
            Error('%1', 'CREDIT DAYS Pay Element not Defined in the Pay Element Card');

        Clear(CreditDaysAmount);
        Clear(CreditDaysGrossEarnings);
        Clear(CreditDays);
        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetRange("Pay Type", ProcessedSalary."Pay Type"::Addition);
        if ProcessedSalary.FindFirst then
            repeat
                PayElements.Get(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
                if PayElements."Eligible for Credit Days" then
                    CreditDaysGrossEarnings += ProcessedSalary."Actual Amount";
            until ProcessedSalary.Next = 0;

        LocationHRPayrollSetup.Get(LocationCode);

        if ProcessedSalary."Paid Days" > LocationHRPayrollSetup."Minimum Attendance Credit Days" then begin
            CreditDays := LocationHRPayrollSetup."Eligible Days for Credit Days";
            CreditDaysAmount := ((CreditDaysGrossEarnings / ProcessedSalary."Total Days in a Month") *
              LocationHRPayrollSetup."Eligible Days for Credit Days");

            CreditDaysAmount := Round(CreditDaysAmount, 1, '=');
        end;

        CreditDaysGrossEarnings := "General Rounding Off"(CreditDaysGrossEarnings);

        PayElements.Get('CREDIT DAYS', LocationCode, SalaryPlanCode);

        Clear(ProcessedSalary);
        ProcessedSalary."Employee No" := LEmployeeNo;
        ProcessedSalary."Pay Element Code" := PayElements."Pay Element Code";
        ProcessedSalary."Paid Category" := PayElements."Paid Category";
        ProcessedSalary."Pay Type" := PayElements."Pay Type";
        ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
        ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
        ProcessedSalary."Base Pay Elements" := '';
        ProcessedSalary."PF / ESI / PT Gross Earnings" := CreditDaysGrossEarnings;
        ProcessedSalary."Paid Days" := CreditDays;
        ProcessedSalary."Actual Amount" := CreditDaysAmount;
        ProcessedSalary."Payable Amount" := CreditDaysAmount;
        ProcessedSalary."Payment Type" := PayElements."Payment Type";

        "Insert Pay Processed Salary"(ProcessedSalary);
    end;

    [Scope('Internal')]
    procedure "Attendance Bonus Calculation"(LEmployeeNo: Code[20])
    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        PayElements: Record "Pay Elements";
        ProcessedSalary: Record "Processed Salary";
        AttendanceBonusAmount: Decimal;
    begin
        if Employee.Get(LEmployeeNo) then
            if not Employee."Attendance Bonus Applicable" then
                exit;

        if not PayElements.Get('ATTE BONUS', LocationCode, SalaryPlanCode) then
            Error('%1', 'ATTE BONUS Pay Element not Defined in the Pay Element Card');

        Clear(AttendanceBonusAmount);

        if TotalDaysinAMonth = TotalPayableDays then
            AttendanceBonusAmount := Employee."Attendance Bonus Amount";

        PayElements.Get('ATTE BONUS', LocationCode, SalaryPlanCode);
        Clear(ProcessedSalary);
        ProcessedSalary."Employee No" := LEmployeeNo;
        ProcessedSalary."Pay Element Code" := PayElements."Pay Element Code";
        ProcessedSalary."Paid Category" := PayElements."Paid Category";
        ProcessedSalary."Pay Type" := PayElements."Pay Type";
        ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
        ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
        ProcessedSalary."Base Pay Elements" := '';
        ProcessedSalary."Paid Days" := TotalPayableDays;
        ProcessedSalary."Actual Amount" := AttendanceBonusAmount;
        ProcessedSalary."Payable Amount" := AttendanceBonusAmount;
        ProcessedSalary."PF / ESI / PT Gross Earnings" := 0;
        ProcessedSalary."Payment Type" := PayElements."Payment Type";

        "Insert Pay Processed Salary"(ProcessedSalary);
    end;

    [Scope('Internal')]
    procedure "PF Calculation"(LEmployeeNo: Code[20])
    var
        PayElements: Record "Pay Elements";
        PFSetup: Record "PF Setup";
        ProcessedSalary: Record "Processed Salary";
        HRPayrollSetup: Record "HR & Payroll Setup";
        MonthlyAttendance: Record "Monthly Attendance";
        LastEffectiveDate: Date;
        PFGrossEarnings: Decimal;
        EPSGrossEarnings: Decimal;
        EmployeeVPFAmount: Decimal;
        EmployeePFAmount: Decimal;
        EmployerPFAmount: Decimal;
        EmployerEPSAmount: Decimal;
        PFAdminChargesAmount: Decimal;
        PFEDLIAmount: Decimal;
        PFRIFAAmount: Decimal;
        RoundingType: Text[2];
        EPFAmount: Decimal;
    begin
        //------ PF Calculation
        //------ Effective Date / PF Gross Salary Limit / EPS Gross Salary Limit
        //------ Employee PF % / Employee VPF % / Employer PF % Employer EPS %
        //------ PF Admin Charges % / PF EDLI % / PF RIFA % / PF Rounding Amount

        if not Employee."PF Applicable" then
            exit;

        if not PayElements.Get('PF', LocationCode, SalaryPlanCode) then
            Error('%1', 'PF Pay Element not Defined in the Pay Element Card');

        if Employee."VPF Applicable" then
            if not PayElements.Get('VPF', LocationCode, SalaryPlanCode) then
                Error('%1', 'VPF Pay Element not Defined in the Pay Element Card');

        Clear(PFGrossEarnings);
        Clear(EPSGrossEarnings);
        PFSetup.Reset;
        PFSetup.SetRange("Location Code", LocationCode);
        PFSetup.SetRange("Salary Plan Code", SalaryPlanCode);
        PFSetup.SetFilter("Effective Date", '<=%1', PayEndDate);
        if not PFSetup.FindLast then
            Message('%1', 'PF Setup Records not found');

        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetRange("Pay Type", ProcessedSalary."Pay Type"::Addition);
        if ProcessedSalary.FindFirst then
            repeat
                PayElements.Get(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
                if PayElements."Eligible for PF" then
                    PFGrossEarnings += ProcessedSalary."Payable Amount";
            until ProcessedSalary.Next = 0;

        PFGrossEarnings := "General Rounding Off"(PFGrossEarnings);
        EPSGrossEarnings := "General Rounding Off"(PFGrossEarnings);

        if PFSetup."PF Rounding Type" = PFSetup."PF Rounding Type"::Nearest then
            RoundingType := '=';
        if PFSetup."PF Rounding Type" = PFSetup."PF Rounding Type"::Up then
            RoundingType := '>';
        if PFSetup."PF Rounding Type" = PFSetup."PF Rounding Type"::Down then
            RoundingType := '<';

        //---------------------------------------------------------------------------------------------------//

        //----- PF Employee Contribution /  PF Employer Contribution / Pension Amount -----///

        if Employee."VPF Applicable" then
            PFSetup."Employee VPF ( Employee) %" := Employee."Employee VPF ( Employee) %";

        if PFGrossEarnings <= PFSetup."PF Gross Salary Limit" then begin
            EmployeeVPFAmount := (PFGrossEarnings * PFSetup."Employee VPF ( Employee) %") / 100;
            EmployeePFAmount := (PFGrossEarnings * PFSetup."Employee PF (Employee) %") / 100;
        end
        else begin
            EmployeeVPFAmount := (PFGrossEarnings * PFSetup."Employee VPF ( Employee) %") / 100;
            EmployeePFAmount := (PFGrossEarnings * PFSetup."Employee PF (Employee) %") / 100;
        end;

        if EPSGrossEarnings <= PFSetup."EPS Gross Salary Limit" then begin
            EPFAmount := ((EPSGrossEarnings * PFSetup."Employee PF (Employee) %") / 100);
            EPFAmount := "Rounding Off"(EPFAmount, PFSetup."PF Rounding Amount", RoundingType);
            EmployerPFAmount := EPSGrossEarnings * (PFSetup."Employer PF (Company) %" / 100);
            EmployerPFAmount := "Rounding Off"(EmployerPFAmount, PFSetup."PF Rounding Amount", RoundingType);
            EmployerEPSAmount := EPFAmount - EmployerPFAmount;
        end
        else begin
            EPSGrossEarnings := PFSetup."EPS Gross Salary Limit";
            EPFAmount := ((EPSGrossEarnings * PFSetup."Employee PF (Employee) %") / 100);
            EPFAmount := "Rounding Off"(EPFAmount, PFSetup."PF Rounding Amount", RoundingType);
            EmployerPFAmount := (EPSGrossEarnings * (PFSetup."Employer PF (Company) %" / 100));
            EmployerPFAmount := "Rounding Off"(EmployerPFAmount, PFSetup."PF Rounding Amount", RoundingType);
            EmployerEPSAmount := (EPFAmount - EmployerPFAmount);
        end;

        //- New Modification on /14/07/11

        EmployerPFAmount := (EmployeePFAmount - EmployerEPSAmount);

        //--------------------------PF Admin Charges-----------------------------------------//
        PFAdminChargesAmount := (PFGrossEarnings * PFSetup."PF Admin Charges %") / 100;
        //--------------------------EDLI Charges---------------------------------------------//
        PFEDLIAmount := (PFGrossEarnings * PFSetup."PF EDLI %") / 100;
        //--------------------------RIFA Charges---------------------------------------------//
        PFRIFAAmount := (PFGrossEarnings * PFSetup."PF RIFA %") / 100;
        //-----------------------------------------------------------------------------------//

        EmployeeVPFAmount := "Rounding Off"(EmployeeVPFAmount, PFSetup."PF Rounding Amount", RoundingType);
        EmployeePFAmount := "Rounding Off"(EmployeePFAmount, PFSetup."PF Rounding Amount", RoundingType);
        EmployerEPSAmount := "Rounding Off"(EmployerEPSAmount, PFSetup."PF Rounding Amount", RoundingType);
        EmployerPFAmount := "Rounding Off"(EmployerPFAmount, PFSetup."PF Rounding Amount", RoundingType);

        PFAdminChargesAmount := "Rounding Off"(PFAdminChargesAmount, PFSetup."PF Rounding Amount", RoundingType);
        PFEDLIAmount := "Rounding Off"(PFEDLIAmount, PFSetup."PF Rounding Amount", RoundingType);
        PFRIFAAmount := "Rounding Off"(PFRIFAAmount, PFSetup."PF Rounding Amount", RoundingType);

        PayElements.Get('PF', LocationCode, SalaryPlanCode);
        Clear(ProcessedSalary);
        ProcessedSalary."Employee No" := LEmployeeNo;
        ProcessedSalary."Pay Element Code" := PayElements."Pay Element Code";
        ProcessedSalary."Paid Category" := PayElements."Paid Category";
        ProcessedSalary."Pay Type" := PayElements."Pay Type";
        ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
        ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
        ProcessedSalary."Base Pay Elements" := '';
        ProcessedSalary."Paid Days" := TotalPayableDays;
        ProcessedSalary."Actual Amount" := EmployeePFAmount;
        ProcessedSalary."Payable Amount" := EmployeePFAmount;
        ProcessedSalary."PF / ESI / PT Gross Earnings" := PFGrossEarnings;
        ProcessedSalary."EPS Gross Earnings" := EPSGrossEarnings;
        ProcessedSalary."Employee VPF Amount" := EmployeeVPFAmount;
        ProcessedSalary."Employee PF / ESI Amount" := EmployeePFAmount;
        ProcessedSalary."Employer PF / ESI Amount" := EmployerPFAmount;
        ProcessedSalary."Employer EPS Amount" := EmployerEPSAmount;
        ProcessedSalary."PF Admin Charges Amount" := PFAdminChargesAmount;
        ProcessedSalary."PF EDLI Amount" := PFEDLIAmount;
        ProcessedSalary."PF RIFA Amount" := PFRIFAAmount;
        ProcessedSalary."Payment Type" := PayElements."Payment Type";

        "Insert Pay Processed Salary"(ProcessedSalary);

        PayElements.Get('VPF', LocationCode, SalaryPlanCode);

        Clear(ProcessedSalary);

        ProcessedSalary."Employee No" := LEmployeeNo;
        ProcessedSalary."Pay Element Code" := PayElements."Pay Element Code";
        ProcessedSalary."Paid Category" := PayElements."Paid Category";
        ProcessedSalary."Pay Type" := PayElements."Pay Type";
        ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
        ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
        ProcessedSalary."Base Pay Elements" := '';
        ProcessedSalary."Paid Days" := TotalPayableDays;
        ProcessedSalary."Actual Amount" := EmployeeVPFAmount;
        ProcessedSalary."Payable Amount" := EmployeeVPFAmount;
        ;
        ProcessedSalary."PF / ESI / PT Gross Earnings" := PFGrossEarnings;
        ProcessedSalary."EPS Gross Earnings" := PFGrossEarnings;
        ProcessedSalary."Employee VPF Amount" := EmployeeVPFAmount;
        ProcessedSalary."Payment Type" := PayElements."Payment Type";

        "Insert Pay Processed Salary"(ProcessedSalary);
    end;

    [Scope('Internal')]
    procedure "ESI Calculation"(LEmployeeNo: Code[20])
    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        PayElements: Record "Pay Elements";
        ESISetup: Record "ESI Setup";
        Employee: Record Employee;
        ProcessedSalary: Record "Processed Salary";
        LastEffectiveDate: Date;
        ESIGrossEarnings: Decimal;
        ESIEarningsLimits: Decimal;
        EmployeeESIAmount: Decimal;
        EmployerESIAmount: Decimal;
        RoundingType: Text[2];
        FixedESIGrossEarnings: Decimal;
        NonFixedESIGrossEarnings: Decimal;
        FEmployeeESIAmount: Decimal;
        FEmployerESIAmount: Decimal;
        NFEmployeeESIAmount: Decimal;
        NFEmployerESIAmount: Decimal;
    begin
        //------ ESI Calculation
        //------ Effective Date / ESI Gross Salary Limit
        //------ Employee ESI % / Employer ESI %

        if Employee.Get(LEmployeeNo) then
            if not Employee."ESI Applicable" then
                exit;

        if not PayElements.Get('ESI', LocationCode, SalaryPlanCode) then
            Error('%1', 'ESI Pay Element not Defined in the Pay Element Card');

        Clear(ESIGrossEarnings);
        Clear(ESIEarningsLimits);
        Clear(FixedESIGrossEarnings);
        Clear(NonFixedESIGrossEarnings);

        ESISetup.Reset;
        ESISetup.SetRange("Location Code", LocationCode);
        ESISetup.SetRange("Salary Plan Code", SalaryPlanCode);
        ESISetup.SetFilter("Effective Date", '<=%1', PayEndDate);
        if not ESISetup.Find('+') then
            Message('%1', 'ESI Setup Records not found');

        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetRange("Pay Type", ProcessedSalary."Pay Type"::Addition);
        if ProcessedSalary.Find('-') then begin
            repeat
                PayElements.Get(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);

                if PayElements."Eligible for ESI Earnings" then
                    ESIGrossEarnings += ProcessedSalary."Payable Amount";

                //-- New Modification For Ramjee - On - 11/07/2009.

                if PayElements."Eligible for ESI Limit Amount" then
                    ESIEarningsLimits += ProcessedSalary."Actual Amount";

                //-- New Modification for HTC- on - 25/12/2009.

                if PayElements."Eligible for ESI Earnings" then begin
                    if PayElements."Fixed Pay Element" then
                        FixedESIGrossEarnings += ProcessedSalary."Payable Amount";
                end;

                if PayElements."Eligible for ESI Earnings" then begin
                    if PayElements."Fixed Pay Element" = false then
                        NonFixedESIGrossEarnings += ProcessedSalary."Payable Amount";
                end;

            until ProcessedSalary.Next = 0;
        end;

        ESIGrossEarnings := "General Rounding Off"(ESIGrossEarnings);

        if ESISetup."ESI Rounding Type" = ESISetup."ESI Rounding Type"::Nearest then
            RoundingType := '=';
        if ESISetup."ESI Rounding Type" = ESISetup."ESI Rounding Type"::Up then
            RoundingType := '>';
        if ESISetup."ESI Rounding Type" = ESISetup."ESI Rounding Type"::Down then
            RoundingType := '<';

        FixedESIGrossEarnings := "General Rounding Off"(FixedESIGrossEarnings);
        NonFixedESIGrossEarnings := "General Rounding Off"(NonFixedESIGrossEarnings);

        if ESIEarningsLimits <= ESISetup."ESI Gross Salary Amount" then begin
            FEmployeeESIAmount := (FixedESIGrossEarnings * ESISetup."ESI % ( Employee )" / 100);
            FEmployerESIAmount := (FixedESIGrossEarnings * ESISetup."ESI % ( Company )" / 100);
            FEmployeeESIAmount := "Rounding Off"(FEmployeeESIAmount, ESISetup."ESI Rounding Amount", RoundingType);
            FEmployerESIAmount := "Rounding Off"(FEmployerESIAmount, ESISetup."ESI Rounding Amount", RoundingType);
            NFEmployeeESIAmount := (NonFixedESIGrossEarnings * ESISetup."ESI % ( Employee )" / 100);
            NFEmployerESIAmount := (NonFixedESIGrossEarnings * ESISetup."ESI % ( Company )" / 100);
            NFEmployeeESIAmount := "Rounding Off"(NFEmployeeESIAmount, ESISetup."ESI Rounding Amount", RoundingType);
            NFEmployerESIAmount := "Rounding Off"(NFEmployerESIAmount, ESISetup."ESI Rounding Amount", RoundingType);

            EmployeeESIAmount := FEmployeeESIAmount + NFEmployeeESIAmount;
            EmployerESIAmount := FEmployerESIAmount + NFEmployerESIAmount;

        end
        else begin
            EmployeeESIAmount := 0;
            EmployerESIAmount := 0;
        end;

        PayElements.Get('ESI', LocationCode, SalaryPlanCode);

        Clear(ProcessedSalary);
        ProcessedSalary."Employee No" := LEmployeeNo;
        ProcessedSalary."Pay Element Code" := PayElements."Pay Element Code";
        ProcessedSalary."Paid Category" := PayElements."Paid Category";
        ProcessedSalary."Pay Type" := PayElements."Pay Type";
        ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
        ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
        ProcessedSalary."Base Pay Elements" := '';
        ProcessedSalary."Paid Days" := TotalPayableDays;
        ProcessedSalary."Actual Amount" := EmployeeESIAmount;
        ProcessedSalary."Payable Amount" := EmployeeESIAmount;
        ProcessedSalary."PF / ESI / PT Gross Earnings" := ESIGrossEarnings;
        ProcessedSalary."Employee PF / ESI Amount" := EmployeeESIAmount;
        ProcessedSalary."Employer PF / ESI Amount" := EmployerESIAmount;
        ProcessedSalary."Payment Type" := PayElements."Payment Type";

        "Insert Pay Processed Salary"(ProcessedSalary);
    end;

    [Scope('Internal')]
    procedure "PT Calculation"(LEmployeeNo: Code[20])
    var
        Employee: Record Employee;
        PayElements: Record "Pay Elements";
        ProfessionalTaxHeader: Record "Professional Tax Header";
        ProfessionalTaxLine: Record "Professional Tax Line";
        ProcessedSalary: Record "Processed Salary";
        HRPayrollSetup: Record "HR & Payroll Setup";
        LastEffectiveDate: Date;
        PTGrossEarnings: Decimal;
        EmployeePTAmount: Decimal;
        RoundingType: Text[2];
    begin
        //------ PT Calculation
        //------ Effective Date / PT Gross Salary Limit

        if Employee.Get(LEmployeeNo) then
            if not Employee."PT Applicable" then
                exit;

        if not PayElements.Get('PT', LocationCode, SalaryPlanCode) then
            Error('%1', 'PT Pay Element not Defined in the Pay Element Card');

        Clear(PTGrossEarnings);

        ProfessionalTaxHeader.Reset;
        ProfessionalTaxHeader.SetRange("Location Code", LocationCode);
        ProfessionalTaxHeader.SetRange("Salary Plan Code", SalaryPlanCode);
        ProfessionalTaxHeader.SetRange("Branch Code", Employee."PT Branch Code");
        ProfessionalTaxHeader.SetFilter("Effective Date", '<=%1', PayEndDate);
        if not ProfessionalTaxHeader.FindFirst then;
        //   MESSAGE('%1', 'Professional Tax Header Records not found');

        ProfessionalTaxLine.Reset;
        ProfessionalTaxLine.SetRange("Location Code", LocationCode);
        ProfessionalTaxLine.SetRange("Salary Plan Code", SalaryPlanCode);
        ProfessionalTaxLine.SetRange("Branch Code", Employee."PT Branch Code");
        ProfessionalTaxLine.SetFilter("Effective Date", '<=%1', PayEndDate);
        if not ProfessionalTaxLine.FindFirst then;
        //   MESSAGE('%1', 'Professional Tax Line Records not found');

        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetRange("Pay Type", ProcessedSalary."Pay Type"::Addition);
        if ProcessedSalary.Find('-') then begin
            repeat
                PayElements.Get(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);

                if PayElements."Eligible for PT" then
                    PTGrossEarnings += ProcessedSalary."Payable Amount";
            until ProcessedSalary.Next = 0;
        end;

        PTGrossEarnings := "General Rounding Off"(PTGrossEarnings);

        ProfessionalTaxLine.Reset;
        ProfessionalTaxLine.SetRange("Location Code", LocationCode);
        ProfessionalTaxLine.SetRange("Salary Plan Code", SalaryPlanCode);
        ProfessionalTaxLine.SetRange("Branch Code", Employee."PT Branch Code");
        ProfessionalTaxLine.SetFilter("Effective Date", '<=%1', PayEndDate);
        if ProfessionalTaxLine.Find('-') then begin
            repeat
                if (ProfessionalTaxLine."Income From" <= PTGrossEarnings) and
                   (ProfessionalTaxLine."Income To" >= PTGrossEarnings) then begin
                    EmployeePTAmount := ProfessionalTaxLine."Tax Amount";
                end;

            until ProfessionalTaxLine.Next = 0;
        end;

        PayElements.Get('PT', LocationCode, SalaryPlanCode);
        Clear(ProcessedSalary);
        ProcessedSalary."Employee No" := LEmployeeNo;
        ProcessedSalary."Pay Element Code" := PayElements."Pay Element Code";
        ProcessedSalary."Paid Category" := PayElements."Paid Category";
        ProcessedSalary."Pay Type" := PayElements."Pay Type";
        ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
        ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
        ProcessedSalary."Base Pay Elements" := '';
        ProcessedSalary."Paid Days" := TotalPayableDays;
        ProcessedSalary."Actual Amount" := EmployeePTAmount;
        ProcessedSalary."Payable Amount" := EmployeePTAmount;
        ProcessedSalary."PF / ESI / PT Gross Earnings" := PTGrossEarnings;
        ProcessedSalary."Payment Type" := PayElements."Payment Type";
        "Insert Pay Processed Salary"(ProcessedSalary);
    end;

    [Scope('Internal')]
    procedure "LIC Calculation"(LEmployeeNo: Code[20])
    var
        PayElements: Record "Pay Elements";
        LICHeader: Record "Insurance Header";
        ProcessedSalary: Record "Processed Salary";
    begin
        if Employee.Get(LEmployeeNo) then
            if not Employee."Insurance Applicable" then
                exit;

        if not PayElements.Get('LIC', LocationCode, SalaryPlanCode) then
            Error('%1', 'LIC Pay Element not Defined in the Pay Element Card');

        PayElements.Get('LIC', LocationCode, SalaryPlanCode);

        LICHeader.Reset;
        LICHeader.SetRange("Location Code", LocationCode);
        LICHeader.SetRange("Salary Plan Code", SalaryPlanCode);
        LICHeader.SetRange("Pay Element Code", PayElements."Pay Element Code");
        LICHeader.SetRange("Employee No.", LEmployeeNo);
        LICHeader.SetRange(Blocked, false);
        if LICHeader.Find('-') then begin

            LICHeader.CalcFields("Total Premium Amount");

            Clear(ProcessedSalary);
            ProcessedSalary."Employee No" := LEmployeeNo;
            ProcessedSalary."Pay Element Code" := PayElements."Pay Element Code";
            ProcessedSalary."Paid Category" := PayElements."Paid Category";
            ProcessedSalary."Pay Type" := PayElements."Pay Type";
            ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
            ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
            ProcessedSalary."Base Pay Elements" := '';
            ProcessedSalary."Paid Days" := TotalPayableDays;
            ProcessedSalary."Actual Amount" := LICHeader."Total Premium Amount";
            ProcessedSalary."Payable Amount" := LICHeader."Total Premium Amount";
            ProcessedSalary."Payment Type" := PayElements."Payment Type";

            "Insert Pay Processed Salary"(ProcessedSalary);
        end;
    end;

    [Scope('Internal')]
    procedure "Medical Reimbu Calculation"(LEmployeeNo: Code[20])
    var
        PayElements: Record "Pay Elements";
        MedicalReimbuHeader: Record "Medical Reimbu. Header";
        MedicalReimbuLine: Record "Medical Reimbu. Line";
        ProcessedSalary: Record "Processed Salary";
        TotalBillAmount: Decimal;
    begin
        if Employee.Get(LEmployeeNo) then
            if not Employee."Medical Reimbu. Applicable" then
                exit;

        if not PayElements.Get('MED REIMB', LocationCode, SalaryPlanCode) then
            Error('%1', 'MED REIMB Pay Element not Defined in the Pay Element Card');

        PayElements.Get('MED REIMB', LocationCode, SalaryPlanCode);

        MedicalReimbuHeader.Reset;
        MedicalReimbuHeader.SetRange("Location Code", LocationCode);
        MedicalReimbuHeader.SetRange("Salary Plan Code", SalaryPlanCode);
        MedicalReimbuHeader.SetRange("Pay Element Code", PayElements."Pay Element Code");
        MedicalReimbuHeader.SetRange("Employee No.", LEmployeeNo);
        MedicalReimbuHeader.SetRange(Blocked, false);
        if not MedicalReimbuHeader.Find('-') then
            exit;

        Clear(TotalBillAmount);

        MedicalReimbuLine.Reset;
        MedicalReimbuLine.SetRange("Location Code", LocationCode);
        MedicalReimbuLine.SetRange("Salary Plan Code", SalaryPlanCode);
        MedicalReimbuLine.SetRange("Pay Element Code", PayElements."Pay Element Code");
        MedicalReimbuLine.SetRange("Employee No.", LEmployeeNo);
        MedicalReimbuLine.SetRange("Reimburesment Date", PayStartDate, PayEndDate);
        MedicalReimbuLine.SetRange(Blocked, false);
        if MedicalReimbuLine.Find('-') then begin
            repeat
                TotalBillAmount += MedicalReimbuLine."Bill Amount";
            until MedicalReimbuLine.Next = 0;

            Clear(ProcessedSalary);
            ProcessedSalary."Employee No" := LEmployeeNo;
            ProcessedSalary."Pay Element Code" := PayElements."Pay Element Code";
            ProcessedSalary."Paid Category" := PayElements."Paid Category";
            ProcessedSalary."Pay Type" := PayElements."Pay Type";
            ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
            ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
            ProcessedSalary."Base Pay Elements" := '';
            ProcessedSalary."Paid Days" := TotalPayableDays;
            ProcessedSalary."Actual Amount" := TotalBillAmount;
            ProcessedSalary."Payable Amount" := TotalBillAmount;
            ProcessedSalary."Payment Type" := PayElements."Payment Type";
            "Insert Pay Processed Salary"(ProcessedSalary);
        end;
    end;

    [Scope('Internal')]
    procedure "OT Calculation"(LEmployeeNo: Code[20])
    var
        Employee: Record Employee;
        PayElements: Record "Pay Elements";
        ProcessedSalary: Record "Processed Salary";
        MonthlyAttendance: Record "Monthly Attendance";
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        OTGrossEarnings: Decimal;
        RoundingType: Text[2];
        TotalOverTimeMins: Decimal;
        AmountPerHour: Decimal;
        EmployeeOTAmount: Decimal;
        TotalPermissionMins: Decimal;
    begin
        //------ OT Calculation / OT Gross Salary Limit
        if Employee.Get(LEmployeeNo) then
            if not Employee."OT Applicable" then
                exit;

        if not PayElements.Get('OT', LocationCode, SalaryPlanCode) then
            Error('%1', 'OT Pay Element not Defined in the Pay Element Card');

        Clear(OTGrossEarnings);
        Clear(TotalOverTimeMins);
        Clear(AmountPerHour);
        Clear(EmployeeOTAmount);
        Clear(TotalPermissionMins);

        HRPayrollSetup.Get(UserId);
        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");

        MonthlyAttendance.Reset;
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Salary Cycle Code", SalaryCyclicCode);
        MonthlyAttendance.SetRange("Employee No", LEmployeeNo);
        if MonthlyAttendance.Find('-') then begin
            MonthlyAttendance.CalcFields("Over Time In Mins");
            MonthlyAttendance.CalcFields("Total Permission In Mins");
            TotalOverTimeMins := MonthlyAttendance."Over Time In Mins";
            if TotalOverTimeMins < 0 then
                TotalOverTimeMins := 0;

            if Employee."OT Type" = Employee."OT Type"::"Hourly Based" then
                MonthlyAttendance."Total Over Time Hours" := "Convert Mins To Hours"(TotalOverTimeMins)
            else
                MonthlyAttendance."Total Over Time Hours" := TotalOverTimeMins;

            TotalOverTimeMins := MonthlyAttendance."Total Over Time Hours";

            MonthlyAttendance.Modify;
        end;

        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetRange("Pay Type", ProcessedSalary."Pay Type"::Addition);
        if ProcessedSalary.Find('-') then begin
            repeat
                PayElements.Get(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
                if PayElements."Eligible for OT" then
                    OTGrossEarnings += ProcessedSalary."Payable Amount";
            until ProcessedSalary.Next = 0;
        end;

        if Employee."OT Type" = Employee."OT Type"::"Hourly Based" then begin
            if TotalOverTimeMins > 0 then begin
                AmountPerHour := ((OTGrossEarnings / TotalPayableDays) / LocationHRPayrollSetup."No of Hours Per Day");
                EmployeeOTAmount := ((TotalOverTimeMins * AmountPerHour) * Employee."Over Time Multiplier");
                EmployeeOTAmount := "General Rounding Off"(EmployeeOTAmount);
            end;
        end;

        if Employee."OT Type" = Employee."OT Type"::"Per Daily Amount  " then begin
            if TotalOverTimeMins > 0 then
                EmployeeOTAmount := (TotalOverTimeMins * (OTGrossEarnings / TotalPayableDays));
        end;

        PayElements.Get('OT', LocationCode, SalaryPlanCode);
        Clear(ProcessedSalary);
        ProcessedSalary."Employee No" := LEmployeeNo;
        ProcessedSalary."Pay Element Code" := PayElements."Pay Element Code";
        ProcessedSalary."Paid Category" := PayElements."Paid Category";
        ProcessedSalary."Pay Type" := PayElements."Pay Type";
        ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
        ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
        ProcessedSalary."Base Pay Elements" := '';
        ProcessedSalary."Paid Days" := TotalOverTimeMins;
        ProcessedSalary."Actual Amount" := EmployeeOTAmount;
        ProcessedSalary."Payable Amount" := EmployeeOTAmount;
        ProcessedSalary."PF / ESI / PT Gross Earnings" := OTGrossEarnings;
        ProcessedSalary."Payment Type" := PayElements."Payment Type";

        "Insert Pay Processed Salary"(ProcessedSalary);
    end;

    [Scope('Internal')]
    procedure "Extra Wages Calculation"(LEmployeeNo: Code[20])
    var
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        PayElements: Record "Pay Elements";
        ProcessedSalary: Record "Processed Salary";
        MonthlyAttendance: Record "Monthly Attendance";
        ExtraWagesDaysGrossEarnings: Decimal;
        ExtraWagesDaysAmount: Decimal;
        TotalExtraWagesDays: Decimal;
    begin
        if Employee.Get(LEmployeeNo) then
            if not Employee."Extra Allowance Applicable" then
                exit;

        if not PayElements.Get('EXTRA ALLOW', LocationCode, SalaryPlanCode) then
            Error('%1', 'EXTRA ALLOW Pay Element not Defined in the Pay Element Card');

        Clear(ExtraWagesDaysAmount);
        Clear(ExtraWagesDaysGrossEarnings);
        Clear(TotalExtraWagesDays);

        MonthlyAttendance.Reset;
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Salary Cycle Code", SalaryCyclicCode);
        MonthlyAttendance.SetRange("Employee No", LEmployeeNo);
        if MonthlyAttendance.Find('-') then begin
            MonthlyAttendance.CalcFields("Over Time In Mins");
            TotalExtraWagesDays := MonthlyAttendance."Over Time In Mins";
        end;

        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetRange("Pay Type", ProcessedSalary."Pay Type"::Addition);
        if ProcessedSalary.Find('-') then begin
            repeat
                PayElements.Get(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
                if PayElements."Eligible for Extra Allowances" then
                    ExtraWagesDaysGrossEarnings += ProcessedSalary."Actual Amount";
            until ProcessedSalary.Next = 0;
        end;

        PayElements.Get('EXTRA ALLOW', LocationCode, SalaryPlanCode);

        ExtraWagesDaysAmount := ((ExtraWagesDaysGrossEarnings / TotalPayableDays) *
                                    TotalExtraWagesDays);

        ExtraWagesDaysGrossEarnings := "General Rounding Off"(ExtraWagesDaysGrossEarnings);

        Clear(ProcessedSalary);
        ProcessedSalary."Employee No" := LEmployeeNo;
        ProcessedSalary."Pay Element Code" := PayElements."Pay Element Code";
        ProcessedSalary."Paid Category" := PayElements."Paid Category";
        ProcessedSalary."Pay Type" := PayElements."Pay Type";
        ProcessedSalary."Fixed / Percent" := PayElements."Fixed/Percent";
        ProcessedSalary."Sorting Order" := PayElements."Sorting Order";
        ProcessedSalary."Base Pay Elements" := '';
        ProcessedSalary."PF / ESI / PT Gross Earnings" := ExtraWagesDaysGrossEarnings;
        ProcessedSalary."Total Days in a Month" := PayElements."No of Day for DA";
        ProcessedSalary."Paid Days" := TotalExtraWagesDays;
        ProcessedSalary."Actual Amount" := ExtraWagesDaysAmount;
        ProcessedSalary."Payable Amount" := ExtraWagesDaysAmount;
        ProcessedSalary."Payment Type" := PayElements."Payment Type";

        "Insert Pay Processed Salary"(ProcessedSalary);
    end;

    [Scope('Internal')]
    procedure "Rounding Off"(GrossAmount: Decimal; RoundingAmount: Decimal; RoundingType: Text[2]): Decimal
    var
        TotalAmountRounded: Decimal;
    begin

        if RoundingAmount > 0 then
            TotalAmountRounded := Round(GrossAmount, RoundingAmount, RoundingType)
        else
            TotalAmountRounded := GrossAmount;

        exit(TotalAmountRounded);
    end;

    [Scope('Internal')]
    procedure "General Rounding Off"(GrossAmount: Decimal): Decimal
    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        RoundingType: Text[2];
        TotalAmountRounded: Decimal;
    begin
        HRPayrollSetup.Get(UserId);

        if LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code") then;

        if LocationHRPayrollSetup."General Rounding Type" = LocationHRPayrollSetup."General Rounding Type"::Nearest then
            RoundingType := '=';
        if LocationHRPayrollSetup."General Rounding Type" = LocationHRPayrollSetup."General Rounding Type"::Up then
            RoundingType := '>';
        if LocationHRPayrollSetup."General Rounding Type" = LocationHRPayrollSetup."General Rounding Type"::Down then
            RoundingType := '<';

        if (LocationHRPayrollSetup."General Rounding Amount" > 0) then
            TotalAmountRounded := Round(GrossAmount, LocationHRPayrollSetup."General Rounding Amount", RoundingType)
        else
            TotalAmountRounded := GrossAmount;

        exit(TotalAmountRounded);
    end;

    [Scope('Internal')]
    procedure "Update Processed Flag"(LEmployeeNo: Code[20])
    var
        MonthlyAttendance: Record "Monthly Attendance";
    begin
        MonthlyAttendance.Reset;
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Salary Cycle Code", SalaryCyclicCode);
        MonthlyAttendance.SetRange("Employee No", LEmployeeNo);
        if MonthlyAttendance.Find('-') then begin
            MonthlyAttendance."Salary Processed" := true;
            MonthlyAttendance.Modify;
        end;
    end;

    [Scope('Internal')]
    procedure "Checking for Posted Employee"(LEmployeeNo: Code[20]): Boolean
    var
        MonthlyAttendance: Record "Monthly Attendance";
    begin
        MonthlyAttendance.Reset;
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Salary Cycle Code", SalaryCyclicCode);
        MonthlyAttendance.SetRange("Employee No", LEmployeeNo);
        MonthlyAttendance.SetRange(Posted, true);
        if MonthlyAttendance.Find('-') then
            exit(true)
        else
            exit(false);
    end;

    [Scope('Internal')]
    procedure "Delete Current Employee"(LEmployeeNo: Code[20])
    var
        ProcessedSalary: Record "Processed Salary";
        MonthlyAttendance: Record "Monthly Attendance";
    begin
        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetRange("Payroll End Date", PayEndDate);
        if ProcessedSalary.Find('-') then
            ProcessedSalary.DeleteAll;

        MonthlyAttendance.Reset;
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Salary Cycle Code", SalaryCyclicCode);
        MonthlyAttendance.SetRange("Employee No", LEmployeeNo);
        if MonthlyAttendance.Find('-') then begin
            MonthlyAttendance.ModifyAll("Actual Net Amount", 0);
            MonthlyAttendance.ModifyAll("Payable Net Amount", 0);
            MonthlyAttendance.ModifyAll("First Net Amount", 0);
            MonthlyAttendance.ModifyAll("Second Net Amount", 0);
            MonthlyAttendance.ModifyAll("Over Time In Mins", 0);
            MonthlyAttendance.ModifyAll("Total Permission In Mins", 0);
            MonthlyAttendance.ModifyAll("Negative Pay", false);
        end
    end;

    [Scope('Internal')]
    procedure "First Second Amt Calculation"(LEmployeeNo: Code[20])
    var
        ProcessedSalary: Record "Processed Salary";
        MonthlyAttendance: Record "Monthly Attendance";
        PayElements: Record "Pay Elements";
        FirstPaymentAmount: Decimal;
        SecondPaymentAmount: Decimal;
    begin
        Clear(FirstPaymentAmount);
        Clear(SecondPaymentAmount);

        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetRange("Pay Type", ProcessedSalary."Pay Type"::Addition);
        if ProcessedSalary.Find('-') then begin
            repeat
                PayElements.Get(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
                if ProcessedSalary."Payment Type" = ProcessedSalary."Payment Type"::"First Payment" then
                    FirstPaymentAmount += ProcessedSalary."Payable Amount";
            until ProcessedSalary.Next = 0;
        end;

        MonthlyAttendance.Reset;
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Salary Cycle Code", SalaryCyclicCode);
        MonthlyAttendance.SetRange("Employee No", LEmployeeNo);
        if MonthlyAttendance.Find('-') then begin
            MonthlyAttendance.CalcFields("Payable Deduction Amount");
            MonthlyAttendance."First Net Amount" := (FirstPaymentAmount - MonthlyAttendance."Payable Deduction Amount");
            MonthlyAttendance."Second Net Amount" := (MonthlyAttendance."Payable Net Amount" - MonthlyAttendance."First Net Amount");
            if MonthlyAttendance."First Net Amount" < 0 then
                MonthlyAttendance."First Net Amount" := 0;

            if MonthlyAttendance."Second Net Amount" < 0 then
                MonthlyAttendance."Second Net Amount" := 0;

            MonthlyAttendance.Modify;
        end
    end;

    [Scope('Internal')]
    procedure "Read Gross/Daily Pay Elements"(LEmployeeNo: Code[20])
    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        PayrollMonthYear: Record "Payroll Month & Year";
        PayElements: Record "Pay Elements";
        EmployeePayElements: Record "Employee Pay Elements";
        MonthlyAttendance: Record "Monthly Attendance";
        ProcessedSalary: Record "Processed Salary";
        LastEffectiveDate: Date;
        TotalMonthlySalary: Decimal;
        TotalPayableDays: Decimal;
        PerDaySalary: Decimal;
        TotalGrossAmount: Decimal;
        VDAAmount: Decimal;
        BasicAmount: Decimal;
    begin
        HRPayrollSetup.Get(UserId);
        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");

        Clear(TotalMonthlySalary);
        Clear(PerDaySalary);
        Clear(TotalGrossAmount);
        Clear(BasicAmount);
        Clear(VDAAmount);

        EmployeePayElements.Reset;
        EmployeePayElements.SetRange("Location Code", LocationCode);
        EmployeePayElements.SetRange("Salary Plan Code", SalaryPlanCode);
        EmployeePayElements.SetRange("Employee No", LEmployeeNo);
        EmployeePayElements.SetFilter("Effective Date", '<=%1', PayEndDate);
        EmployeePayElements.SetRange("Excluded In Pay Slip", true);
        if EmployeePayElements.Find('+') then
            LastEffectiveDate := EmployeePayElements."Effective Date";

        EmployeePayElements.Reset;
        EmployeePayElements.SetRange("Location Code", LocationCode);
        EmployeePayElements.SetRange("Salary Plan Code", SalaryPlanCode);
        EmployeePayElements.SetRange("Employee No", LEmployeeNo);
        EmployeePayElements.SetRange("Effective Date", LastEffectiveDate);
        EmployeePayElements.SetRange("Excluded In Pay Slip", true);
        if EmployeePayElements.Find('-') then
            repeat

                PayElements.Get(EmployeePayElements."Pay Element Code", LocationCode, SalaryPlanCode);

                PayrollMonthYear.Reset;
                PayrollMonthYear.SetRange("Location Code", LocationCode);
                PayrollMonthYear.SetRange("Salary Plan Code", SalaryPlanCode);
                PayrollMonthYear.SetRange("Salary Cyclic Code", SalaryCyclicCode);
                if PayrollMonthYear.Find('-') then;

                if PayElements."Gross Amount Pay Elements" then begin
                    TotalMonthlySalary := EmployeePayElements.Amount;
                    PerDaySalary := Round((TotalMonthlySalary / TotalDaysinAMonth), 0.01, '=');
                    VDAAmount := (TotalDaysinAMonth * PayrollMonthYear."Staff VDA Amount");
                    BasicAmount := (TotalMonthlySalary - VDAAmount);
                end;

                if PayElements."Daily Wages Pay Elements" then begin
                    PerDaySalary := EmployeePayElements.Amount;
                    TotalGrossAmount := (TotalDaysinAMonth * PerDaySalary);
                    VDAAmount := (TotalDaysinAMonth * PayrollMonthYear."Workmen VDA Amount");
                    BasicAmount := (TotalGrossAmount - VDAAmount);
                end;

                Employee.Get(LEmployeeNo);

                if Employee."Employee Category" in [Employee."Employee Category"::"Staff Temporary",
                                                Employee."Employee Category"::"Class IV Temporary"] then begin
                    BasicAmount := (TotalDaysinAMonth * PerDaySalary);
                    VDAAmount := 0;
                end;

                Clear(ProcessedSalary);
                ProcessedSalary."Employee No" := LEmployeeNo;
                ProcessedSalary."Pay Element Code" := 'BASIC';
                ProcessedSalary."Paid Category" := PayElements."Paid Category";
                ProcessedSalary."Pay Type" := EmployeePayElements."Pay Type";
                ProcessedSalary."Fixed / Percent" := EmployeePayElements."Fixed/Percent";
                ProcessedSalary."Percentage (%)" := EmployeePayElements."Percent (%)";
                ProcessedSalary."Actual Amount" := BasicAmount;
                ProcessedSalary."Payable Amount" := BasicAmount;
                "Insert Pay Processed Salary"(ProcessedSalary);

                Clear(ProcessedSalary);
                ProcessedSalary."Employee No" := LEmployeeNo;
                ProcessedSalary."Pay Element Code" := 'DA';
                ProcessedSalary."Paid Category" := PayElements."Paid Category";
                ProcessedSalary."Pay Type" := EmployeePayElements."Pay Type";
                ProcessedSalary."Fixed / Percent" := EmployeePayElements."Fixed/Percent";
                ProcessedSalary."Percentage (%)" := EmployeePayElements."Percent (%)";
                ProcessedSalary."Actual Amount" := VDAAmount;
                ProcessedSalary."Payable Amount" := VDAAmount;
                "Insert Pay Processed Salary"(ProcessedSalary);

            until EmployeePayElements.Next = 0;
    end;

    [Scope('Internal')]
    procedure "Weekly Off Creation"(LEmployeeNo: Code[20])
    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        DailyAttendance: Record "Daily Attendance";
        MonthlyAttendance: Record "Monthly Attendance";
        TotalDaysWorked: Decimal;
        CheckFlag: Boolean;
        StartWeek: Integer;
        EndWeek: Integer;
    begin
        if Employee.Get(LEmployeeNo) then
            if not Employee."Weekly Off Cut" then
                exit;

        HRPayrollSetup.Get(UserId);
        if LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code") then;

        Clear(TotalDaysWorked);
        Clear(CheckFlag);
        Clear(StartWeek);
        Clear(EndWeek);

        StartWeek := Date2DWY(PayStartDate, 2);
        EndWeek := Date2DWY(PayEndDate, 2);

        DailyAttendance.Reset;
        DailyAttendance.SetRange("Location Code", LocationCode);
        DailyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        DailyAttendance.SetRange("Employee No", LEmployeeNo);
        DailyAttendance.SetRange("Week No", StartWeek, EndWeek);
        if DailyAttendance.Find('-') then begin
            repeat
                if DailyAttendance."Lay Off" = 1 then
                    DailyAttendance."Lay Off" := 1;

                TotalDaysWorked += (DailyAttendance.Present + DailyAttendance.Holiday
                                  + DailyAttendance."Lay Off");

                if TotalDaysWorked >= LocationHRPayrollSetup."Weekly Off Full Days Limit" then begin
                    if DailyAttendance."Weekly Off Status" then begin
                        DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::"Weekly Off";
                        DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::"Weekly Off";
                        CheckFlag := true;
                    end;
                end;

                if (TotalDaysWorked < LocationHRPayrollSetup."Weekly Off Full Days Limit") then begin
                    if DailyAttendance."Weekly Off Status" then begin
                        DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::Absent;
                        DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::Absent;
                        CheckFlag := true;
                    end;
                end;

                if LocationHRPayrollSetup."Weekly Off Half Days Limit" <> 0 then begin
                    if (TotalDaysWorked = LocationHRPayrollSetup."Weekly Off Half Days Limit") then begin
                        if DailyAttendance."Weekly Off Status" then begin
                            DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::"Weekly Off";
                            DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::Absent;
                            CheckFlag := true;
                        end;
                    end;
                end;

                if CheckFlag then begin
                    DailyAttendance.Validate("First Half Attendance Type");
                    DailyAttendance.Validate("Second Half Attendance Type");
                    DailyAttendance.Modify;
                    TotalDaysWorked := 0;
                    CheckFlag := false;
                end;

                if DailyAttendance."Weekly Off Status" then begin
                    TotalDaysWorked := 0;
                end;

            until DailyAttendance.Next = 0;
        end;

        MonthlyAttendance.Reset;
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Salary Cycle Code", SalaryCyclicCode);
        MonthlyAttendance.SetRange("Employee No", LEmployeeNo);
        if MonthlyAttendance.Find('-') then begin
            MonthlyAttendance.CalcFields(Present);
            if MonthlyAttendance.Present = 0 then begin
                DailyAttendance.Reset;
                DailyAttendance.SetRange("Location Code", LocationCode);
                DailyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
                DailyAttendance.SetRange("Salary Cyclic Code", SalaryCyclicCode);
                DailyAttendance.SetRange("Employee No", LEmployeeNo);
                DailyAttendance.SetFilter("Payable Days", '<>%1', 0);
                if DailyAttendance.Find('-') then begin
                    repeat
                        DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::Absent;
                        DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::Absent;
                        DailyAttendance.Validate("First Half Attendance Type");
                        DailyAttendance.Validate("Second Half Attendance Type");
                        DailyAttendance.Modify;
                    until DailyAttendance.Next = 0;
                end;
            end;
        end;
    end;

    [Scope('Internal')]
    procedure "Weekly Off / Holiday Cut"(LEmployeeNo: Code[20])
    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        RVDate: Record Date;
        DailyAttendance: Record "Daily Attendance";
        MonthlyAttendance: Record "Monthly Attendance";
        TotalDaysWorked: Decimal;
        CheckFlag: Boolean;
        AttendanceStartDate: Date;
        AttendanceEndDate: Date;
    begin
        if Employee.Get(LEmployeeNo) then
            if not Employee."Weekly Off / Holiday Cut" then
                exit;

        DailyAttendance.Reset;
        DailyAttendance.SetRange("Location Code", LocationCode);
        DailyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        DailyAttendance.SetRange("Employee No", LEmployeeNo);
        DailyAttendance.SetRange("Attendance Date", PayStartDate, PayEndDate);
        DailyAttendance.SetRange("Non Working Day", true);
        if DailyAttendance.Find('-') then begin
            repeat
                DailyAttendance."First Half Attendance Type" := DailyAttendance."First Half Attendance Type"::Absent;
                DailyAttendance."Second Half Attendance Type" := DailyAttendance."Second Half Attendance Type"::Absent;
                DailyAttendance.Validate("First Half Attendance Type");
                DailyAttendance.Validate("Second Half Attendance Type");
                DailyAttendance.Modify;
            until DailyAttendance.Next = 0;
        end;
    end;

    [Scope('Internal')]
    procedure "Negative Pay Checking"(LEmployeeNo: Code[20])
    var
        ProcessedSalary: Record "Processed Salary";
        TotalGrossAmount: Decimal;
        TotalDedeAmount: Decimal;
        TotalNetAmount: Decimal;
    begin
        Clear(TotalGrossAmount);
        Clear(TotalDedeAmount);
        Clear(TotalNetAmount);

        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        if ProcessedSalary.Find('-') then begin
            repeat
                if ProcessedSalary."Pay Type" = ProcessedSalary."Pay Type"::Addition then
                    TotalGrossAmount += ProcessedSalary."Payable Amount";

                if (ProcessedSalary."Pay Type" = ProcessedSalary."Pay Type"::Deduction) and
                   (ProcessedSalary."Amount Calculation Type" = ProcessedSalary."Amount Calculation Type"::"Full Amount") then
                    TotalDedeAmount += ProcessedSalary."Payable Amount";
            until ProcessedSalary.Next = 0;
            TotalNetAmount := (TotalGrossAmount - TotalDedeAmount);
        end;

        ProcessedSalary.Reset;
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("Employee No", LEmployeeNo);
        ProcessedSalary.SetRange("Pay Type", ProcessedSalary."Pay Type"::Deduction);
        ProcessedSalary.SetRange("Amount Calculation Type", ProcessedSalary."Amount Calculation Type"::"Full Amount");
        if ProcessedSalary.Find('-') then begin
            repeat
                if ProcessedSalary."Payable Amount" > TotalNetAmount then begin
                    ProcessedSalary."Payable Amount" := 0;
                    ProcessedSalary.Modify;
                end;
            until ProcessedSalary.Next = 0;
        end;
    end;

    [Scope('Internal')]
    procedure "Convert Mins To Hours"(TotalHrsMins: Decimal): Decimal
    var
        ConvertHours: Decimal;
        DecimalPart: Decimal;
        IntegerPart: Integer;
    begin
        Clear(ConvertHours);
        Clear(DecimalPart);
        Clear(IntegerPart);

        DecimalPart := (TotalHrsMins mod 60);
        IntegerPart := (TotalHrsMins - DecimalPart);
        IntegerPart := (IntegerPart / 60);
        ConvertHours := (IntegerPart + (DecimalPart / 100));

        exit(ConvertHours);
    end;

    [Scope('Internal')]
    procedure "Convert Hours To Mins"(TotalHrsMins: Decimal): Decimal
    var
        ConvertHours: Decimal;
        DecimalPart: Decimal;
        IntegerPart: Integer;
    begin
        Clear(ConvertHours);
        Clear(DecimalPart);
        Clear(IntegerPart);

        ConvertHours := TotalHrsMins * 100;
        DecimalPart := ConvertHours mod 100;
        DecimalPart := (DecimalPart / 100);
        IntegerPart := (TotalHrsMins - DecimalPart);
        ConvertHours := (IntegerPart * 60) + (DecimalPart * 100);

        exit(ConvertHours);
    end;

    [Scope('Internal')]
    procedure "Get Total Payable Days"(LEmployeeNo: Code[20])
    var
        MonthlyAttendance: Record "Monthly Attendance";
    begin
        MonthlyAttendance.Reset;
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Salary Cycle Code", SalaryCyclicCode);
        MonthlyAttendance.SetRange("Employee No", LEmployeeNo);
        if MonthlyAttendance.FindFirst then begin
            MonthlyAttendance.CalcFields("Total Payable Days");
            TotalPayableDays := MonthlyAttendance."Total Payable Days";
            TotalLOPDays := MonthlyAttendance."Manual LOP Days";
        end;
    end;

    [Scope('Internal')]
    procedure "Get Last Effective Date"(LEmployeeNo: Code[20])
    var
        EmployeePayElements: Record "Employee Pay Elements";
    begin
        EmployeePayElements.Reset;
        EmployeePayElements.SetRange("Location Code", LocationCode);
        EmployeePayElements.SetRange("Salary Plan Code", SalaryPlanCode);
        EmployeePayElements.SetRange("Employee No", LEmployeeNo);
        EmployeePayElements.SetFilter("Effective Date", '<=%1', PayEndDate);
        EmployeePayElements.SetRange("Excluded In Pay Slip", false);
        if EmployeePayElements.FindLast then
            FalseLastEffectiveDate := EmployeePayElements."Effective Date";
    end;
}

