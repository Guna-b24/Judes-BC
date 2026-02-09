table 72120 "Employee Loans"
{
    Caption = 'Employee Loans';
    // DrillDownPageID = 72166;
    // LookupPageID = 72166;

    fields
    {
        field(1; "Loan Id"; Code[20])
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
        field(2; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "Location Code" := Employee."Location Code";
                    "Salary Plan Code" := Employee."Salary Plan Code";
                    Name := Employee."First Name" + '.' + Employee.Initials;
                end;
            end;
        }
        field(3; "Loan Code"; Code[20])
        {
            Caption = 'Loan Code';
            TableRelation = "Pay Elements" WHERE("Location Code" = FIELD("Location Code"),
                                                  "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                  "Loan Element" = CONST(true));

            trigger OnValidate()
            begin
                if PayElements.Get("Loan Code", "Location Code", "Salary Plan Code") then begin
                    "Purpose of Loan" := PayElements.Description;
                    "Loan Sanctioned Amount" := PayElements.Amount;
                end;
            end;
        }
        field(4; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = "Location HR & Payroll Setup";
        }
        field(5; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            Editable = false;
            TableRelation = "Salary Plan";
        }
        field(6; Name; Text[100])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(7; "Purpose of Loan"; Text[50])
        {
            Caption = 'Purpose of Loan';
        }
        field(8; "Loan Starting Date"; Date)
        {
            Caption = 'Loan Starting Date';
        }
        field(9; "Loan Sanctioned Date"; Date)
        {
            Caption = 'Loan Sanctioned Date';
        }
        field(10; "Loan Sanctioned Amount"; Decimal)
        {
            Caption = 'Loan Sanctioned Amount';

            trigger OnValidate()
            begin
                TestField("Loan Starting Date");
                ValidateBalanceAmount();
            end;
        }
        field(11; "Deduction Amount"; Decimal)
        {
            Caption = 'Deduction Amount';

            trigger OnValidate()
            begin
                ValidateBalanceAmount();
            end;
        }
        field(12; "Total Loans Deducted"; Decimal)
        {
            CalcFormula = Sum("Processed Salary"."Payable Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                         "Employee No" = FIELD("Employee No"),
                                                                         "Branch Code" = FIELD("Loan Id")));
            Caption = 'Total Loans Deducted';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Loan Balance Amount"; Decimal)
        {
            Caption = 'Loan Balance Amount';
            Editable = false;
        }
        field(14; "Repayment Date"; Date)
        {
            Caption = 'Repayment Date';
        }
        field(15; "Repayment Amount"; Decimal)
        {
            Caption = 'Repayment Amount';

            trigger OnValidate()
            begin
                ValidateBalanceAmount();
            end;
        }
        field(16; "No Deduction Request"; Boolean)
        {
            Caption = 'No Deduction Request';
        }
        field(17; Completed; Boolean)
        {
            Caption = 'Completed';
        }
        field(18; "Created Date"; Date)
        {
            Caption = 'Created Date';
        }
        field(20; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
        }
        field(21; "Modified User Id"; Code[20])
        {
            Caption = 'Modified User Id';
        }
        field(40; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Loan Id")
        {
            Clustered = true;
        }
        key(Key2; "Employee No")
        {
        }
    }

    fieldgroups
    {
    }


    trigger OnInsert()
    begin
        if "Location Code" = '' then begin
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Loan No.");
            NoSeriesMgt.InitSeries(LocationHRPayrollSetup."Loan No.",
            xRec."No. Series", 0D, "Loan Id", "No. Series");
        end;

        "Loan Sanctioned Date" := Today;
        "Created Date" := Today;
    end;

    trigger OnModify()
    begin
        "Modified Date" := Today;
        "Modified User Id" := UserId;
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        Employee: Record Employee;
        PayElements: Record "Pay Elements";
        NoSeriesMgt: Codeunit "No. Series";


    procedure AssistEdit(OldEmployeeLoans: Record "Employee Loans"): Boolean
    var
        EmployeeLoans: Record "Employee Loans";
    begin
        EmployeeLoans := Rec;
        HRPayrollSetup.Get(UserId);
        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
        LocationHRPayrollSetup.TestField("Loan No.");
        if NoSeriesMgt.LookupRelatedNoSeries(LocationHRPayrollSetup."Loan No.",
           OldEmployeeLoans."No. Series", "No. Series")
        then begin
            Rec := EmployeeLoans;
            exit(true);
        end;
    end;

    procedure ValidateBalanceAmount()
    begin
        CalcFields("Total Loans Deducted");
        "Loan Balance Amount" := "Loan Sanctioned Amount" - "Total Loans Deducted" - "Repayment Amount";
    end;
}

