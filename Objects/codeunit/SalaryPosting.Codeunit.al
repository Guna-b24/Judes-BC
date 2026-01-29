codeunit 72005 "Salary Posting"
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
    end;

    var
        Text001: Label 'Pay Element - %1 is not found in Payelement Master';
        Text002: Label 'General Posting Group is not defined for Business Posting Group %1 %2';
        Text003: Label 'Business Posting %1 is not defined in Business Posting Group Master';
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        PayElements: Record "Pay Elements";
        Employee: Record Employee;
        PayrollBusinessPostingGroup: Record "Payroll Business Posting Group";
        PayrollProductPostingGroup: Record "Payroll Product Posting Group";
        PayrollGeneralPostingSetup: Record "Payroll General Posting Setup";
        Text004: Label 'G/L Account Not defined in Payroll General Posting %1 %2 ';
        PayrollEmployeePostingGroup: Record "Payroll Employee Posting Group";
        GenJournalLine: Record "Gen. Journal Line";
        PayDate: Date;
        BusinessPosting: Code[20];
        ProductPosting: Code[20];
        LocationCode: Code[20];
        SalaryPlanCode: Code[20];
        SalaryCyclicCode: Code[20];

    [Scope('Internal')]
    procedure Posting(MonthlyAttendance: Record "Monthly Attendance")
    var
        ProcessedSalary: Record "Processed Salary";
        "AccountNo.": Code[20];
        AcctType: Option "G/L Account","Bank Account";
    begin
        Employee.GET(MonthlyAttendance."Employee No");
        Employee.TESTFIELD("Pay Bus. Posting Group");
        Employee.TESTFIELD("Emp Posting Group");

        LocationCode := MonthlyAttendance."Location Code";
        SalaryPlanCode := MonthlyAttendance."Salary Plan Code";
        SalaryCyclicCode := MonthlyAttendance."Salary Cycle Code";

        BusinessPosting := Employee."Pay Bus. Posting Group";

        HRPayrollSetup.GET(USERID);
        LocationHRPayrollSetup.GET(HRPayrollSetup."Location Code");

        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", LocationCode);
        ProcessedSalary.SETRANGE("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SETRANGE("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE(Loan, FALSE);
        IF ProcessedSalary.FINDSET THEN
            REPEAT
                CASE ProcessedSalary."Pay Type" OF

                    ProcessedSalary."Pay Type"::Addition, ProcessedSalary."Pay Type"::Reimbursement:
                        IF NOT PayElements.GET(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode) THEN
                            ERROR(Text001, ProcessedSalary."Pay Element Code")
                        ELSE BEGIN
                            PayElements.TESTFIELD("Pay Prod. Posting Group");
                            IF NOT PayrollBusinessPostingGroup.GET(Employee."Pay Bus. Posting Group", LocationCode, SalaryPlanCode) THEN
                                ERROR(Text003, Employee."Pay Bus. Posting Group")
                            ELSE
                                IF NOT PayrollGeneralPostingSetup.GET(PayrollBusinessPostingGroup.Code,
                                    PayElements."Pay Prod. Posting Group",
                                    LocationCode, SalaryPlanCode)
                                THEN
                                    ERROR(Text002, PayrollBusinessPostingGroup.Code, PayElements."Pay Prod. Posting Group");
                        END;

                    ProcessedSalary."Pay Type"::Deduction:
                        IF (ProcessedSalary."Pay Element Code" <> 'PF') AND (ProcessedSalary."Pay Element Code" <> 'ESI') AND
                           (ProcessedSalary."Pay Element Code" <> 'TDS') AND (ProcessedSalary."Pay Element Code" <> 'PT')
                        THEN
                            IF NOT PayElements.GET(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode) THEN
                                ERROR(Text001, ProcessedSalary."Pay Element Code")
                            ELSE BEGIN
                                PayElements.TESTFIELD("Pay Prod. Posting Group");
                                IF NOT PayrollBusinessPostingGroup.GET(Employee."Pay Bus. Posting Group", LocationCode, SalaryPlanCode) THEN
                                    ERROR(Text003, Employee."Pay Bus. Posting Group")
                                ELSE BEGIN
                                    IF NOT PayrollGeneralPostingSetup.GET(PayrollBusinessPostingGroup.Code,
                                       PayElements."Pay Prod. Posting Group",
                                       LocationCode, SalaryPlanCode) THEN
                                        ERROR(Text002, PayrollBusinessPostingGroup.Code, PayElements."Pay Prod. Posting Group");
                                END;
                            END;
                END;
            UNTIL ProcessedSalary.NEXT = 0;

        // Finding the Debit Account & Credit Accounts for Additions & Deductions
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", LocationCode);
        ProcessedSalary.SETRANGE("Salary Plan Code", SalaryPlanCode);
        ProcessedSalary.SETRANGE("Salary Cycle Code", SalaryCyclicCode);
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE(Loan, FALSE);
        IF ProcessedSalary.FINDSET THEN
            REPEAT
                CASE ProcessedSalary."Pay Type" OF
                    ProcessedSalary."Pay Type"::Addition, ProcessedSalary."Pay Type"::Reimbursement:
                        BEGIN
                            PayElements.GET(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
                            PayrollProductPostingGroup.GET(PayElements."Pay Prod. Posting Group", LocationCode, SalaryPlanCode);

                            ProductPosting := PayrollProductPostingGroup.Code;
                            PayrollGeneralPostingSetup.GET(BusinessPosting, ProductPosting, LocationCode, SalaryPlanCode);

                            IF PayrollGeneralPostingSetup."G/L Code" = '' THEN
                                ERROR(Text004, PayrollGeneralPostingSetup."Pay Bus.Posting Group",
                                PayrollGeneralPostingSetup."Pay Prod. Posting Group");
                            ProcessedSalary."Account No." := PayrollGeneralPostingSetup."G/L Code";
                            ProcessedSalary.MODIFY;

                            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name",
                              MonthlyAttendance."Journal Batch Name", MonthlyAttendance."Posted Document No",
                              MonthlyAttendance."Posted Date", PayrollGeneralPostingSetup."G/L Code", AcctType, ProcessedSalary."Payable Amount");
                        END;

                    ProcessedSalary."Pay Type"::Deduction:
                        IF (ProcessedSalary."Pay Element Code" <> 'PF') AND (ProcessedSalary."Pay Element Code" <> 'ESI')
                           AND (ProcessedSalary."Pay Element Code" <> 'TDS') AND
                           (ProcessedSalary."Pay Element Code" <> 'PT') AND
                           (ProcessedSalary."Pay Element Code" <> 'LOAN')
                        THEN BEGIN
                            PayElements.GET(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
                            PayrollProductPostingGroup.GET(PayElements."Pay Prod. Posting Group", LocationCode, SalaryPlanCode);
                            ProductPosting := PayrollProductPostingGroup.Code;
                            PayrollGeneralPostingSetup.GET(BusinessPosting, ProductPosting, LocationCode, SalaryPlanCode);
                            IF PayrollGeneralPostingSetup."G/L Code" = '' THEN
                                ERROR(Text004, PayrollGeneralPostingSetup."Pay Bus.Posting Group",
                                  PayrollGeneralPostingSetup."Pay Prod. Posting Group");
                            ProcessedSalary."Account No." := PayrollGeneralPostingSetup."G/L Code";
                            ProcessedSalary.MODIFY;
                            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name",
                            MonthlyAttendance."Journal Batch Name", MonthlyAttendance."Posted Document No",
                            MonthlyAttendance."Posted Date", PayrollGeneralPostingSetup."G/L Code", AcctType,
                              -ProcessedSalary."Payable Amount");
                        END;
                END;
            UNTIL ProcessedSalary.NEXT = 0;

        // EMPLOYER ESI CONTRIBUTION

        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE("Pay Element Code", 'ESI');
        IF ProcessedSalary.FINDFIRST THEN BEGIN
            LocationHRPayrollSetup.TESTFIELD("Employer ESI GL Code");
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
            MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date", LocationHRPayrollSetup."Employer ESI GL Code", AcctType,
            ProcessedSalary."Employer PF / ESI Amount");
        END;

        // EMPLOYER EPS CONTRIBUTION
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE("Pay Type", ProcessedSalary."Pay Type"::Deduction);
        ProcessedSalary.SETRANGE("Pay Element Code", 'PF');
        IF ProcessedSalary.FINDFIRST THEN BEGIN
            LocationHRPayrollSetup.TESTFIELD("Employer EPS GL Code");
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
            MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date", LocationHRPayrollSetup."Employer EPS GL Code", AcctType,
            ProcessedSalary."Employer EPS Amount");
        END;

        // EMPLOYER PF CONTRIBUTION,PF ADMIN CHARGES , ELDI CHARGES, RIFA CHARGES
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE("Pay Type", ProcessedSalary."Pay Type"::Deduction);
        ProcessedSalary.SETRANGE("Pay Element Code", 'PF');
        IF ProcessedSalary.FINDFIRST THEN BEGIN
            // EMPLOYER PF
            LocationHRPayrollSetup.TESTFIELD("Employer PF GL Code");
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
            MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date", LocationHRPayrollSetup."Employer PF GL Code", AcctType,
            ProcessedSalary."Employer PF / ESI Amount");

            // PF ADMIN CHARGES

            LocationHRPayrollSetup.TESTFIELD("PF Admin Charges GL Code");
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
            MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date", LocationHRPayrollSetup."PF Admin Charges GL Code",
              AcctType,
            ProcessedSalary."PF Admin Charges Amount");

            // ELDI CHARGES
            LocationHRPayrollSetup.TESTFIELD("EDLI Charges GLCode");
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
            MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date", LocationHRPayrollSetup."EDLI Charges GLCode", AcctType,
            ProcessedSalary."PF EDLI Amount");

            // RIFA CHARGES
            LocationHRPayrollSetup.TESTFIELD("RIFA Charges GL Code");
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
            MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date", LocationHRPayrollSetup."RIFA Charges GL Code", AcctType,
            ProcessedSalary."PF RIFA Amount");
        END;

        Deductions(MonthlyAttendance);
    end;

    [Scope('Internal')]
    procedure InitGenJnlLine(var ProcessedSalary: Record "Processed Salary"; JournalTemplate: Code[20]; JournalBatch: Code[20]; "DocumentNo.": Code[20]; PostingDate: Date; "AccountNo.": Code[20]; AccountType: Option "G/L Account","Bank Account"; Amount: Decimal)
    var
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        JnlDim: Record Table356;
    begin
        IF Amount <> 0 THEN BEGIN
            PayElements.GET(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
            GenJournalLine.INIT;
            GenJournalLine."Journal Template Name" := JournalTemplate;
            GenJournalLine."Journal Batch Name" := JournalBatch;
            GenJournalLine."Line No." += 10000;
            GenJournalLine."Account Type" := AccountType;
            GenJournalLine.VALIDATE("Account No.", "AccountNo.");
            GenJournalLine."Posting Date" := PostingDate;
            GenJournalLine."Document No." := "DocumentNo.";
            GenJournalLine.Description := ProcessedSalary."Employee No" + '+' + PayElements.Description + '+' + SalaryCyclicCode;
            GenJournalLine."Bal. Account Type" := AccountType;
            GenJournalLine.VALIDATE(Amount, Amount);
            GenJournalLine."Source Code" := 'GENJNL';
            GenJournalLine."Employee No." := ProcessedSalary."Employee No";
            GenJournalLine.INSERT;
        END;
    end;

    [Scope('Internal')]
    procedure Deductions(MonthlyAttendance: Record "Monthly Attendance")
    var
        ProcessedSalary: Record "Processed Salary";
        Additions: Decimal;
        Deductions: Decimal;
        AccountType: Option "G/L Account";
    begin
        PayrollEmployeePostingGroup.GET(Employee."Emp Posting Group", LocationCode, SalaryPlanCode);

        // PF Account
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE("Pay Type", ProcessedSalary."Pay Type"::Deduction);
        ProcessedSalary.SETRANGE("Pay Element Code", 'PF');
        IF ProcessedSalary.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("PF Payable A/c");
            ProcessedSalary."Account No." := PayrollEmployeePostingGroup."PF Payable A/c";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
              PayrollEmployeePostingGroup."PF Payable A/c", AccountType, -(ProcessedSalary."Employee PF / ESI Amount" +
              ProcessedSalary."Employer PF / ESI Amount"));
        END;

        // EPS Account
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE("Pay Type", ProcessedSalary."Pay Type"::Deduction);
        ProcessedSalary.SETRANGE("Pay Element Code", 'PF');
        IF ProcessedSalary.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("EPS Payable A/c");
            ProcessedSalary."Account No." := PayrollEmployeePostingGroup."EPS Payable A/c";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
             MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
              PayrollEmployeePostingGroup."EPS Payable A/c", AccountType, -ProcessedSalary."Employer EPS Amount");
        END;

        // PT PAYABLE ACCOUNT
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE("Pay Type", ProcessedSalary."Pay Type"::Deduction);
        ProcessedSalary.SETRANGE("Pay Element Code", 'PT');
        IF ProcessedSalary.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("PT Payable A/c");
            ProcessedSalary."Account No." := PayrollEmployeePostingGroup."PT Payable A/c";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
              PayrollEmployeePostingGroup."PT Payable A/c", AccountType, -ProcessedSalary."Payable Amount");
        END;

        // ESI Account
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE("Pay Type", ProcessedSalary."Pay Type"::Deduction);
        ProcessedSalary.SETRANGE("Pay Element Code", 'ESI');
        IF ProcessedSalary.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("ESI Payable A/c");
            ProcessedSalary."Account No." := PayrollEmployeePostingGroup."ESI Payable A/c";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
              PayrollEmployeePostingGroup."ESI Payable A/c", AccountType, -(ProcessedSalary."Employee PF / ESI Amount" +
              ProcessedSalary."Employer PF / ESI Amount"));
        END;

        // TDS Account
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE("Pay Type", ProcessedSalary."Pay Type"::Deduction);
        ProcessedSalary.SETRANGE("Pay Element Code", 'TDS');
        IF ProcessedSalary.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("TDS Payable A/c");
            ProcessedSalary."Account No." := PayrollEmployeePostingGroup."TDS Payable A/c";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
              PayrollEmployeePostingGroup."TDS Payable A/c", AccountType, -ProcessedSalary."Payable Amount");
        END;

        // BONUS Account
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE("Pay Type", ProcessedSalary."Pay Type"::Deduction);
        ProcessedSalary.SETRANGE("Pay Element Code", 'BONUS');
        IF ProcessedSalary.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("Bonus Payable A/c");
            ProcessedSalary."Account No." := PayrollEmployeePostingGroup."Bonus Payable A/c";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
              PayrollEmployeePostingGroup."Bonus Payable A/c", AccountType, -ProcessedSalary."Payable Amount");
        END;

        // LOAN Account
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE("Pay Type", ProcessedSalary."Pay Type"::Deduction);
        ProcessedSalary.SETRANGE("Pay Element Code", 'LOAN');
        IF ProcessedSalary.FINDSET THEN
            REPEAT
                PayElements.GET(ProcessedSalary."Pay Element Code", LocationCode, SalaryPlanCode);
                PayElements.TESTFIELD("GL Code");
                ProcessedSalary."Account No." := PayElements."GL Code";
                ProcessedSalary.MODIFY;
                InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                  MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
                  PayElements."GL Code", AccountType, -ProcessedSalary."Payable Amount");
            UNTIL ProcessedSalary.NEXT = 0;

        // Salary Payable Account
        Additions := 0;
        Deductions := 0;
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        IF ProcessedSalary.FINDSET THEN
            REPEAT
                CASE ProcessedSalary."Pay Type" OF
                    ProcessedSalary."Pay Type"::Addition, ProcessedSalary."Pay Type"::Reimbursement:

                        IF ProcessedSalary."Payment Type" IN [ProcessedSalary."Payment Type"::"Full Payment",
                           ProcessedSalary."Payment Type"::"First Payment"]
                        THEN
                            Additions := Additions + ProcessedSalary."Payable Amount";
                    ProcessedSalary."Pay Type"::Deduction:
                        Deductions := Deductions + ProcessedSalary."Payable Amount";
                END;
            UNTIL ProcessedSalary.NEXT = 0;

        InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
          MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
          PayrollEmployeePostingGroup."Salary Payable1 A/c",
          AccountType, -(Additions - Deductions));

        Additions := 0;
        Deductions := 0;

        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        IF ProcessedSalary.FINDSET THEN
            REPEAT
                CASE ProcessedSalary."Pay Type" OF
                    ProcessedSalary."Pay Type"::Addition, ProcessedSalary."Pay Type"::Reimbursement:

                        IF ProcessedSalary."Payment Type" = ProcessedSalary."Payment Type"::"Second Payment" THEN
                            Additions := Additions + ProcessedSalary."Payable Amount";
                END;
            UNTIL ProcessedSalary.NEXT = 0;

        InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
          MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
          PayrollEmployeePostingGroup."Salary Payable2 A/c",
          AccountType, -Additions);

        // PF ADMIN CHARGES , ELDI CHARGES, RIFA CHARGES

        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Location Code", MonthlyAttendance."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", MonthlyAttendance."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", MonthlyAttendance."Salary Cycle Code");
        ProcessedSalary.SETRANGE("Employee No", MonthlyAttendance."Employee No");
        ProcessedSalary.SETRANGE("Pay Type", ProcessedSalary."Pay Type"::Deduction);
        ProcessedSalary.SETRANGE("Pay Element Code", 'PF');
        IF ProcessedSalary.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("PF Admin Charge Payable A/c");
            //  ProcessedSalary."Account No.":=EmpPostingSetup."PF Admin Charge Payable A/c";
            //  ProcessedSalary.MODIFY;
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
             MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
             PayrollEmployeePostingGroup."PF Admin Charge Payable A/c", AccountType,
            -ProcessedSalary."PF Admin Charges Amount");

            PayrollEmployeePostingGroup.TESTFIELD("EDLI Payable A/c");
            //  ProcessedSalary."Account No.":=EmpPostingSetup."EDLI Payable A/c";
            //  ProcessedSalary.MODIFY;
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
              PayrollEmployeePostingGroup."EDLI Payable A/c", AccountType,
             -ProcessedSalary."PF EDLI Amount");

            PayrollEmployeePostingGroup.TESTFIELD("RIFA Payable A/c");
            ProcessedSalary."Account No." := PayrollEmployeePostingGroup."RIFA Payable A/c";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Posted Document No", MonthlyAttendance."Posted Date",
              PayrollEmployeePostingGroup."RIFA Payable A/c", AccountType,
            -ProcessedSalary."PF RIFA Amount");
        END;
    end;
}

