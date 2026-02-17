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
}

