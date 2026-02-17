codeunit 72003 "Loan Calculation"
{
    trigger OnRun()
    begin
    end;

    var
        EmployeeLoanDetails: Record "Employee Loan Details";
        PaymentDate: Date;

    procedure LoanInstallments(EmployeeLoan: Record "Employee Loan")
    begin
        if EmployeeLoan."Loan Type" = 0 then
            Message('Select any one of the Loan Type in Option')
        else begin
            if EmployeeLoan."Loan Type" = EmployeeLoan."Loan Type"::"Interest Free" then
                InterestFree(EmployeeLoan);
            if EmployeeLoan."Loan Type" = EmployeeLoan."Loan Type"::"Flat Rate" then
                FlatRate(EmployeeLoan);
            if EmployeeLoan."Loan Type" = EmployeeLoan."Loan Type"::"Dimnishing Rate" then
                DimnishingRate(EmployeeLoan);
        end;
    end;

    procedure InterestFree(EmployeeLoan: Record "Employee Loan")
    var
        Employee: Record Employee;
        I: Integer;
    begin
        EmployeeLoan.TestField("No of Installment");

        PaymentDate := CalcDate('CM', EmployeeLoan."Loan Starting Date");

        if EmployeeLoan."Loan Type" = EmployeeLoan."Loan Type"::"Interest Free" then begin
            for I := 1 to EmployeeLoan."No of Installment" do begin
                EmployeeLoanDetails.Init;
                EmployeeLoanDetails.LoanId := EmployeeLoan."Loan Id";
                EmployeeLoanDetails."Location Code" := EmployeeLoan."Location Code";
                EmployeeLoanDetails."Salary Plan Code" := EmployeeLoan."Salary Plan Code";
                EmployeeLoanDetails."Employee No" := EmployeeLoan."Employee No";
                EmployeeLoanDetails."Line No." += 10000;
                EmployeeLoanDetails."Loan Deduction Interval" := EmployeeLoan."Loan Date Interval";
                EmployeeLoanDetails."Loan Amount" := EmployeeLoan."Total Loan Amount";
                EmployeeLoanDetails."Loan Code" := EmployeeLoan."Loan Code";
                EmployeeLoanDetails."Salary Process Date" := PaymentDate;
                EmployeeLoanDetails."EMI Amount" := Round((EmployeeLoan."Total Loan Amount" / EmployeeLoan."No of Installment"), 0.01, '=');
                EmployeeLoanDetails.Principal := Round((EmployeeLoan."Total Loan Amount" / EmployeeLoan."No of Installment"), 0.01, '=');
                EmployeeLoanDetails."Balance Amount" := EmployeeLoan."Total Loan Amount";

                if Employee.Get(EmployeeLoan."Employee No") then
                    EmployeeLoanDetails.Name := Employee."First Name";

                if EmployeeLoanDetails.Insert then;

                PaymentDate := CalcDate('1M', PaymentDate);
                PaymentDate := CalcDate('CM', PaymentDate);
            end;

            EmployeeLoan."Installment Amount" := Round((EmployeeLoan."Total Loan Amount" / EmployeeLoan."No of Installment"), 0.01, '=');
            EmployeeLoan."Loan Balance Amount" := EmployeeLoan."Total Loan Amount";
            EmployeeLoan.Modify;
            Message('Create a Installment Successfully');

        end;
    end;

    procedure FlatRate(EmployeeLoan: Record "Employee Loan")
    var
        EmployeeLoanDetail: Record "Employee Loan Details";
        Employee: Record Employee;
        Principal: Decimal;
        InterestAmount: Decimal;
        MonthlyInterest: Decimal;
        IntRateperMonth: Decimal;
        EMIAmount: Decimal;
        I: Integer;
    begin
        EmployeeLoan.TestField("No of Installment");

        IntRateperMonth := EmployeeLoan."Rate of Interest" / 12;
        MonthlyInterest := Round((EmployeeLoan."Total Loan Amount" * IntRateperMonth) / 100, 0.01);
        InterestAmount := Round((MonthlyInterest * EmployeeLoan."No of Installment"), 0.01);
        PaymentDate := CalcDate('CM', EmployeeLoan."Loan Starting Date");
        EMIAmount :=
          Round(((EmployeeLoan."Total Loan Amount" + InterestAmount) /
            EmployeeLoan."No of Installment"), 0.01);

        if EmployeeLoan."Loan Type" = EmployeeLoan."Loan Type"::"Flat Rate" then begin
            for I := 1 to EmployeeLoan."No of Installment" do begin
                EmployeeLoanDetails.Init;
                EmployeeLoanDetails."Location Code" := EmployeeLoan."Location Code";
                EmployeeLoanDetails."Salary Plan Code" := EmployeeLoan."Salary Plan Code";
                EmployeeLoanDetails."Employee No" := EmployeeLoan."Employee No";
                EmployeeLoanDetail.LoanId := EmployeeLoan."Loan Id";
                EmployeeLoanDetails."Line No." += 10000;
                EmployeeLoanDetails."Salary Process Date" := PaymentDate;
                EmployeeLoanDetails."Loan Code" := EmployeeLoan."Loan Code";
                EmployeeLoanDetails."Loan Amount" := EmployeeLoan."Total Loan Amount";
                EmployeeLoanDetails."EMI Amount" := EMIAmount;
                EmployeeLoanDetails.Interest := MonthlyInterest;
                EmployeeLoanDetails.Principal := EMIAmount - MonthlyInterest;
                EmployeeLoanDetails."Balance Amount" := EmployeeLoan."Total Loan Amount" +
                  (MonthlyInterest * EmployeeLoan."No of Installment");

                if Employee.Get(EmployeeLoan."Employee No") then
                    EmployeeLoanDetails.Name := Employee."First Name";

                if EmployeeLoanDetails.Insert then;

                PaymentDate := CalcDate('1M', PaymentDate);
                PaymentDate := CalcDate('CM', PaymentDate);
            end;

            if EmployeeLoan."Rate of Interest" <> 0 then begin
                EmployeeLoan."Installment Amount" := EMIAmount;
                EmployeeLoan."Loan Balance Amount" := EmployeeLoan."Total Loan Amount" +
                   (MonthlyInterest * EmployeeLoan."No of Installment");
                EmployeeLoan."Total Interest Amount" := MonthlyInterest * EmployeeLoan."No of Installment";
            end else
                EmployeeLoan."Installment Amount" :=
                    Round((EmployeeLoan."Total Loan Amount" /
                  EmployeeLoan."No of Installment"), 1, '=');
            EmployeeLoan.Modify;

            Message('Create a Installment Successfully');
        end;
    end;

    procedure DimnishingRate(EmployeeLoan: Record "Employee Loan")
    var
        Employee: Record Employee;
        Principal: Decimal;
        InterestAmount: Decimal;
        MonthlyInterest: Decimal;
        IntRateperMonth: Decimal;
        EMIAmount: Decimal;
        EMICalculation1: Decimal;
        EMICalculation2: Decimal;
        Balance: Decimal;
        BufferDate: Date;
        I: Integer;
        J: Integer;
    begin
        EmployeeLoan.TestField("No of Installment");

        PaymentDate := CalcDate('CM', EmployeeLoan."Loan Starting Date");
        IntRateperMonth := (1200 + EmployeeLoan."Rate of Interest") / 1200;
        EMICalculation1 := EmployeeLoan."Total Loan Amount" * Power(IntRateperMonth, EmployeeLoan."No of Installment");

        for I := 0 to (EmployeeLoan."No of Installment" - 1) do
            EMICalculation2 += Power(IntRateperMonth, I);
        EMIAmount := Round((EMICalculation1 / EMICalculation2), 0.01, '=');
        Balance := EmployeeLoan."Total Loan Amount";
        for J := 1 to EmployeeLoan."No of Installment" do begin
            BufferDate := PaymentDate;
            EmployeeLoanDetails.Init;
            EmployeeLoanDetails."Location Code" := EmployeeLoan."Location Code";
            EmployeeLoanDetails."Salary Plan Code" := EmployeeLoan."Salary Plan Code";
            EmployeeLoanDetails."Employee No" := EmployeeLoan."Employee No";
            EmployeeLoanDetails."Line No." += 10000;
            EmployeeLoanDetails."Loan Code" := EmployeeLoan."Loan Code";
            EmployeeLoanDetails."Salary Process Date" := PaymentDate;
            EmployeeLoanDetails.Name := EmployeeLoan.Name;
            EmployeeLoanDetails."Loan Amount" := EmployeeLoan."Total Loan Amount";
            EmployeeLoanDetails."EMI Amount" := EMIAmount;
            EmployeeLoanDetails.Interest := (Balance * EmployeeLoan."Rate of Interest") / 1200;
            EmployeeLoanDetails.Principal := EMIAmount - EmployeeLoanDetails.Interest;
            EmployeeLoanDetails."Balance Amount" := Balance;
            Balance := Balance - EmployeeLoanDetails.Principal;
            if EmployeeLoanDetails.Insert then;

            PaymentDate := CalcDate('1M', PaymentDate);
            PaymentDate := CalcDate('CM', PaymentDate);

        end;

        EmployeeLoan."Installment Amount" := EmployeeLoanDetails."EMI Amount";
        EmployeeLoan.Modify;
    end;
}

