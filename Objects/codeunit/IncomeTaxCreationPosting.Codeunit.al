codeunit 72009 "Income Tax Creation / Posting"
{
    trigger OnRun()
    begin
    end;

    var
        IncomeTaxHeader: Record "Income Tax Header";
        IncomeTaxLine: Record "Income Tax Line";
        CUGeneralFunctions: Codeunit "General Functions";
        ProjectedMonth: Integer;
        GrossEarningSalary: Decimal;
        LocationCode: Code[20];
        SalaryPlanCode: Code[20];
        AssessmentYear: Code[20];
        EmployeeNo: Code[20];
        LastMonthGrossSalary: Decimal;
        TotalBasicDAAmount: Decimal;
        TotalHRAAmount: Decimal;
        TotalRentPaid: Decimal;
        CalcHRAAmount: Decimal;
        TaxGender: Option Male,Female,"Sr.Citizen";


    procedure "Create Income Tax Records"(LocationCode: Code[20]; SalaryPlanCode: Code[20]; AssessmentYear: Code[20])
    var
        IncomeTax: Record "Income Tax";
        Employee: Record Employee;
        RecordCount: Integer;

    begin
        IF NOT CONFIRM('Do U Want ( Create / Add New Employee ) to Income Tax file ', FALSE) THEN
            EXIT;

        IF AssessmentYear <> '' THEN BEGIN

            Employee.RESET();
            Employee.SETRANGE("Location Code", LocationCode);
            Employee.SETRANGE("Salary Plan Code", SalaryPlanCode);
            //Employee.SETRANGE(Status,Employee.Status::Active);
            IF Employee.FINDFIRST() THEN BEGIN
                RecordCount := Employee.COUNT;
                CUGeneralFunctions.OpenWindow('Income Tax Creation\\', 'Progress');

                REPEAT
                    IncomeTax.INIT();
                    IncomeTax."Location Code" := LocationCode;
                    IncomeTax."Salary Plan Code" := SalaryPlanCode;
                    IncomeTax."Assessment Year" := AssessmentYear;
                    IncomeTax."Employee No" := Employee."No.";
                    IncomeTax.Name := Employee."First Name" + ' ' + Employee.Initials;
                    IncomeTax.Designation := Employee."Designation Name";
                    IncomeTax."P.A.N.No" := Employee."PAN No";
                    IncomeTax.Sex := Employee.Gender;

                    CUGeneralFunctions.UpdateWindow(IncomeTax."Employee No", RecordCount);

                    IF IncomeTax.INSERT() THEN;

                UNTIL Employee.NEXT() = 0;
            END;
            CUGeneralFunctions.CloseWindow();
            MESSAGE('Process Completed..');
        END
    end;

    procedure "Income Tax Zero Updation"(LocationCode: Code[20]; SalaryPlanCode: Code[20]; AssessmentYear: Code[20])
    var
        PayrollYear: Record "Payroll Year";
        PayrollMonthYear: Record "Payroll Month & Year";
        IncomeTax: Record "Income Tax";
        IncomeTaxRecRef: RecordRef;
        IncomeTaxFieldRef: FieldRef;
        RecordCount: Integer;
        I: Integer;
    begin
        IF NOT CONFIRM('Do U Want Initialize All Fields', FALSE) THEN
            EXIT;

        IncomeTax.RESET();
        IncomeTax.SETRANGE("Location Code", LocationCode);
        IncomeTax.SETRANGE("Salary Plan Code", SalaryPlanCode);
        IncomeTax.SETRANGE("Assessment Year", AssessmentYear);
        IncomeTax.SETRANGE(Verified, FALSE);
        IF IncomeTax.FINDFIRST() THEN BEGIN
            RecordCount := IncomeTax.COUNT;
            CUGeneralFunctions.OpenWindow('Income Tax Creation\\', 'Progress');
            REPEAT
                IncomeTaxRecRef.GETTABLE(IncomeTax);
                FOR I := 14 TO IncomeTaxRecRef.FIELDCOUNT - 1 DO BEGIN
                    IncomeTaxFieldRef := IncomeTaxRecRef.FIELD(I);
                    IncomeTaxFieldRef.VALUE := 0;
                    IncomeTaxRecRef.MODIFY();
                END;

                CUGeneralFunctions.UpdateWindow(IncomeTax."Employee No", RecordCount);
            UNTIL IncomeTax.NEXT() = 0;

            PayrollYear.RESET();
            PayrollYear.SETRANGE("Location Code", LocationCode);
            PayrollYear.SETRANGE("Salary Plan Code", SalaryPlanCode);
            PayrollYear.SETRANGE("Year Code", AssessmentYear);
            IF PayrollYear.FINDFIRST() THEN BEGIN
                PayrollMonthYear.RESET();
                PayrollMonthYear.SETRANGE("Location Code", LocationCode);
                PayrollMonthYear.SETRANGE("Salary Plan Code", SalaryPlanCode);
                PayrollMonthYear.SETRANGE("Salary Start Date", PayrollYear."Year Start Date", PayrollYear."Year End Date");
                IF PayrollMonthYear.FINDFIRST() THEN
                    PayrollMonthYear.MODIFYALL("Income Tax Salary Posted", FALSE);
            END;

            CUGeneralFunctions.CloseWindow();
            MESSAGE('Zero Updated..!!');
        END;
    end;


    procedure "Pay Elements Updation"(LocationCode: Code[20]; SalaryPlanCode: Code[20]; AssessmentYear: Code[20]; SalaryYearCode: Code[20]; SalaryCycleCode: Code[20]; UpdateFlag: Boolean; LProjectionMonth: Integer)
    var
        IncomeTax: Record "Income Tax";
        PayrollMonthYear: Record "Payroll Month & Year";
        PayElements: Record "Pay Elements";
        RecordCount: Integer;
    begin
        IF NOT UpdateFlag THEN
            ERROR('Please Tick the Update Monthly Salary (Yes/No) & Select the Salary Cyclic Code');

        IF NOT CONFIRM('Do U Want Run Salary Updation Process', FALSE) THEN
            EXIT;

        PayrollMonthYear.RESET();
        PayrollMonthYear.SETRANGE("Location Code", LocationCode);
        PayrollMonthYear.SETRANGE("Salary Plan Code", SalaryPlanCode);
        PayrollMonthYear.SETRANGE("Salary Year Code", SalaryYearCode);
        PayrollMonthYear.SETRANGE("Salary Cyclic Code", SalaryCycleCode);
        PayrollMonthYear.SETRANGE("Income Tax Salary Posted", TRUE);
        IF PayrollMonthYear.FINDFIRST() THEN
            ERROR('Salary Already Process for this period');

        RecordCount := 0;
        //GrossEarningSalary  := 0; PFAmount := 0; LICAmount := 0;
        //IncomeTaxPaidAmount := 0; ProfessionalTaxAmount := 0;

        ProjectedMonth := LProjectionMonth;

        IncomeTax.RESET();
        IncomeTax.SETRANGE("Location Code", LocationCode);
        IncomeTax.SETRANGE("Salary Plan Code", SalaryPlanCode);
        IncomeTax.SETRANGE("Assessment Year", AssessmentYear);
        IncomeTax.SETRANGE(Verified, FALSE);
        IF IncomeTax.FINDFIRST() THEN BEGIN
            RecordCount := IncomeTax.COUNT;
            CUGeneralFunctions.OpenWindow('Income Tax Salary Updation\\', 'Progress');
            REPEAT
                IncomeTax."Salary Year" := SalaryYearCode;
                IncomeTax."Salary Cyclic Code" := SalaryCycleCode;

                LastMonthGrossSalary := 0;
                PayElements.RESET();
                PayElements.SETRANGE("Location Code", LocationCode);
                PayElements.SETRANGE("Salary Plan Code", SalaryPlanCode);
                IF PayElements.FINDFIRST() THEN
                    REPEAT
                        "Processed Salary Checking"(PayElements, IncomeTax);
                    UNTIL PayElements.NEXT() = 0;
            UNTIL IncomeTax.NEXT() = 0;  //  Income Tax Loop Ends Here.
        END;

        PayrollMonthYear.RESET();
        PayrollMonthYear.SETRANGE("Location Code", LocationCode);
        PayrollMonthYear.SETRANGE("Salary Plan Code", SalaryPlanCode);
        PayrollMonthYear.SETRANGE("Salary Year Code", SalaryYearCode);
        PayrollMonthYear.SETRANGE("Salary Cyclic Code", SalaryCycleCode);
        IF PayrollMonthYear.FINDFIRST() THEN BEGIN
            PayrollMonthYear."Income Tax Salary Posted" := TRUE;
            PayrollMonthYear.MODIFY();
        END;

        CUGeneralFunctions.CloseWindow();

        //MESSAGE('         Total Gross Earnings => %1', ROUND(GrossEarningSalary),2);
        //MESSAGE('Total Professional Tax Amount => %1', ProfessionalTaxAmount);
        //MESSAGE('              Total PF Amount => %1', PFAmount);
        //MESSAGE('             Total LIC Amount => %1', LICAmount);
        //MESSAGE(' Total Income Tax Paid Amount => %1', IncomeTaxPaidAmount);

        MESSAGE('Updation Completed..!!');
    end;


    procedure "Processed Salary Checking"(PayElements: Record "Pay Elements"; var IncomeTax: Record "Income Tax")
    var
        ProcessedSalary: Record "Processed Salary";
    begin
        ProcessedSalary.RESET();
        ProcessedSalary.SETRANGE("Location Code", PayElements."Location Code");
        ProcessedSalary.SETRANGE("Salary Plan Code", PayElements."Salary Plan Code");
        ProcessedSalary.SETRANGE("Salary Cycle Code", IncomeTax."Salary Cyclic Code");
        ProcessedSalary.SETRANGE("Employee No", IncomeTax."Employee No");
        ProcessedSalary.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
        IF ProcessedSalary.FIND('-') THEN
            REPEAT
                IF ProcessedSalary."Pay Type" = ProcessedSalary."Pay Type"::Addition THEN
                    IF PayElements."Eligible for Income Tax" THEN BEGIN
                        LastMonthGrossSalary += ProcessedSalary."Payable Amount";
                        IncomeTax."Last Month Gross Salary" := LastMonthGrossSalary;
                        IncomeTax."Salary Gross Earning Actual" += ProcessedSalary."Payable Amount";
                        IncomeTax."Salary Gross Earning Projected" := (LastMonthGrossSalary * ProjectedMonth);

                        IF IncomeTax."Projection Not Required" THEN
                            IncomeTax."Salary Gross Earning Projected" := 0;

                        IncomeTax."Salary Gross Earning Total" := (IncomeTax."Salary Gross Earning Actual" +
                                                                        IncomeTax."Salary Gross Earning Projected");
                        GrossEarningSalary += ProcessedSalary."Payable Amount";
                    END;


                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-01" THEN
                    IncomeTax.Bonus += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-02" THEN
                    IncomeTax."Leave Salary" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-03" THEN
                    IncomeTax."Arrears Amount" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-04" THEN
                    IncomeTax."D.A Arrears - 1" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-05" THEN
                    IncomeTax."D.A Arrears - 2" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-06" THEN
                    IncomeTax."HRA Arrears" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-07" THEN
                    IncomeTax."Hon Amount" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-08" THEN
                    IncomeTax."Medical Reimburement" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-09" THEN
                    IncomeTax."Previous Job Earnings" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-10" THEN
                    IncomeTax.LTA += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-11" THEN
                    IncomeTax."Perk-1" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-12" THEN
                    IncomeTax."Perk-2" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-13" THEN
                    IncomeTax."Other Earnings-1" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-14" THEN
                    IncomeTax."Other Earnings-2" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-15" THEN
                    IncomeTax.HRA += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-16" THEN
                    IncomeTax."Conv.Allowance" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-17" THEN
                    IncomeTax."Transport Conveyance" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-19" THEN
                    IncomeTax."Food Plus Card Allow" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-20" THEN
                    IncomeTax."Professional Tax" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-21" THEN
                    IncomeTax."Entertainment Tax" += ABS(ProcessedSalary."Payable Amount");

                //     IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"E-22" THEN
                //        IncomeTax."Housing Loan Interest" += ABS(ProcessedSalary."Payable Amount");

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"D-01" THEN BEGIN
                    IncomeTax."Actual - PF (Salary)" += ABS(ProcessedSalary."Payable Amount");
                    IncomeTax."Proj - PF (Salary)" := ABS(ProcessedSalary."Payable Amount" * ProjectedMonth);
                END;

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"D-02" THEN BEGIN
                    IncomeTax."Actual - LIC Premium (Salary)" += ABS(ProcessedSalary."Payable Amount");
                    IncomeTax."Proj - LIC Premium (Salary)" := ABS(ProcessedSalary."Payable Amount" * ProjectedMonth);
                END;

                IF PayElements."Income Tax Link Code" = PayElements."Income Tax Link Code"::"D-03" THEN
                    IncomeTax."Tax Paid" += ABS(ProcessedSalary."Payable Amount");

                IncomeTax."Remaining Month for Projection" := ProjectedMonth;

                "Insert Challan Details"(IncomeTax."Assessment Year", IncomeTax."Salary Year", ProcessedSalary);

                IncomeTax.MODIFY();

                CUGeneralFunctions.UpdateWindow(IncomeTax."Employee No", ProcessedSalary.COUNT);

            UNTIL ProcessedSalary.NEXT() = 0;  // Processed Salary Ends Here.
    end;


    procedure "Insert Challan Details"(AssessmentYear: Code[20]; SalaryYear: Code[20]; ProcessedSalary: Record "Processed Salary")
    var
        IncomeTaxChallanDetails: Record "Income Tax Challan Details";
        PayElements: Record "Pay Elements";
    begin
        IncomeTaxChallanDetails.RESET();
        IncomeTaxChallanDetails.SETRANGE("Location Code", ProcessedSalary."Location Code");
        IncomeTaxChallanDetails.SETRANGE("Salary Plan Code", ProcessedSalary."Salary Plan Code");
        IncomeTaxChallanDetails.SETRANGE("Assessment Year", AssessmentYear);
        IncomeTaxChallanDetails.SETRANGE("Salary Cyclic Code", ProcessedSalary."Salary Cycle Code");
        IncomeTaxChallanDetails.SETRANGE("Employe No", ProcessedSalary."Employee No");

        IF NOT IncomeTaxChallanDetails.FINDFIRST() THEN BEGIN
            IncomeTaxChallanDetails."Location Code" := ProcessedSalary."Location Code";
            IncomeTaxChallanDetails."Salary Plan Code" := ProcessedSalary."Salary Plan Code";
            IncomeTaxChallanDetails."Assessment Year" := AssessmentYear;
            IncomeTaxChallanDetails."Salary Year" := SalaryYear;
            IncomeTaxChallanDetails."Salary Cyclic Code" := ProcessedSalary."Salary Cycle Code";
            IncomeTaxChallanDetails."Employe No" := ProcessedSalary."Employee No";
            IncomeTaxChallanDetails."Salary Paid Date" := ProcessedSalary."Payroll End Date";
            IncomeTaxChallanDetails."Challan Process Year" := DATE2DMY(IncomeTaxChallanDetails."Salary Paid Date", 3);
            IncomeTaxChallanDetails."Challan Process Month" := DATE2DMY(IncomeTaxChallanDetails."Salary Paid Date", 2);

            PayElements.GET(ProcessedSalary."Pay Element Code", ProcessedSalary."Location Code", ProcessedSalary."Salary Plan Code");
            IF PayElements."Eligible for Income Tax" THEN
                IF ProcessedSalary."Pay Type" = ProcessedSalary."Pay Type"::Addition THEN
                    IncomeTaxChallanDetails."Taxable Gross Salary" := ProcessedSalary."Payable Amount";


            IF ProcessedSalary."Pay Element Code" = 'IT' THEN BEGIN
                IncomeTaxChallanDetails."Challan Income Tax" := ABS(ProcessedSalary."Payable Amount");
                IncomeTaxChallanDetails.VALIDATE("Challan Income Tax", ABS(ProcessedSalary."Payable Amount"));
                IncomeTaxChallanDetails.VALIDATE("TDS/TCS Income Tax", ABS(ProcessedSalary."Payable Amount"));
                IncomeTaxChallanDetails."Total Deposit as Deductee" := ABS(ProcessedSalary."Payable Amount");
            END;
            IF IncomeTaxChallanDetails.INSERT() THEN;
        END
        ELSE BEGIN

            PayElements.GET(ProcessedSalary."Pay Element Code", ProcessedSalary."Location Code", ProcessedSalary."Salary Plan Code");

            IF PayElements."Eligible for Income Tax" THEN
                IF ProcessedSalary."Pay Type" = ProcessedSalary."Pay Type"::Addition THEN
                    IncomeTaxChallanDetails."Taxable Gross Salary" += ProcessedSalary."Payable Amount";


            IF ProcessedSalary."Pay Element Code" = 'IT' THEN BEGIN
                IncomeTaxChallanDetails."Challan Income Tax" := ABS(ProcessedSalary."Payable Amount");
                IncomeTaxChallanDetails.VALIDATE("Challan Income Tax", ABS(ProcessedSalary."Payable Amount"));
                IncomeTaxChallanDetails.VALIDATE("TDS/TCS Income Tax", ABS(ProcessedSalary."Payable Amount"));
                IncomeTaxChallanDetails."Total Deposit as Deductee" := ABS(ProcessedSalary."Payable Amount");
            END;
            IncomeTaxChallanDetails.MODIFY();
        END;
    end;


    procedure "Calculate Medical"(LLocationCode: Code[20]; LSalaryPlanCode: Code[20]; LAssessmentYear: Code[20]; LEmployeeNo: Code[20])
    var
        IncomeTax: Record "Income Tax";
        ITExemption: Record "Income Tax Exemptions";
    begin
        //*******************GET IT EXEMPTIONS******************* START
        LocationCode := LLocationCode;
        SalaryPlanCode := LSalaryPlanCode;
        AssessmentYear := LAssessmentYear;

        "Get Income Tax Header"();

        IncomeTax.RESET();
        IncomeTax.SETRANGE("Location Code", LocationCode);
        IncomeTax.SETRANGE("Salary Plan Code", SalaryPlanCode);
        IncomeTax.SETRANGE("Assessment Year", AssessmentYear);
        //IncomeTax.SETRANGE(IncomeTax."Employee No",EmployeeNo);
        IncomeTax.SETRANGE(Verified, FALSE);
        IF IncomeTax.FINDFIRST() THEN
            REPEAT
                ITExemption.RESET();
                ITExemption.SETRANGE("Location Code", IncomeTax."Location Code");
                ITExemption.SETRANGE("Salary Plan Code", IncomeTax."Salary Plan Code");
                ITExemption.SETRANGE("Salary Year Code", IncomeTax."Assessment Year");
                ITExemption.SETRANGE("Employee No.", IncomeTax."Employee No");
                IF ITExemption.FINDFIRST() THEN
                    REPEAT
                        IF ITExemption."Excemption Type" = ITExemption."Excemption Type"::Insurance THEN
                            IncomeTax."Actual - LIC Premium (Direct)" := ITExemption.Amount;

                        IF ITExemption."Excemption Type" = ITExemption."Excemption Type"::"Medical Bill" THEN
                            IncomeTax."Medical Bill" := ITExemption.Amount;

                        IncomeTaxHeader.TESTFIELD("Medical Claim Limit");

                        IF IncomeTax."Medical Bill" > IncomeTaxHeader."Medical Claim Limit" THEN
                            IncomeTax."Medical Bill" := IncomeTaxHeader."Medical Claim Limit";

                        IF ITExemption."Excemption Type" = ITExemption."Excemption Type"::"Loan Principle" THEN
                            IncomeTax."Actual -Housing Loan Principal" := ITExemption.Amount;

                        IF ITExemption."Excemption Type" = ITExemption."Excemption Type"::"Loan Interest" THEN
                            IncomeTax."Housing Loan Interest" := ITExemption.Amount;

                        IF ITExemption."Excemption Type" = ITExemption."Excemption Type"::Donation THEN
                            IncomeTax."Actual - 80G (Donations)" := ITExemption.Amount;

                        //       IF ITExemption."Excemption Type" = ITExemption."Excemption Type"::"Rent Paid" THEN
                        //          IncomeTax."Rent Received" := ITExemption.Amount;

                        IF ITExemption."Excemption Type" = ITExemption."Excemption Type"::"Rent Received" THEN
                            IncomeTax."Rent Received" := ITExemption.Amount;

                        IF ITExemption."Excemption Type" = ITExemption."Excemption Type"::"Transport Conveyance" THEN
                            IncomeTax."Transport Conveyance" := ITExemption.Amount;

                        IncomeTax.MODIFY();

                    UNTIL ITExemption.NEXT() = 0;
            UNTIL IncomeTax.NEXT() = 0;

        //*******************GET IT EXEMPTIONS******************* STOP
    end;


    procedure "Get Income Tax Header"()
    begin
        IncomeTaxHeader.RESET();
        IncomeTaxHeader.SETRANGE("Location Code", LocationCode);
        IncomeTaxHeader.SETRANGE("Salary Plan Code", SalaryPlanCode);
        IncomeTaxHeader.SETRANGE("Assessment Year", AssessmentYear);
        IF NOT IncomeTaxHeader.FIND('-') THEN
            MESSAGE('Income Tax Setup not defined in Income Tax Header ..!!');

        IncomeTaxLine.RESET();
        IncomeTaxLine.SETRANGE("Location Code", LocationCode);
        IncomeTaxLine.SETRANGE("Salary Plan Code", SalaryPlanCode);
        IncomeTaxLine.SETRANGE("Assessment Year", AssessmentYear);
        IF NOT IncomeTaxLine.FIND('-') THEN
            MESSAGE('Income Tax Setup not defined in Income Tax Line ..!!');
    end;


    procedure "Calculate Income Tax"(LLocationCode: Code[20]; LSalaryPlanCode: Code[20]; LAssessmentYear: Code[20]; LEmployeeNo: Code[20])
    var
        Employee: Record Employee;
        IncomeTax: Record "Income Tax";
        IncomeTaxLine1: Record "Income Tax Line";
        Projection: Boolean;
        Proj80DedutionsTotalLimit: Decimal;
        Actu80DedutionsTotalLimit: Decimal;
        IncomeTo: Decimal;
        CondCheck: Boolean;
        DiffAmt: Decimal;

        RecordCount: Integer;
    begin
        //------------------------------//

        LocationCode := LLocationCode;
        SalaryPlanCode := LSalaryPlanCode;
        AssessmentYear := LAssessmentYear;

        "Get Income Tax Header"();

        //----------------------- ------//
        // Initialize all the Variables
        IncomeTax.RESET();
        IncomeTax.SETRANGE("Location Code", LLocationCode);
        IncomeTax.SETRANGE("Salary Plan Code", LSalaryPlanCode);
        IncomeTax.SETRANGE("Assessment Year", LAssessmentYear);
        //IncomeTax.SETRANGE(Verified,           FALSE);

        IF LEmployeeNo <> 'ALL' THEN
            IncomeTax.SETRANGE("Employee No", LEmployeeNo);

        RecordCount := IncomeTax.COUNT;
        CUGeneralFunctions.OpenWindow('Calculating Income Tax \\', 'Progress');

        IF IncomeTax.FIND('-') THEN
            REPEAT

                WITH IncomeTax DO BEGIN

                    //   "Calculate HRA New"(LocationCode,SalaryPlanCode,AssessmentYear,IncomeTax."Employee No");
                    //   HRA :=  CalcHRAAmount;

                    "Salary Gross Earning Total" := 0;
                    "Other Earnings Total" := 0;
                    "Exemptions Totals" := 0;
                    "Gross Salary Income" := 0;
                    "Gross Total Income" := 0;
                    "Actual - Total PF" := 0;
                    "Actual - Total LIC Premium" := 0;
                    "Actual - Total 80 Deduction" := 0;
                    "Actual - Total 80A-Z Deduction" := 0;
                    "Proj - Total PF" := 0;
                    "Proj - Total LIC Premium" := 0;
                    "Proj - Total 80 Deduction" := 0;
                    Proj80DedutionsTotalLimit := 0;
                    Actu80DedutionsTotalLimit := 0;
                    "Taxable Income" := 0;
                    "Income Tax Amount" := 0;
                    "Surcharge Amount" := 0;
                    "Cess Amount" := 0;
                    "Higher Edu Cess Amount" := 0;
                    "Total Tax Amount" := 0;
                    "Tax Balance" := 0;
                    "Tax Per Month" := 0;

                    //--- Salary Earning Calculations

                    "Salary Gross Earning Total" := "Salary Gross Earning Actual" + "Salary Gross Earning Projected";
                    "Salary Gross Earning Total" := ROUND("Salary Gross Earning Total", 1, '=');

                    //--------------------------------//
                    //--- Other Earning Calculations
                    //--------------------------------//

                    "Other Earnings Total" := (Bonus + "Leave Salary" + "Arrears Amount" + "D.A Arrears - 1" +
                                               "D.A Arrears - 2" + "HRA Arrears" + "Hon Amount" + "Medical Reimburement" +
                                               "Previous Job Earnings" + "Perk-1" +
                                               "Perk-2" + "Other Earnings-1" + "Other Earnings-2");

                    //-------------------------------//

                    //--- Exemptions Total Calculations

                    IncomeTaxHeader.TESTFIELD("Max. Conveyance");
                    IF ("Conv.Allowance" > IncomeTaxHeader."Max. Conveyance") THEN BEGIN
                        "Conv.Allowance" := IncomeTaxHeader."Max. Conveyance";
                        MODIFY();
                    END;

                    //   "Exemptions Totals" := (HRA + "Transport Conveyance" + "Medical Bill") ;

                    "Exemptions Totals" := (HRA + "Transport Conveyance");

                    //------------------------------//

                    //--- Gross Salary Income Calculations

                    "Gross Salary Income" := ("Salary Gross Earning Total" + "Other Earnings Total" - "Exemptions Totals") -
                                             ("Professional Tax" + "Entertainment Tax");

                    //------------------------------//
                    //--- Gross Total Income Calculations

                    IncomeTaxHeader.TESTFIELD("Housing Loan Interest Limit");

                    IF ("Housing Loan Interest" > IncomeTaxHeader."Housing Loan Interest Limit") THEN
                        "Housing Loan Interest" := IncomeTaxHeader."Housing Loan Interest Limit";


                    "Gross Total Income" := ("Gross Salary Income" - ("Housing Loan Interest" - "Rent Received"));

                    //--------------------------------//
                    //--- Total 80 Deductions Total Calculations

                    "Actual - Total PF" := ("Actual - PF (Salary)" + "Actual - PF (Direct)");

                    "Actual - Total LIC Premium" := ("Actual - LIC Premium (Salary)" + "Actual - LIC Premium (Direct)");

                    "Actual - Total 80 Deduction" := "Actual - Total PF" + "Actual - Total LIC Premium" +
                                                     "Actual - NSC (Direct)" + "Actual - NSC Interest" +
                                                     "Actual - ULIP" + "Actual - NSS Self" +
                                                     "Actual - Mutal Fund" + "Actual -Housing Loan Principal" +
                                                     "Actual -Infra Development Bond" + "Actual -Other 80 Deduction - 1" +
                                                     "Actual -Other 80 Deduction - 2";

                    "Actual - Total 80A-Z Deduction" := "Actual - 80CCC (Pension Fund)" + "Actual - 80DD(Handicapped Dep)" +
                                                        "Actual - 80D (Mediclaim)" + "Actual - 80DDB(Medical Ex Spl)" +
                                                        "Actual - 80G (Donations)" + "Actual - 80U(Physically Handi)" +
                                                        "Actu -  80E (Educational Loan)";

                    //--------------------------------//

                    "Proj - Total PF" := ("Proj - PF (Salary)" + "Proj - PF (Direct)");

                    "Proj - Total LIC Premium" := ("Proj - LIC Premium (Salary)" + "Proj - LIC Premium (Direct)");

                    "Proj - Total 80 Deduction" := "Proj - Total PF" + "Proj - Total LIC Premium" +
                                                   "Proj - NSC (Direct)" + "Proj - NSC Interest" +
                                                   "Proj - ULIP" + "Proj - NSS Self" +
                                                   "Proj - Mutal Fund" + "Proj - Housing Loan Principal" +
                                                   "Proj - Infra Development Bond" + "Proj - Other 80 Deduction - 1" +
                                                   "Proj - Other 80 Deduction - 2";

                    "Proj - Total 80A-Z Deduction" := "Proj - 80CCC (Pension Fund)" + "Proj - 80DD(Handicapped Dep)" +
                                                      "Proj - 80D (Mediclaim)" + "Proj - 80DDB(Medical Ex Spl)" +
                                                      "Proj - 80G (Donations)" + "Proj - 80U(Physically Handi)" +
                                                      "Proj -  80E (Educational Loan)";

                    //-------------------------------//

                    Proj80DedutionsTotalLimit := ("Proj - Total 80 Deduction" + "Proj - Total 80A-Z Deduction");
                    Actu80DedutionsTotalLimit := ("Actual - Total 80 Deduction" + "Actual - Total 80A-Z Deduction");

                    IF ("Actual - 80D (Mediclaim)" > IncomeTaxHeader."Medical Claim Limit") THEN BEGIN
                        Actu80DedutionsTotalLimit -= "Actual - 80D (Mediclaim)";
                        Actu80DedutionsTotalLimit += IncomeTaxHeader."Medical Claim Limit";
                        IncomeTaxHeader."Tax Deduction Limit" += IncomeTaxHeader."Medical Claim Limit";
                    END;

                    IF "Physically Handicapped" THEN
                        IF ("Actual - 80U(Physically Handi)" > IncomeTaxHeader."Physically Handicapped Limit") THEN BEGIN
                            Actu80DedutionsTotalLimit -= "Actual - 80U(Physically Handi)";
                            Actu80DedutionsTotalLimit += IncomeTaxHeader."Physically Handicapped Limit";
                            IncomeTaxHeader."Tax Deduction Limit" += IncomeTaxHeader."Physically Handicapped Limit";
                        END;


                    IF ("Proj - 80D (Mediclaim)" > IncomeTaxHeader."Medical Claim Limit") THEN BEGIN
                        Proj80DedutionsTotalLimit -= "Proj - 80D (Mediclaim)";
                        Proj80DedutionsTotalLimit += IncomeTaxHeader."Medical Claim Limit";
                        IncomeTaxHeader."Tax Deduction Limit" += IncomeTaxHeader."Medical Claim Limit";
                    END;

                    IF "Physically Handicapped" THEN
                        IF ("Proj - 80U(Physically Handi)" > IncomeTaxHeader."Physically Handicapped Limit") THEN BEGIN
                            Proj80DedutionsTotalLimit -= "Proj - 80U(Physically Handi)";
                            Proj80DedutionsTotalLimit += IncomeTaxHeader."Physically Handicapped Limit";
                            IncomeTaxHeader."Tax Deduction Limit" += IncomeTaxHeader."Physically Handicapped Limit";
                        END;


                    IF (Proj80DedutionsTotalLimit > IncomeTaxHeader."Tax Deduction Limit") THEN
                        Proj80DedutionsTotalLimit := IncomeTaxHeader."Tax Deduction Limit";

                    //-- Added Donation.
                    IF (Actu80DedutionsTotalLimit > IncomeTaxHeader."Tax Deduction Limit") THEN BEGIN
                        Actu80DedutionsTotalLimit := IncomeTaxHeader."Tax Deduction Limit";
                        Actu80DedutionsTotalLimit := Actu80DedutionsTotalLimit + "Actual - 80G (Donations)";
                    END;

                    IF Projection THEN
                        "Taxable Income" := ("Gross Total Income" - Proj80DedutionsTotalLimit)
                    ELSE
                        "Taxable Income" := ("Gross Total Income" - Actu80DedutionsTotalLimit);

                    IF "Taxable Income" < 0 THEN
                        "Taxable Income" := 0;

                    //-----------Male Tax Calculations. -------//

                    Employee.GET(IncomeTax."Employee No");

                    IF Employee.Gender = Employee.Gender::Male THEN BEGIN
                        IncomeTax.Sex := IncomeTax.Sex::Male;
                        TaxGender := TaxGender::Male;
                    END;

                    IF Employee.Gender = Employee.Gender::Female THEN BEGIN
                        IncomeTax.Sex := IncomeTax.Sex::Female;
                        TaxGender := TaxGender::Female;
                    END;

                    IF "Senior Citizen" THEN
                        TaxGender := TaxGender::"Sr.Citizen";

                    IncomeTo := 0;
                    CondCheck := FALSE;

                    IncomeTaxLine1.RESET();
                    IncomeTaxLine1.SETRANGE("Location Code", LLocationCode);
                    IncomeTaxLine1.SETRANGE("Salary Plan Code", LSalaryPlanCode);
                    IncomeTaxLine1.SETRANGE("Assessment Year", LAssessmentYear);
                    IncomeTaxLine1.SETRANGE(IncomeTaxLine1.Gender, TaxGender);
                    IF IncomeTaxLine1.FINDFIRST() THEN
                        REPEAT

                            DiffAmt := 0;

                            IF ("Taxable Income" >= IncomeTaxLine1."Income From") AND
                               ("Taxable Income" <= IncomeTaxLine1."Income To") THEN BEGIN
                                IncomeTaxLine1."Income To" := "Taxable Income";
                                CondCheck := TRUE;
                            END;

                            DiffAmt := (IncomeTaxLine1."Income To" - IncomeTo);

                            //     MESSAGE('From => %1 To => %2 Taxable Income => %3 Diff => %4',IncomeTaxLine1."Income From",
                            //                                  IncomeTaxLine1."Income To","Taxable Income",DiffAmt );

                            "Income Tax Amount" += (DiffAmt * IncomeTaxLine1."Tax %" / 100);

                            "Surcharge Amount" += ROUND((("Income Tax Amount" * IncomeTaxLine1."Surcharge %") / 100), 1, '=');

                            IncomeTo := IncomeTaxLine1."Income To";

                        UNTIL (IncomeTaxLine1.NEXT() = 0) OR CondCheck;


                    "Income Tax Amount" := ROUND("Income Tax Amount", 1, '=');

                    //-----------------------------------------//
                    //-----------Cess Amount Calculations. ----//

                    "Cess Amount" := ROUND(((("Income Tax Amount" + "Surcharge Amount") * IncomeTaxLine1."E-CESS %") / 100), 1, '=');

                    //-----------------------------------------//

                    //-----------Higher Edu Cess Amount Calculations. ---//

                    "Higher Edu Cess Amount" := ROUND((("Income Tax Amount" + "Surcharge Amount") * IncomeTaxLine1."SHE-CESS %" / 100), 1, '=');

                    //---------------------------------------------------//

                    //-----------Total Tax Amount Calculations. ---------//

                    "Total Tax Amount" := ("Income Tax Amount" + "Surcharge Amount" + "Cess Amount" + "Higher Edu Cess Amount");

                    //--------------------------------------------------//

                    //----------- Tax Balance Calculations. ------------//

                    "Tax Balance" := ("Total Tax Amount" - ("Tax Paid" + "Tax Refund"));

                    //--------------------------------------------------//

                    //----------- Tax Per Month Calculations. ----------//
                    IF "Remaining Month for Projection" <> 0 THEN
                        "Tax Per Month" := ROUND(("Tax Balance" / ("Remaining Month for Projection" + 1)), 1, '=');

                    //--------------------------------------------------//
                    IF ("Salary Gross Earning Total" = 0) THEN BEGIN
                        "Income Tax Amount" := 0;
                        "Cess Amount" := 0;
                        "Higher Edu Cess Amount" := 0;
                        "Surcharge Amount" := 0;
                        "Total Tax Amount" := 0;
                        "Tax Balance" := 0;
                        "Tax Per Month" := 0;
                    END;
                    MODIFY();
                END;

                CUGeneralFunctions.UpdateWindow(IncomeTax."Employee No", IncomeTax.COUNT);
            UNTIL IncomeTax.NEXT() = 0;

        CUGeneralFunctions.CloseWindow();
    end;

    procedure "Calculate HRA New"(LLocationCode: Code[20]; LSalaryPlanCode: Code[20]; LAssessmentYear: Code[20]; LEmployeeNo: Code[20])
    var
        PayrollYear: Record "Payroll Year";
        ProcessedSalary: Record "Processed Salary";
        Employee: Record Employee;
        ITExemption: Record "Income Tax Exemptions";
    begin
        CLEAR(TotalBasicDAAmount);
        CLEAR(TotalHRAAmount);
        CLEAR(TotalRentPaid);
        CLEAR(CalcHRAAmount);

        LocationCode := LLocationCode;
        SalaryPlanCode := LSalaryPlanCode;
        AssessmentYear := LAssessmentYear;
        EmployeeNo := LEmployeeNo;

        "Get Income Tax Header"();

        Employee.GET(EmployeeNo);

        PayrollYear.RESET();
        PayrollYear.SETRANGE("Location Code", LocationCode);
        PayrollYear.SETRANGE("Salary Plan Code", SalaryPlanCode);
        PayrollYear.SETRANGE("Year Code", AssessmentYear);
        PayrollYear.SETRANGE("Year Type", PayrollYear."Year Type"::"Income Tax Year");
        IF PayrollYear.FINDFIRST() THEN BEGIN
            ProcessedSalary.RESET();
            ProcessedSalary.SETRANGE("Location Code", PayrollYear."Location Code");
            ProcessedSalary.SETRANGE("Salary Plan Code", PayrollYear."Salary Plan Code");
            ProcessedSalary.SETRANGE("Employee No", EmployeeNo);
            ProcessedSalary.SETRANGE("Payroll Start Date", PayrollYear."Year Start Date", PayrollYear."Year End Date");
            ProcessedSalary.SETRANGE("Pay Type", ProcessedSalary."Pay Type"::Addition);
            IF ProcessedSalary.FINDFIRST() THEN
                REPEAT
                    IF ProcessedSalary."Pay Element Code" IN ['BASIC', 'DA'] THEN
                        TotalBasicDAAmount += ProcessedSalary."Payable Amount";

                    IF ProcessedSalary."Pay Element Code" IN ['HRA'] THEN
                        TotalHRAAmount += ProcessedSalary."Payable Amount";

                UNTIL ProcessedSalary.NEXT() = 0;
        END;

        ITExemption.RESET();
        ITExemption.SETRANGE("Location Code", LocationCode);
        ITExemption.SETRANGE("Salary Plan Code", SalaryPlanCode);
        ITExemption.SETRANGE("Salary Year Code", AssessmentYear);
        ITExemption.SETRANGE("Employee No.", EmployeeNo);
        ITExemption.SETRANGE("Excemption Type", ITExemption."Excemption Type"::"Rent Paid");
        IF ITExemption.FINDFIRST() THEN
            TotalRentPaid := ITExemption.Amount;

        TotalRentPaid := TotalRentPaid - (TotalBasicDAAmount * 10 / 100);

        IncomeTaxHeader.TESTFIELD("Metro %");
        IncomeTaxHeader.TESTFIELD("Non Metro %");

        IF Employee."Metro / Non Metro" = Employee."Metro / Non Metro"::Metro THEN
            TotalBasicDAAmount := (TotalBasicDAAmount * IncomeTaxHeader."Metro %") / 100;

        IF Employee."Metro / Non Metro" = Employee."Metro / Non Metro"::"Non Metro" THEN
            TotalBasicDAAmount := (TotalBasicDAAmount * IncomeTaxHeader."Non Metro %") / 100;

        CalcHRAAmount := TotalBasicDAAmount;
        IF CalcHRAAmount > TotalHRAAmount THEN
            CalcHRAAmount := TotalHRAAmount
        ELSE
            IF CalcHRAAmount > TotalRentPaid THEN
                CalcHRAAmount := TotalRentPaid;

        IF CalcHRAAmount < 0 THEN
            CalcHRAAmount := 0;
        /*
        MESSAGE('%1', TotalBasicDAAmount);
        MESSAGE('%1', TotalHRAAmount);
        MESSAGE('%1', TotalRentPaid);
        MESSAGE('%1', CalcHRAAmount);
        */

    end;
}

