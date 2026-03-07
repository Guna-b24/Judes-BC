codeunit 70025 "Post Salary"
{
    procedure Consolidate(
     JournalBatchName: Code[20];
     TemplateName: Code[20];
     DocumentNo: Code[20];
     PostedDate: Date;
     LocationCode: Code[20];
     SalaryPlanCode: Code[20];
     SalaryCyclicCode: Code[20];
     BranchCode: Code[20];
     StartDate: Date;
     EndDate: Date)
    var
        SalaryPosting: Record "Salary Posting";
        ProcessedSalary: Record "Processed Salary";
        GenJournalLine: Record "Gen. Journal Line";
        EmployeeRec: Record Employee;
        EmployeePayElem: Record "Employee Pay Elements";
        MonthlyAttendance: Record "Monthly Attendance";
        TotalEarnings: Decimal;
        TotalDeductions: Decimal;
    begin
        // Validation
        if JournalBatchName = '' then
            Error('Enter Journal Batch Name');
        if DocumentNo = '' then
            Error('Enter Document No.');
        if PostedDate = 0D then
            Error('Enter Posted Date');

        if not Confirm('Do you want to post salary?') then
            exit;

        // Loop through processed salaries
        ProcessedSalary.Reset();
        ProcessedSalary.SetRange("Location Code", LocationCode);
        ProcessedSalary.SetRange("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SetRange("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SetRange("PF Applicable", true);
        if BranchCode <> '' then
            ProcessedSalary.SetRange("Branch Code", BranchCode);

        if ProcessedSalary.Find('-') then
            repeat
                // Delete previous postings
                SalaryPosting.Reset();
                SalaryPosting.SetRange("Location Code", ProcessedSalary."Location Code");
                SalaryPosting.SetRange("Salary Plan Code", ProcessedSalary."Salary Plan Code");
                SalaryPosting.SetRange("Salary Cycle Code", ProcessedSalary."Salary Cycle Code");
                SalaryPosting.SetRange("Branch Code", ProcessedSalary."Branch Code");
                if SalaryPosting.Find('-') then
                    SalaryPosting.Delete();

                // Insert new salary posting
                SalaryPosting.Init();
                SalaryPosting."Location Code" := ProcessedSalary."Location Code";
                SalaryPosting."Salary Plan Code" := ProcessedSalary."Salary Plan Code";
                SalaryPosting."Salary Cycle Code" := ProcessedSalary."Salary Cycle Code";
                SalaryPosting."Branch Code" := ProcessedSalary."Branch Code";
                SalaryPosting."Pay Element Code" := ProcessedSalary."Pay Element Code";
                SalaryPosting."Payroll Start Date" := StartDate;
                SalaryPosting."Payroll End Date" := EndDate;
                SalaryPosting.Year := ProcessedSalary.Year;
                SalaryPosting.Month := ProcessedSalary.Month;
                SalaryPosting."Pay Type" := ProcessedSalary."Pay Type";
                SalaryPosting."Actual Amount" := ProcessedSalary."Actual Amount";
                SalaryPosting."Payable Amount" := ProcessedSalary."Payable Amount";
                SalaryPosting."Employee VPF Amount" := ProcessedSalary."Employee VPF Amount";
                SalaryPosting."Employee PF / ESI Amount" := ProcessedSalary."Employee PF / ESI Amount";
                SalaryPosting."Employer PF / ESI Amount" := ProcessedSalary."Employer PF / ESI Amount";
                SalaryPosting."Employer EPS Amount" := ProcessedSalary."Employer EPS Amount";
                SalaryPosting."PF Admin Charges Amount" := ProcessedSalary."PF Admin Charges Amount";
                SalaryPosting."PF EDLI Amount" := ProcessedSalary."PF EDLI Amount";
                SalaryPosting."PF RIFA Amount" := ProcessedSalary."PF RIFA Amount";
                SalaryPosting."Salary Due Entry" := true;
                SalaryPosting."Sorting Order" := ProcessedSalary."Sorting Order";

                if EmployeeRec.Get(ProcessedSalary."Employee No") then begin
                    SalaryPosting."Emp Posting Group" := EmployeeRec."Employee Posting Group";
                    SalaryPosting."Pay Bus. Posting Group" := EmployeeRec."Pay Bus. Posting Group";
                end;

                SalaryPosting.Insert();
            until ProcessedSalary.Next() = 0;


        // Calculate Net Amount
        TotalEarnings := 0;
        TotalDeductions := 0;

        SalaryPosting.Reset();
        SalaryPosting.SetRange("Location Code", LocationCode);
        SalaryPosting.SetRange("Salary Plan Code", SalaryPlanCode);
        SalaryPosting.SetRange("Salary Cycle Code", SalaryCyclicCode);
        if BranchCode <> '' then
            SalaryPosting.SetRange("Branch Code", BranchCode);

        if SalaryPosting.Find('-') then begin
            repeat
                if SalaryPosting."Pay Type" = SalaryPosting."Pay Type"::Addition then
                    TotalEarnings += SalaryPosting."Payable Amount";

                if SalaryPosting."Pay Type" = SalaryPosting."Pay Type"::Deduction then
                    TotalDeductions += SalaryPosting."Payable Amount";
            until SalaryPosting.Next() = 0;

            // Insert NET AMT
            SalaryPosting.Init();
            SalaryPosting."Location Code" := LocationCode;
            SalaryPosting."Salary Plan Code" := SalaryPlanCode;
            SalaryPosting."Salary Cycle Code" := SalaryCyclicCode;
            SalaryPosting."Branch Code" := BranchCode;
            SalaryPosting."Pay Element Code" := 'NET AMT';
            SalaryPosting."Pay Type" := SalaryPosting."Pay Type"::Deduction;
            SalaryPosting."Actual Amount" := 0;
            SalaryPosting."Payable Amount" := TotalEarnings - TotalDeductions;
            SalaryPosting."Salary Payment Entry" := true;
            SalaryPosting."Sorting Order" := 991;
            SalaryPosting.Insert();
        end;

        // Update Monthly Attendance
        MonthlyAttendance.Reset();
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Salary Cycle Code", SalaryCyclicCode);
        if BranchCode <> '' then
            MonthlyAttendance.SetRange("Branch Code", BranchCode);
        MonthlyAttendance.SetRange("Salary Processed", true);

        if MonthlyAttendance.Find('-') then
            repeat
                MonthlyAttendance."Journal Batch Name" := JournalBatchName;
                MonthlyAttendance."Journal Template Name" := TemplateName;
                MonthlyAttendance."Posted Document No" := DocumentNo;
                MonthlyAttendance."Posted Date" := PostedDate;
                MonthlyAttendance.Posted := true;
                MonthlyAttendance.Modify();
            until MonthlyAttendance.Next() = 0;

        Message('Salary Posted Successfully!');
    end;

    procedure PostMonthlyEmployee(
     JournalBatchName: Code[20];
     TemplateName: Code[20];
     DocumentNo: Code[20];
     PostedDate: Date;
     LocationCode: Code[20];
     SalaryPlanCode: Code[20];
     SalaryCyclicCode: Code[20];
     BranchCode: Code[20];
     StartDate: Date;
     EndDate: Date)
    var
        ProcessedSalary: Record "Processed Salary";
        SalaryPostingRec: Record "Salary Posting-1";
        employee: Record Employee;
    begin
        // Loop through Processed Salary to prepare Salary Posting records
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Location Code", LocationCode);
        ProcessedSalary.SETRANGE("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SETRANGE("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SETRANGE("PF Applicable", TRUE);
        IF BranchCode <> '' THEN
            ProcessedSalary.SETRANGE("Branch Code", BranchCode);

        IF ProcessedSalary.FINDSET() THEN
            REPEAT
                SalaryPostingRec.INIT();
                // Copy fields individually to avoid type conversion errors
                SalaryPostingRec."Location Code" := ProcessedSalary."Location Code";
                SalaryPostingRec."Salary Plan Code" := ProcessedSalary."Salary Plan Code";
                SalaryPostingRec."Salary Cycle Code" := ProcessedSalary."Salary Cycle Code";
                SalaryPostingRec."Branch Code" := ProcessedSalary."Branch Code";
                SalaryPostingRec."Pay Element Code" := ProcessedSalary."Pay Element Code";
                SalaryPostingRec."Actual Amount" := ProcessedSalary."Actual Amount";
                SalaryPostingRec."Payable Amount" := ProcessedSalary."Payable Amount";
                SalaryPostingRec."Employee VPF Amount" := ProcessedSalary."Employee VPF Amount";
                SalaryPostingRec."Employee PF / ESI Amount" := ProcessedSalary."Employee PF / ESI Amount";
                SalaryPostingRec."Employer PF / ESI Amount" := ProcessedSalary."Employer PF / ESI Amount";
                SalaryPostingRec."Employer EPS Amount" := ProcessedSalary."Employer EPS Amount";
                SalaryPostingRec."PF Admin Charges Amount" := ProcessedSalary."PF Admin Charges Amount";
                SalaryPostingRec."PF EDLI Amount" := ProcessedSalary."PF EDLI Amount";
                SalaryPostingRec."PF RIFA Amount" := ProcessedSalary."PF RIFA Amount";
                SalaryPostingRec."Salary Due Entry" := TRUE;
                SalaryPostingRec."Payroll Start Date" := StartDate;
                SalaryPostingRec."Payroll End Date" := EndDate;
                SalaryPostingRec.Year := ProcessedSalary.Year;
                SalaryPostingRec.Month := ProcessedSalary.Month;
                SalaryPostingRec."Pay Type" := ProcessedSalary."Pay Type";
                SalaryPostingRec."Sorting Order" := ProcessedSalary."Sorting Order";

                // Set employee posting groups
                if Employee.GET(ProcessedSalary."Employee No") then begin
                    SalaryPostingRec."Emp Posting Group" := Employee."Emp Posting Group";
                    SalaryPostingRec."Pay Bus. Posting Group" := Employee."Pay Bus. Posting Group";
                end;

                // Insert or update the record
                IF NOT SalaryPostingRec.GET(SalaryPostingRec."Location Code", SalaryPostingRec."Salary Plan Code",
                                            SalaryPostingRec."Salary Cycle Code", SalaryPostingRec."Branch Code",
                                            SalaryPostingRec."Pay Element Code") THEN
                    SalaryPostingRec.INSERT()
                ELSE BEGIN
                    SalaryPostingRec."Actual Amount" += ProcessedSalary."Actual Amount";
                    SalaryPostingRec."Payable Amount" += ProcessedSalary."Payable Amount";
                    SalaryPostingRec."Employee VPF Amount" += ProcessedSalary."Employee VPF Amount";
                    SalaryPostingRec."Employee PF / ESI Amount" += ProcessedSalary."Employee PF / ESI Amount";
                    SalaryPostingRec."Employer PF / ESI Amount" += ProcessedSalary."Employer PF / ESI Amount";
                    SalaryPostingRec."Employer EPS Amount" += ProcessedSalary."Employer EPS Amount";
                    SalaryPostingRec."PF Admin Charges Amount" += ProcessedSalary."PF Admin Charges Amount";
                    SalaryPostingRec."PF EDLI Amount" += ProcessedSalary."PF EDLI Amount";
                    SalaryPostingRec."PF RIFA Amount" += ProcessedSalary."PF RIFA Amount";
                    SalaryPostingRec.MODIFY();
                END;
            UNTIL ProcessedSalary.NEXT() = 0;

        // Call the existing PostSalary procedure
        Consolidate(
            JournalBatchName,
            TemplateName,
            DocumentNo,
            PostedDate,
            LocationCode,
            SalaryPlanCode,
            SalaryCyclicCode,
            BranchCode,
            StartDate,
            EndDate);
    end;

    procedure PostSalary(
        JournalBatchName: Code[20];
        TemplateName: Code[20];
        LocationCode: Code[20];
        SalaryPlanCode: Code[20];
        SalaryCyclicCode: Code[20];
        BranchCode: Code[20])
    var
        //  SalaryPosting: Record "Salary Posting";
        GenJournalLine: Record "Gen. Journal Line";
        MonthlyAttendance: Record "Monthly Attendance";
    begin
        // Validation
        if JournalBatchName = '' then
            Error('Enter Journal Batch Name');

        // Post to GL
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", TemplateName);
        GenJournalLine.SetRange("Journal Batch Name", JournalBatchName);
        if GenJournalLine.FindSet() then
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine);

        // Update Monthly Attendance
        MonthlyAttendance.Reset();
        MonthlyAttendance.SetRange("Location Code", LocationCode);
        MonthlyAttendance.SetRange("Salary Plan Code", SalaryPlanCode);
        MonthlyAttendance.SetRange("Salary Cycle Code", SalaryCyclicCode);
        if BranchCode <> '' then
            MonthlyAttendance.SetRange("Branch Code", BranchCode);
        MonthlyAttendance.SetRange("Salary Processed", true);

        if MonthlyAttendance.FindSet() then
            repeat
                MonthlyAttendance.Posted := true;
                MonthlyAttendance.Modify();
            until MonthlyAttendance.Next() = 0;

        Message('Salary Posted Successfully!');
    end;
}
