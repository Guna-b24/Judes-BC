table 72087 "Employee Loan"
{
    Caption = 'Employee Loan';
    // DrillDownPageID = 72119;
    // LookupPageID = 72119;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the location associated with the employee loan.';
        }

        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the salary plan under which the loan is issued.';
        }
        field(3; "Loan Id"; Code[20])
        {
            Caption = 'Loan Id';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the unique identifier of the loan.';

            trigger OnValidate()
            begin
                if "Loan Id" <> xRec."Loan Id" then begin
                    HRPayrollSetup.Get(UserId);
                    LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
                    NoSeriesMgt.TestManual(LocationHRPayrollSetup."Loan No.");
                    "Loan No. Series" := '';
                end;
            end;
        }
        field(4; "Loan Code"; Code[20])
        {
            Caption = 'Loan Code';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the loan pay element code.';
            TableRelation = "Pay Elements" WHERE("Location Code" = FIELD("Location Code"),
                                                  "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                  "Loan Element" = CONST(true));

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
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the employee number for whom the loan is issued.';

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
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the employee.';
        }

        field(7; "Total Loan Amount"; Decimal)
        {
            Caption = 'Total Loan Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total sanctioned loan amount.';
        }


        field(8; "Loan Type"; Option)
        {
            Caption = 'Loan Type';
            OptionCaption = ' ,Interest Free,Flat Rate,Dimnishing Rate';
            OptionMembers = " ","Interest Free","Flat Rate","Dimnishing Rate";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the type of interest calculation for the loan.';
        }

        field(9; "Rate of Interest"; Decimal)
        {
            Caption = 'Rate of Interest';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the rate of interest applicable to the loan.';
        }
        field(10; "No of Installment"; Integer)
        {
            Caption = 'No of Installment';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total number of installments.';
        }

        field(11; "Purpose of loan"; Text[50])
        {
            Caption = 'Purpose of loan';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the purpose for which the loan is taken.';
        }

        field(12; "Loan Ref. No"; Code[50])
        {
            Caption = 'Loan Ref. No';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the external reference number of the loan.';
        }

        field(13; "Loan Ref. Date"; Date)
        {
            Caption = 'Loan Ref. Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the reference date of the loan.';
        }

        field(14; "Loan Sanction Date"; Date)
        {
            Caption = 'Loan Sanction Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date on which the loan was sanctioned.';
        }

        field(15; "Loan Starting Date"; Date)
        {
            Caption = 'Loan Starting Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date from which loan repayment starts.';
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
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date on which loan repayment ends.';
        }

        field(17; "Installment Amount"; Decimal)
        {
            Caption = 'Installment Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the amount to be deducted per installment.';
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
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total interest calculated for the loan.';
        }

        field(19; "Loan Balance Amount"; Decimal)
        {
            Caption = 'Loan Balance Amount';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the remaining loan balance amount.';
        }

        field(20; "No Deduction Request"; Boolean)
        {
            Caption = 'No Deduction Request';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether deduction is temporarily stopped.';
        }
        field(21; "Partial Deduction"; Boolean)
        {
            Caption = 'Partial Deduction';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether partial deduction is allowed.';
        }

        field(22; Completed; Boolean)
        {
            Caption = 'Completed';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies whether the loan is fully settled.';
        }

        field(23; "Loan No. Series"; Code[20])
        {
            Caption = 'Loan No. Series';
            TableRelation = "No. Series".Code;
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series used for loan identification.';
        }
        field(24; "Loan Date Interval"; DateFormula)
        {
            Caption = 'Loan Date Interval';
            Editable = false;
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the interval between loan installments.';
        }

        field(25; "Opening Loan Amount"; Decimal)
        {
            Caption = 'Opening Loan Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the opening loan amount at the start.';

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
            CalcFormula = Sum("Employee Loan Details"."EMI Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                          "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                          "Loan Code" = FIELD("Loan Code"),
                                                                          "Employee No" = FIELD("Employee No"),
                                                                          "Loan Closed" = FILTER(true)));
            Caption = 'Total Loans Deducted';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Closing Balance Amount"; Decimal)
        {
            Caption = 'Closing Balance Amount';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the remaining balance after deductions.';

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
            CalcFormula = Sum("Processed Salary"."Payable Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                         "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                         "Employee No" = FIELD("Employee No"),
                                                                         "Pay Element Code" = FIELD("Loan Code")));
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
            "Loan No. Series" := LocationHRPayrollSetup."Loan No.";
            "Loan Id" := NoSeriesMgt.GetNextNo("Loan No. Series");
        end;
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";

        Employee: Record Employee;
        EmployeeLoan: Record "Employee Loan";
        PayElements: Record "Pay Elements";
        NoSeriesMgt: Codeunit "No. Series";


    procedure AssistEdit(OldEmployeeLoan: Record "Employee Loan"): Boolean
    begin

        EmployeeLoan := Rec;
        HRPayrollSetup.Get(UserId);
        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
        LocationHRPayrollSetup.TestField("Loan No.");
        if NoSeriesMgt.LookupRelatedNoSeries(LocationHRPayrollSetup."Loan No.", OldEmployeeLoan."Loan No. Series", "Loan No. Series") then begin
            EmployeeLoan."Loan Id" := NoSeriesMgt.GetNextNo(EmployeeLoan."Loan No. Series");
            Rec := EmployeeLoan;
            exit(true);
        end;
    end;

}

