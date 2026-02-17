codeunit 72004 "Leave Creation"
{
    trigger OnRun()
    begin
        HRPayrollSetup.Get(UserId);

        LocationCode := HRPayrollSetup."Location Code";
        SalaryPlanCode := HRPayrollSetup."Salary Plan Code";
        YearCode := HRPayrollSetup."Salary Year Code";

        PayrollYear.Reset();
        PayrollYear.SetRange("Location Code", LocationCode);
        PayrollYear.SetRange("Salary Plan Code", SalaryPlanCode);
        PayrollYear.SetRange("Year Code", YearCode);
        PayrollYear.SetRange("Year Type", PayrollYear."Year Type"::"Leave Year");
        PayrollYear.SetRange(Closed, false);

        if PayrollYear.Count > 1 then
            Error('Closed the Last Leave Year and proceed..!!');

        if PayrollYear.Find('-') then begin
            Message('Leave Year \\Start Date => %1 \\End Date => %2', PayrollYear."Year Start Date", PayrollYear."Year End Date");

            if not Confirm('Do you want Leave Records for the Year', false) then
                exit;

            StartDateTime := CurrentDateTime;

            Employee1.Reset();
            Employee1.SetRange("Location Code", LocationCode);
            Employee1.SetRange("Salary Plan Code", SalaryPlanCode);
            Employee1.SetRange(Status, Employee1.Status::Active);
            Employee1.SetRange("Leave Generated", false);
            if Employee1.FindFirst() then begin
                repeat

                    "Create Leave Entitlement"(PayrollYear);
                    "Leave Balance Update"();

                until Employee1.Next() = 0;
            end;

            EndDateTime := CurrentDateTime;
            ElaspedTime := EndDateTime - StartDateTime;

            Message('Leave Records Creation Completed \\ Starting Date & Time => %1 \\ Ending Date & Time => %2 \\ Time Elasped => %3',
                     StartDateTime, EndDateTime, ElaspedTime);

            PayrollYear.Created := true;
            PayrollYear.Modify();
        end
        else
            Error('Leave Records Already Generated..!!');
    end;

    var
        Win001: Label 'Table Name :  #1######################## \\ Processing Date :  #2########\\ Status => @3@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        HRPayrollSetup: Record "HR & Payroll Setup";
        PayrollYear: Record "Payroll Year";
        EmployeeLeaveAttachment: Record "Employee Leave Attachment";
        Employee1: Record Employee;
        CUGeneralFunctions: Codeunit "General Functions";
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        ElaspedTime: Duration;
        ProcessStartDate: Date;
        ProcessEndDate: Date;
        LocationCode: Code[20];
        SalaryPlanCode: Code[20];
        YearCode: Code[20];


    procedure "Create Leave Entitlement"(PayrollYear: Record "Payroll Year") Status: Boolean
    var
        DialogWindow: Dialog;
        CurrentRecord: Integer;
        RecordCount: Integer;
        RecordCnt: Integer;
        LeaveMaster: Record "Leave Master";
        LeaveEntitlement: Record "Leave Entitlement";
        Employee: Record Employee;
    begin
        EmployeeLeaveAttachment.Reset;
        EmployeeLeaveAttachment.SetRange("Location Code", LocationCode);
        EmployeeLeaveAttachment.SetRange("Salary Plan Code", SalaryPlanCode);
        EmployeeLeaveAttachment.SetRange("Employee No", Employee1."No.");
        if not EmployeeLeaveAttachment.Find('-') then
            exit;

        EmployeeLeaveAttachment.Reset;
        EmployeeLeaveAttachment.SetRange("Location Code", LocationCode);
        EmployeeLeaveAttachment.SetRange("Salary Plan Code", SalaryPlanCode);
        EmployeeLeaveAttachment.SetRange("Employee No", Employee1."No.");
        if EmployeeLeaveAttachment.Find('-') then
            RecordCount := EmployeeLeaveAttachment.Count;
        CUGeneralFunctions.OpenWindow('Leave Records Creation\\', 'Progress');
        repeat
            if LeaveMaster.Get(EmployeeLeaveAttachment."Leave Code", LocationCode, SalaryPlanCode) then
                LeaveMaster.TestField("Credit Interval Regular");

            LeaveEntitlement.Init;
            LeaveEntitlement."Location Code" := LocationCode;
            LeaveEntitlement."Salary Plan Code" := SalaryPlanCode;
            LeaveEntitlement."Leave Year Code" := PayrollYear."Year Code";
            LeaveEntitlement."Employee No" := Employee1."No.";
            LeaveEntitlement.Name := Employee1."First Name";
            LeaveEntitlement.Probationary := Employee1.Probationary;
            LeaveEntitlement."Leave Code" := LeaveMaster."Leave Code";

            if LeaveEntitlement.Insert then;

            "Create Leave Credited"(PayrollYear, LeaveMaster, Employee);

            Employee1."Leave Generated" := true;
            Employee1.Modify;

            CUGeneralFunctions.UpdateWindow(Employee1."No.", RecordCount);

        until EmployeeLeaveAttachment.Next = 0;

        Message('Leave Record Created Successfully');

        CUGeneralFunctions.CloseWindow();

        Status := true;
    end;


    procedure "Create Leave Credited"(PayrollYear: Record "Payroll Year"; LeaveMaster: Record "Leave Master"; Employee: Record Employee)
    var
        LeaveCredited: Record "Leave Credited";
        LeaveCredited1: Record "Leave Credited";
    begin
        repeat
            LeaveCredited1.SetRange("Location Code", LocationCode);
            LeaveCredited1.SetRange("Salary Plan Code", SalaryPlanCode);
            LeaveCredited1.SetRange("Employee No", Employee1."No.");
            LeaveCredited1.SetRange("Leave Code", LeaveMaster."Leave Code");
            LeaveCredited1.SetRange("Leave Year Code", PayrollYear."Year Code");
            if LeaveCredited1.Find('-') then
                LeaveCredited1.DeleteAll;

            LeaveCredited.Init;
            LeaveCredited."Location Code" := LocationCode;
            LeaveCredited."Salary Plan Code" := SalaryPlanCode;
            LeaveCredited."Employee No" := Employee1."No.";
            LeaveCredited."Leave Code" := LeaveMaster."Leave Code";
            LeaveCredited."Leave Year Code" := PayrollYear."Year Code";
            LeaveCredited."Leave Start Date" := PayrollYear."Year Start Date";

            if Employee1.Probationary = false then
                LeaveCredited."Leave End Date" := CalcDate(Format(LeaveMaster."Credit Interval Prob.") + '-1D',
                                                    LeaveCredited."Leave Start Date");

            if Employee1.Probationary = true then
                LeaveCredited."Leave End Date" := CalcDate(Format(LeaveMaster."Credit Interval Regular") + '-1D',
                                                    LeaveCredited."Leave Start Date");
            if Employee1.Probationary = false then
                LeaveCredited."No. of Leaves" := LeaveMaster."Total Leaves in a Year Regular"
            else
                LeaveCredited."No. of Leaves" := LeaveMaster."Total Leaves in a Year Prob.";

            if LeaveMaster."Create Leave Balance" then begin
                if LeaveCredited."Leave Start Date" < Employee1."Employment Date" then
                    LeaveCredited."No. of Leaves" := 0;
            end;

            if LeaveCredited.Insert then;

            PayrollYear."Year Start Date" := CalcDate(LeaveMaster."Credit Interval Regular", PayrollYear."Year Start Date");

        until PayrollYear."Year Start Date" >= PayrollYear."Year End Date";
    end;


    procedure "Leave Balance Update"()
    var
        LeaveEntitlement1: Record "Leave Entitlement";
    begin
        LeaveEntitlement1.Reset;
        LeaveEntitlement1.SetRange("Location Code", LocationCode);
        LeaveEntitlement1.SetRange("Salary Plan Code", SalaryPlanCode);
        LeaveEntitlement1.SetRange("Leave Year Code", YearCode);
        LeaveEntitlement1.SetRange("Employee No", Employee1."No.");
        if LeaveEntitlement1.FindFirst then begin
            repeat
                LeaveEntitlement1.Validate("Leave Opening Balance");
                LeaveEntitlement1.Modify;
            until LeaveEntitlement1.Next = 0;
        end;
    end;
}

