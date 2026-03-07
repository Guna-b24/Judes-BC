codeunit 70050 "Monthly Attendance Process"
{

    var
        Employee: Record Employee;
        MonthlyAttendance: Record "Monthly Attendance";
        ProcessedSalary: Record "Processed Salary";
        GenJournalLine: Record "Gen. Journal Line";
        EmpPostingGroup: Record "Payroll Employee Posting Group";
        CUSalaryProcess: Codeunit "Salary Process";
        CUSalaryPosting: Codeunit "Salary Posting";

    procedure SetupCheck(EmpNo: Code[20]): Boolean
    begin
        Employee.GET(EmpNo);
        Employee.TESTFIELD(Employee."Emp Posting Group");
        Employee.TESTFIELD(Employee."Pay Bus. Posting Group");
        if EmpPostingGroup.GET(Employee."Emp Posting Group") then begin
            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Salary Payable1 A/c");
            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Salary Payable2 A/c");
            EmpPostingGroup.TESTFIELD(EmpPostingGroup."PF Payable A/c");
            EmpPostingGroup.TESTFIELD(EmpPostingGroup."TDS Payable A/c");
            EmpPostingGroup.TESTFIELD(EmpPostingGroup."ESI Payable A/c");
            EmpPostingGroup.TESTFIELD(EmpPostingGroup."EPS Payable A/c");
            EmpPostingGroup.TESTFIELD(EmpPostingGroup."EDLI Payable A/c");
            EmpPostingGroup.TESTFIELD(EmpPostingGroup."RIFA Payable A/c");
            EmpPostingGroup.TESTFIELD(EmpPostingGroup."PT Payable A/c");
            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Bonus Payable A/c");
            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Loan Refundable A/c");
        end;
        exit(true);
    end;

    procedure ProcessSalary(LocationCode: Code[20]; SalaryPlanCode: Code[20]; SalaryCyclicCode: Code[20]; StartDate: Date; EndDate: Date; EmployeeNo: Code[20]; EmployeeCategory: Option)
    begin
        CUSalaryProcess."Process Monthly Salary"(LocationCode, SalaryPlanCode, SalaryCyclicCode, StartDate, EndDate, EmployeeNo, EmployeeCategory);
        MESSAGE('%1', 'Process Completed..!!');
    end;

    procedure CurrentEmployee(LocationCode: Code[20]; SalaryPlanCode: Code[20]; SalaryCyclicCode: Code[20]; StartDate: Date; EndDate: Date; EmployeeCategory: Option)
    begin
        CUSalaryProcess."Process Monthly Salary"(LocationCode, SalaryPlanCode, SalaryCyclicCode, StartDate, EndDate, 'ALL', EmployeeCategory);
        MESSAGE('%1', 'Process Completed..!!');
    end;

    procedure AllEmployee(TemplateName: Code[20]; JournalBatchName: Code[20]; DocumentNo: Code[20]; PostedDate: Date; LocationCode: Code[20]; SalaryPlanCode: Code[20]; SalaryCyclicCode: Code[20]; EmployeeCategory: Option)
    begin
        if CONFIRM('Are you sure you want to process all employees?') then begin
            if MonthlyAttendance.FINDSET() then
                repeat
                    SetupCheck(MonthlyAttendance."Employee No");
                until MonthlyAttendance.NEXT() = 0;

            MESSAGE('Processing all employees...');

            MonthlyAttendance.RESET();
            MonthlyAttendance.SETRANGE("Location Code", LocationCode);
            MonthlyAttendance.SETRANGE("Salary Plan Code", SalaryPlanCode);
            MonthlyAttendance.SETRANGE("Salary Cycle Code", SalaryCyclicCode);
            MonthlyAttendance.SETRANGE("Employee Category", EmployeeCategory);
            MonthlyAttendance.SETFILTER("Payable Gross Amount", '<>%1', 0.0);
            MonthlyAttendance.SETRANGE("Salary Processed", TRUE);
            MonthlyAttendance.SETRANGE(Posted, FALSE);

            if MonthlyAttendance.FINDSET() then
                repeat
                    Employee.GET(MonthlyAttendance."Employee No");
                    if NOT Employee."Stop Payment" then
                        CUSalaryPosting.Posting(MonthlyAttendance);

                    MonthlyAttendance.Posted := TRUE;
                    MonthlyAttendance.MODIFY();

                    ProcessedSalary.RESET();
                    ProcessedSalary.SETRANGE("Location Code", LocationCode);
                    ProcessedSalary.SETRANGE("Salary Plan Code", SalaryPlanCode);
                    ProcessedSalary.SETRANGE("Salary Cycle Code", SalaryCyclicCode);
                    ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");

                    if ProcessedSalary.FINDSET() then
                        repeat
                            ProcessedSalary."Salary Posted" := TRUE;
                            ProcessedSalary.MODIFY();
                        until ProcessedSalary.NEXT() = 0;
                until MonthlyAttendance.NEXT() = 0;

            MESSAGE('All employees processed successfully.');
        end;
    end;

    procedure PostSalary(TemplateName: Code[20]; JournalBatchName: Code[20]; DocumentNo: Code[20]; PostedDate: Date; LocationCode: Code[20]; SalaryPlanCode: Code[20]; SalaryCyclicCode: Code[20]; EmployeeCategory: Option)
    begin
        if JournalBatchName = '' then
            ERROR('Journal Batch Name is required.'); // Text003
        if DocumentNo = '' then
            ERROR('Document No is required.'); // Text004
        if PostedDate = 0D then
            ERROR('Posted Date is required.'); // Text005

        if CONFIRM('Do you want to post salary?') then begin
            if MonthlyAttendance.FINDSET() then
                repeat
                    SetupCheck(MonthlyAttendance."Employee No");
                until MonthlyAttendance.NEXT() = 0;

            MESSAGE('Posting salary...');

            MonthlyAttendance.RESET();
            MonthlyAttendance.SETRANGE("Location Code", LocationCode);
            MonthlyAttendance.SETRANGE("Salary Plan Code", SalaryPlanCode);
            MonthlyAttendance.SETRANGE("Salary Cycle Code", SalaryCyclicCode);
            MonthlyAttendance.SETRANGE("Employee Category", EmployeeCategory);
            MonthlyAttendance.SETFILTER("Payable Gross Amount", '<>%1', 0.0);
            MonthlyAttendance.SETRANGE("Salary Processed", TRUE);
            MonthlyAttendance.SETRANGE(Posted, FALSE);

            if MonthlyAttendance.FINDSET() then
                repeat
                    Employee.GET(MonthlyAttendance."Employee No");
                    if NOT Employee."Stop Payment" then
                        CUSalaryPosting.Posting(MonthlyAttendance);

                    MonthlyAttendance.Posted := TRUE;
                    MonthlyAttendance.MODIFY();

                    ProcessedSalary.RESET();
                    ProcessedSalary.SETRANGE("Location Code", LocationCode);
                    ProcessedSalary.SETRANGE("Salary Plan Code", SalaryPlanCode);
                    ProcessedSalary.SETRANGE("Salary Cycle Code", SalaryCyclicCode);
                    ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");

                    if ProcessedSalary.FINDSET() then
                        repeat
                            ProcessedSalary."Salary Posted" := TRUE;
                            ProcessedSalary.MODIFY();
                        until ProcessedSalary.NEXT() = 0;
                until MonthlyAttendance.NEXT() = 0;

            GenJournalLine.RESET();
            GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
            GenJournalLine.SETRANGE("Journal Batch Name", JournalBatchName);
            if GenJournalLine.FINDSET then
                Codeunit.RUN(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

            MESSAGE('Posted Successfully..!!');
        end;
    end;
}