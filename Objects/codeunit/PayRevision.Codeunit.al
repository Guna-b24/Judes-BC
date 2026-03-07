codeunit 72006 "Pay Revision"
{
    trigger OnRun()
    begin
    end;

    procedure "Process Monthly Salary"(PayRevisionID: Code[20]; EffectiveDate: Date; EmployeeNo: Code[20]; NewEffectiveDate: Date) Status: Boolean
    var
        Employee: Record Employee;
    begin
        Employee.Reset();
        Employee.SetRange(Status, Employee.Status::Active);
        if Employee.FindFirst() then
            repeat
                "Read Pay Employee Elements"(PayRevisionID, Today, Employee."No.", NewEffectiveDate);
            until Employee.Next() = 0;
    end;

    procedure "Read Pay Employee Elements"(PayRevisionID: Code[20]; LPayrollDate: Date; LEmployeeNo: Code[20]; NewEffectiveDate: Date)
    var
        Employee: Record Employee;
        EmployeePayElements: Record "Employee Pay Elements";
        RevisionLine: Record "Revision Line";
        LastEffectiveDate: Date;
    begin
        EmployeePayElements.Reset();
        EmployeePayElements.SetRange("Employee No", LEmployeeNo);
        if EmployeePayElements.FindLast() then
            LastEffectiveDate := EmployeePayElements."Effective Date";

        EmployeePayElements.Reset();
        EmployeePayElements.SetRange("Employee No", LEmployeeNo);
        EmployeePayElements.SetRange("Effective Date", LastEffectiveDate);
        if EmployeePayElements.FindFirst() then
            repeat
                RevisionLine."Pay Revision Id" := PayRevisionID;
                RevisionLine."Location Code" := EmployeePayElements."Location Code";
                RevisionLine."Salary Plan Code" := EmployeePayElements."Salary Plan Code";
                RevisionLine."Last Effective Date" := EmployeePayElements."Effective Date";
                RevisionLine."Pay Element Code" := EmployeePayElements."Pay Element Code";
                RevisionLine.Description := EmployeePayElements.Description;
                RevisionLine."Employee No" := EmployeePayElements."Employee No";
                RevisionLine."Pay Type" := EmployeePayElements."Pay Type";
                if Employee.Get(RevisionLine."Employee No") then begin
                    RevisionLine.Name := Employee."First Name" + ' ' + Employee.Initials;
                    RevisionLine."Old Grade Code" := Employee."Grade Code";
                end;

                RevisionLine."Fixed/Percent" := EmployeePayElements."Fixed/Percent";
                RevisionLine."Amount Calculation Type" := EmployeePayElements."Amount Calculation Type";
                RevisionLine."Base Pay Elements" := EmployeePayElements."Base Pay Elements";
                RevisionLine."Last Drawn Amount" := EmployeePayElements.Amount;
                RevisionLine."Last Drawn Percent (%)" := EmployeePayElements."Percent (%)";
                RevisionLine."Sorting Order" := EmployeePayElements."Sorting Order";
                RevisionLine."New Effective Date" := NewEffectiveDate;
                RevisionLine."Excluded In Pay Slip" := EmployeePayElements."Excluded In Pay Slip";
                RevisionLine."Employee Category" := Employee."Employee Category";
                if not RevisionLine.Insert() then;

            until EmployeePayElements.Next() = 0;
    end;


    procedure "Process VDA Revision"(PayRevisionID: Code[20]; EffectiveDate: Date; EmployeeNo: Code[20]; NewEffectiveDate: Date; VDAMaxRange: Decimal) Status: Boolean
    var
        Employee: Record Employee;
    begin
        Employee.Reset();
        Employee.SetRange("Employee Category", Employee."Employee Category"::"Class IV Permanent");
        Employee.SetRange(Status, Employee.Status::Active);
        if Employee.FindFirst() then
            repeat
                "Read Daily Wages Elements"(PayRevisionID, Today, Employee."No.", NewEffectiveDate, VDAMaxRange);
            until Employee.Next() = 0;
    end;


    procedure "Read Daily Wages Elements"(PayRevisionID: Code[20]; LPayrollDate: Date; LEmployeeNo: Code[20]; NewEffectiveDate: Date; VDAMaxRange: Decimal)
    var
        Employee: Record Employee;
        EmployeePayElements: Record "Employee Pay Elements";
        RevisionLine: Record "Revision Line";
        LastEffectiveDate: Date;
    begin
        EmployeePayElements.Reset();
        EmployeePayElements.SetRange("Employee No", LEmployeeNo);
        if EmployeePayElements.FindLast() then
            LastEffectiveDate := EmployeePayElements."Effective Date";

        EmployeePayElements.Reset();
        EmployeePayElements.SetRange("Employee No", LEmployeeNo);
        EmployeePayElements.SetRange("Effective Date", LastEffectiveDate);
        EmployeePayElements.SetFilter(Amount, '<=%1', VDAMaxRange);
        if EmployeePayElements.FindFirst() then
            repeat
                RevisionLine."Pay Revision Id" := PayRevisionID;
                RevisionLine."Location Code" := EmployeePayElements."Location Code";
                RevisionLine."Salary Plan Code" := EmployeePayElements."Salary Plan Code";
                RevisionLine."Last Effective Date" := EmployeePayElements."Effective Date";
                RevisionLine."Pay Element Code" := EmployeePayElements."Pay Element Code";
                RevisionLine.Description := EmployeePayElements.Description;
                RevisionLine."Employee No" := EmployeePayElements."Employee No";
                RevisionLine."Pay Type" := EmployeePayElements."Pay Type";

                if Employee.Get(RevisionLine."Employee No") then begin
                    RevisionLine.Name := Employee."First Name" + ' ' + Employee.Initials;
                    RevisionLine."Old Grade Code" := Employee."Grade Code";
                end;

                RevisionLine."Fixed/Percent" := EmployeePayElements."Fixed/Percent";
                RevisionLine."Amount Calculation Type" := EmployeePayElements."Amount Calculation Type";
                RevisionLine."Base Pay Elements" := EmployeePayElements."Base Pay Elements";
                RevisionLine."Last Drawn Amount" := EmployeePayElements.Amount;
                RevisionLine."Last Drawn Percent (%)" := EmployeePayElements."Percent (%)";
                RevisionLine."Sorting Order" := EmployeePayElements."Sorting Order";
                RevisionLine."New Effective Date" := NewEffectiveDate;
                RevisionLine."Excluded In Pay Slip" := EmployeePayElements."Excluded In Pay Slip";
                RevisionLine."Employee Category" := Employee."Employee Category";

                if not RevisionLine.Insert() then;

            until EmployeePayElements.Next() = 0;
    end;


    //Revision card page action code
    procedure UpdateRevisionLines(RevisionHeader: Record "Revision Header")
    var
        RevisionLine: Record "Revision Line";
    begin
        RevisionLine.Reset();
        RevisionLine.SetRange("Pay Revision Id", RevisionHeader."Pay Revision Id");
        RevisionLine.SetRange(Posted, false);

        if RevisionLine.FindSet() then
            repeat

                if RevisionHeader."New Effective Date" <> 0D then
                    RevisionLine."New Effective Date" := RevisionHeader."New Effective Date";

                if RevisionHeader."Based on" = RevisionHeader."Based on"::Amount then
                    if RevisionLine."Fixed/Percent" = RevisionLine."Fixed/Percent"::Fixed then
                        RevisionLine."Revised Amount" :=
                            RevisionLine."Last Drawn Amount" + RevisionHeader."Revision Amount";


                if RevisionHeader."Based on" = RevisionHeader."Based on"::Percent then
                    if RevisionLine."Fixed/Percent" = RevisionLine."Fixed/Percent"::Fixed then
                        RevisionLine."Revised Amount" :=
                            RevisionLine."Last Drawn Amount" +
                            (RevisionLine."Last Drawn Amount" * RevisionHeader."Revision Percent" / 100);


                RevisionLine."Pay Revised" := true;

                RevisionLine.Validate("Revised Amount");
                RevisionLine.Modify();

            until RevisionLine.Next() = 0;
    end;

    procedure ProcessArrears(RevisionHeader: Record "Revision Header")
    var
        RevisionLine: Record "Revision Line";
        ProcessedSalary: Record "Processed Salary";
        ArrearsHeader: Record "Arrears Header";
        ArrearsHeaderLine: Record "Arrears Header Line";
        ArrearsLine: Record "Arrears Line";
        Employee: Record Employee;
        LineNo: Integer;
    begin
        Message('Please Check Salary Processed for the periods');

        LineNo := 0;

        // Insert Arrears Header once
        if not ArrearsHeader.Get(RevisionHeader."Pay Revision Id") then begin
            ArrearsHeader.Init();
            ArrearsHeader."Arrears Id" := RevisionHeader."Pay Revision Id";
            ArrearsHeader."Arrears Process Date" := Today;
            ArrearsHeader."Location Code" := RevisionHeader."Location Code";
            ArrearsHeader."Salary Plan Code" := RevisionHeader."Salary Plan Code";
            ArrearsHeader."Pay Revision Id" := RevisionHeader."Pay Revision Id";
            ArrearsHeader.Insert();
        end;

        // Loop Revision Lines
        RevisionLine.Reset();
        RevisionLine.SetRange("Pay Revision Id", RevisionHeader."Pay Revision Id");
        RevisionLine.SetRange("Location Code", RevisionHeader."Location Code");
        RevisionLine.SetRange("Salary Plan Code", RevisionHeader."Salary Plan Code");

        if RevisionLine.FindSet() then
            repeat
                // Find Processed Salary
                ProcessedSalary.Reset();
                ProcessedSalary.SetRange("Location Code", RevisionLine."Location Code");
                ProcessedSalary.SetRange("Salary Plan Code", RevisionLine."Salary Plan Code");
                ProcessedSalary.SetRange("Employee No", RevisionLine."Employee No");
                ProcessedSalary.SetRange("Payroll End Date", RevisionHeader."Arrears Starting Date", RevisionHeader."Arrears Ending Date");
                ProcessedSalary.SetRange("Pay Element Code", RevisionLine."Pay Element Code");

                if ProcessedSalary.FindSet() then
                    repeat
                        // Insert Arrears Header Line
                        if not ArrearsHeaderLine.Get(RevisionHeader."Pay Revision Id", ProcessedSalary."Employee No") then begin
                            ArrearsHeaderLine.Init();
                            ArrearsHeaderLine."Arrears Id" := RevisionHeader."Pay Revision Id";
                            ArrearsHeaderLine."Location Code" := RevisionHeader."Location Code";
                            ArrearsHeaderLine."Salary Plan Code" := RevisionHeader."Salary Plan Code";
                            ArrearsHeaderLine."Employee No" := ProcessedSalary."Employee No";
                            if Employee.Get(ProcessedSalary."Employee No") then
                                ArrearsHeaderLine.Name := Employee."First Name";
                            ArrearsHeaderLine.Insert();
                        end;

                        // Insert Arrears Line
                        LineNo += 10000;
                        ArrearsLine.Init();
                        ArrearsLine."Arrears Id" := ArrearsHeader."Arrears Id";
                        ArrearsLine."Line No." := LineNo;
                        ArrearsLine."Location Code" := ProcessedSalary."Location Code";
                        ArrearsLine."Salary Plan Code" := ProcessedSalary."Salary Plan Code";
                        ArrearsLine."Salary Cycle Code" := ProcessedSalary."Salary Cycle Code";
                        ArrearsLine."Payroll Start Date" := ProcessedSalary."Payroll Start Date";
                        ArrearsLine."Payroll End Date" := ProcessedSalary."Payroll End Date";
                        ArrearsLine.Year := ProcessedSalary.Year;
                        ArrearsLine.Month := ProcessedSalary.Month;
                        ArrearsLine."Employee No" := ProcessedSalary."Employee No";
                        ArrearsLine."Pay Element Code" := ProcessedSalary."Pay Element Code";
                        ArrearsLine."Sorting Order" := ProcessedSalary."Sorting Order";
                        ArrearsLine."Total Days in a Month" := ProcessedSalary."Total Days in a Month";
                        ArrearsLine."Paid Days" := ProcessedSalary."Paid Days";
                        ArrearsLine."Actual Amount" := ProcessedSalary."Actual Amount";
                        ArrearsLine."Payable Amount" := ProcessedSalary."Payable Amount";
                        ArrearsLine."Fixed/Percent" := ProcessedSalary."Fixed / Percent";

                        // Difference Value
                        if RevisionLine."Fixed/Percent" = RevisionLine."Fixed/Percent"::Fixed then
                            ArrearsLine."Difference Amount / Percent(%)" := RevisionLine."Difference Amount"
                        else
                            ArrearsLine."Difference Amount / Percent(%)" := RevisionLine."Difference Percent (%)";

                        // Arrear Calculation
                        if ArrearsLine."Fixed/Percent" = ArrearsLine."Fixed/Percent"::Fixed then begin
                            if ArrearsLine."Total Days in a Month" = ArrearsLine."Paid Days" then
                                ArrearsLine."Arrear Amount" := ArrearsLine."Difference Amount / Percent(%)"
                            else
                                ArrearsLine."Arrear Amount" := ROUND(
                                    (ArrearsLine."Difference Amount / Percent(%)" / ArrearsLine."Total Days in a Month") *
                                    ArrearsLine."Paid Days",
                                    0.01, '='
                                );
                        end else begin
                            ArrearsLine."Arrear Amount" :=
                                (ArrearsLine."Difference Amount / Percent(%)" / 100) *
                                ArrearsLine."Actual Amount";
                            ArrearsLine."Arrear Amount" :=
                                (ArrearsLine."Arrear Amount" / ArrearsLine."Total Days in a Month") *
                                ArrearsLine."Paid Days";
                        end;

                        ArrearsLine.Insert();

                    until ProcessedSalary.Next() = 0;

            until RevisionLine.Next() = 0;

        // Mark Arrears Generated
        RevisionHeader."Arrears Generated" := true;
        RevisionHeader.Modify();

        Message('Arrears Amount Updated Successfully..!!');
    end;

    procedure PostRevision(RevisionHeader: Record "Revision Header")
    var
        RevisionLine: Record "Revision Line";
        EmployeePayElements: Record "Employee Pay Elements";
    begin
        if not Confirm('Are you sure to Transfer to Employee Pay Elements?', false) then
            exit;

        // Filter Revision Lines
        RevisionLine.Reset();
        RevisionLine.SetRange("Pay Revision Id", RevisionHeader."Pay Revision Id");
        RevisionLine.SetRange("Location Code", RevisionHeader."Location Code");
        RevisionLine.SetRange("Salary Plan Code", RevisionHeader."Salary Plan Code");
        RevisionLine.SetRange(Posted, false);
        RevisionLine.SetFilter("Revised Amount", '<>%1', 0);

        if RevisionLine.FindSet() then begin
            repeat
                // Transfer to Employee Pay Elements
                EmployeePayElements.Init();
                EmployeePayElements."Location Code" := RevisionLine."Location Code";
                EmployeePayElements."Salary Plan Code" := RevisionLine."Salary Plan Code";
                EmployeePayElements."Effective Date" := RevisionLine."New Effective Date";
                EmployeePayElements."Pay Element Code" := RevisionLine."Pay Element Code";
                EmployeePayElements."Employee No" := RevisionLine."Employee No";
                EmployeePayElements.Description := RevisionLine.Description;
                EmployeePayElements."Pay Type" := RevisionLine."Pay Type";
                EmployeePayElements."Fixed/Percent" := RevisionLine."Fixed/Percent";
                EmployeePayElements."Amount Calculation Type" := RevisionLine."Amount Calculation Type";
                EmployeePayElements."Base Pay Elements" := RevisionLine."Base Pay Elements";
                EmployeePayElements.Amount := RevisionLine."Revised Amount";
                EmployeePayElements."Percent (%)" := RevisionLine."Revised Percent (%)";
                EmployeePayElements."Sorting Order" := RevisionLine."Sorting Order";
                EmployeePayElements."Excluded In Pay Slip" := RevisionLine."Excluded In Pay Slip";

                EmployeePayElements.Insert();

                // Mark Revision Line as Posted
                RevisionLine.Posted := true;
                RevisionLine."Posted Date" := Today;
                RevisionLine.Modify();

            until RevisionLine.Next() = 0;

            Message('Pay Revision Completed & Transferred..!!');
        end else
            Error('Pay Revision Already Transferred..!!');
    end;

}


