table 72087 "Employee Loan"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Employee Loan';
    DrillDownPageID = 72119;
    LookupPageID = 72119;

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
        field(3; "Loan Id"; Code[20])
        {
            Caption = 'Loan Id';

            trigger OnValidate()
            begin
                if "Loan Id" <> xRec."Loan Id" then begin
                    HRPayrollSetup.Get(UserId);
                    LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
                    NoSeriesMgt.TestManual(LocationHRPayrollSetup."Loan No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(4; "Loan Code"; Code[20])
        {
            Caption = 'Loan Code';
            TableRelation = "Pay Elements" WHERE ("Location Code" = FIELD ("Location Code"),
                                                  "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                  "Loan Element" = CONST (true));

            trigger OnValidate()
            begin
                if PayElements.Get("Loan Code", "Location Code", "Salary Plan Code") then begin
                    "Purpose of loan" := PayElements.Description;
                    "Total Loan Amount" := PayElements.Amount;
                    "Loan Balance Amount" := "Total Loan Amount";
                end;
            end;
        }
        field(5; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    Name := Employee."First Name";
                    "Location Code" := Employee."Location Code";
                    "Salary Plan Code" := Employee."Salary Plan Code";
                end;
            end;
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(7; "Total Loan Amount"; Decimal)
        {
            Caption = 'Total Loan Amount';
        }
        field(8; "Loan Type"; Option)
        {
            Caption = 'Loan Type';
            OptionCaption = ' ,Interest Free,Flat Rate,Dimnishing Rate';
            OptionMembers = " ","Interest Free","Flat Rate","Dimnishing Rate";
        }
        field(9; "Rate of Interest"; Decimal)
        {
            Caption = 'Rate of Interest';
        }
        field(10; "No of Installment"; Integer)
        {
            Caption = 'No of Installment';
        }
        field(11; "Purpose of loan"; Text[50])
        {
            Caption = 'Purpose of loan';
        }
        field(12; "Loan Ref. No"; Code[50])
        {
            Caption = 'Loan Ref. No';
        }
        field(13; "Loan Ref. Date"; Date)
        {
            Caption = 'Loan Ref. Date';
        }
        field(14; "Loan Sanction Date"; Date)
        {
            Caption = 'Loan Sanction Date';
        }
        field(15; "Loan Starting Date"; Date)
        {
            Caption = 'Loan Starting Date';

            trigger OnValidate()
            begin
                "Loan End Date" := "Loan Starting Date";

                if "Loan Starting Date" < "Loan Sanction Date" then
                    Error('Enter Valid Date of Loan Sanction Date,\ It Should not lessthan the Loan Starting Date');
            end;
        }
        field(16; "Loan End Date"; Date)
        {
            Caption = 'Loan End Date';
        }
        field(17; "Installment Amount"; Decimal)
        {
            Caption = 'Installment Amount';

            trigger OnValidate()
            begin
                TestField("Installment Amount");

                "No of Installment" := Round(("Total Loan Amount" / "Installment Amount"), 1, '>');
            end;
        }
        field(18; "Total Interest Amount"; Decimal)
        {
            Caption = 'Total Interest Amount';
            Editable = false;
        }
        field(19; "Loan Balance Amount"; Decimal)
        {
            Caption = 'Loan Balance Amount';
            Editable = false;
        }
        field(20; "No Deduction Request"; Boolean)
        {
            Caption = 'No Deduction Request';
        }
        field(21; "Partial Deduction"; Boolean)
        {
            Caption = 'Partial Deduction';
        }
        field(22; Completed; Boolean)
        {
            Caption = 'Completed';
        }
        field(23; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(24; "Loan Date Interval"; DateFormula)
        {
            Caption = 'Loan Date Interval';
            Editable = false;
        }
        field(25; "Opening Loan Amount"; Decimal)
        {
            Caption = 'Opening Loan Amount';

            trigger OnValidate()
            begin
                "Total Loan Amount" := "Opening Loan Amount";

                if "Installment Amount" > 0 then
                    "No of Installment" := Round(("Total Loan Amount" / "Installment Amount"), 1, '>');

                CalcFields("Total Loans Deducted");
                "Closing Balance Amount" := "Opening Loan Amount" - "Loans Deducted";
            end;
        }
        field(26; "Total Loans Deducted"; Decimal)
        {
            CalcFormula = Sum ("Employee Loan Details"."EMI Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                          "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                          "Loan Code" = FIELD ("Loan Code"),
                                                                          "Employee No" = FIELD ("Employee No"),
                                                                          "Loan Closed" = FILTER (true)));
            Caption = 'Total Loans Deducted';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Closing Balance Amount"; Decimal)
        {
            Caption = 'Closing Balance Amount';
            Editable = false;

            trigger OnValidate()
            begin
                CalcFields("Total Loans Deducted");
                "Closing Balance Amount" := "Opening Loan Amount" - "Loans Deducted";

                if "Closing Balance Amount" <= 0 then
                    Completed := true;
            end;
        }
        field(28; "Loan Plan"; Option)
        {
            Caption = 'Loan Plan';
            OptionCaption = ' ,Weekly,FortNight,Monthly';
            OptionMembers = " ",Weekly,FortNight,Monthly;

            trigger OnValidate()
            begin
                if "Loan Plan" = "Loan Plan"::Weekly then
                    Evaluate("Loan Date Interval", '1W');

                if "Loan Plan" = "Loan Plan"::FortNight then
                    Evaluate("Loan Date Interval", '15D');

                if "Loan Plan" = "Loan Plan"::Monthly then
                    Evaluate("Loan Date Interval", '1M');
            end;
        }
        field(29; "Loans Deducted"; Decimal)
        {
            CalcFormula = Sum ("Processed Salary"."Payable Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                         "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                         "Employee No" = FIELD ("Employee No"),
                                                                         "Pay Element Code" = FIELD ("Loan Code")));
            Caption = 'Loans Deducted';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Loan Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Loan Id" = '' then begin
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Loan No.");
            NoSeriesMgt.InitSeries(LocationHRPayrollSetup."Loan No.", xRec."No. Series", 0D, "Loan Id", "No. Series");
        end;
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record Employee;
        EmployeeLoan: Record "Employee Loan";
        PayElements: Record "Pay Elements";
        EndDate: Date;

    [Scope('Internal')]
    procedure AssistEdit(OldEmployeeLoan: Record "Employee Loan"): Boolean
    begin
        with EmployeeLoan do begin
            EmployeeLoan := Rec;
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Loan No.");
            if NoSeriesMgt.SelectSeries(LocationHRPayrollSetup."Loan No.", OldEmployeeLoan."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Loan Id");
                Rec := EmployeeLoan;
                exit(true);
            end;
        end;
    end;
}

