table 72088 "Employee Loan Details"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Employee Loan Details';
    DrillDownPageID = 72120;
    LookupPageID = 72120;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(3; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    Name := Employee."First Name" + ' ' + Employee.Initials;
                    "Location Code" := Employee."Location Code";
                    "Salary Plan Code" := Employee."Salary Plan Code";
                end;
            end;
        }
        field(4; "Loan Code"; Code[20])
        {
            Caption = 'Loan Code';
            TableRelation = "Pay Elements" WHERE ("Location Code" = FIELD ("Location Code"),
                                                  "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                  "Loan Element" = CONST (true));
        }
        field(5; "Salary Process Date"; Date)
        {
            Caption = 'Salary Process Date';
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(7; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(8; "Loan Amount"; Decimal)
        {
            Caption = 'Loan Amount';
        }
        field(9; "Payment Due"; Decimal)
        {
            Caption = 'Payment Due';
        }
        field(10; "EMI Deducted"; Decimal)
        {
            Caption = 'EMI Deducted';
        }
        field(11; "EMI Amount"; Decimal)
        {
            Caption = 'EMI Amount';
        }
        field(12; Interest; Decimal)
        {
            Caption = 'Interest';
        }
        field(13; Principal; Decimal)
        {
            Caption = 'Principal';
        }
        field(14; "Balance Amount"; Decimal)
        {
            Caption = 'Balance Amount';

            trigger OnValidate()
            begin
                /*
                IF "Repayment Date" = 0 THEN
                  "Loan Closed" := TRUE;
                */

            end;
        }
        field(15; "Repayment Date"; Date)
        {
            Caption = 'Repayment Date';
        }
        field(16; "Loan Closed"; Boolean)
        {
            Caption = 'Loan Closed';
        }
        field(17; "Loan Deduction Interval"; DateFormula)
        {
            Caption = 'Loan Deduction Interval';
        }
        field(18; LoanId; Code[20])
        {
            Caption = 'LoanId';
        }
    }

    keys
    {
        key(Key1; "Employee No", "Loan Code", LoanId, "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Location Code", "Salary Plan Code", "Employee No", "Loan Code", "Loan Closed")
        {
            SumIndexFields = "EMI Amount";
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
}

