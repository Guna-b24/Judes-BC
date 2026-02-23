table 72088 "Employee Loan Details"
{

    Caption = 'Employee Loan Details';
    // DrillDownPageID = 72120;
    // LookupPageID = 72120;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }

        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }
        field(3; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;
            DataClassification = CustomerContent;

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
            TableRelation = "Pay Elements" WHERE("Location Code" = FIELD("Location Code"),
                                                  "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                  "Loan Element" = CONST(true));
        }
        field(5; "Salary Process Date"; Date)
        {
            Caption = 'Salary Process Date';
            DataClassification = CustomerContent;
        }

        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }

        field(7; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(8; "Loan Amount"; Decimal)
        {
            Caption = 'Loan Amount';
            DataClassification = CustomerContent;
        }

        field(9; "Payment Due"; Decimal)
        {
            Caption = 'Payment Due';
            DataClassification = CustomerContent;
        }

        field(10; "EMI Deducted"; Decimal)
        {
            Caption = 'EMI Deducted';
            DataClassification = CustomerContent;
        }

        field(11; "EMI Amount"; Decimal)
        {
            Caption = 'EMI Amount';
            DataClassification = CustomerContent;
        }

        field(12; Interest; Decimal)
        {
            Caption = 'Interest';
            DataClassification = CustomerContent;
        }

        field(13; Principal; Decimal)
        {
            Caption = 'Principal';
            DataClassification = CustomerContent;
        }
        field(14; "Balance Amount"; Decimal)
        {
            Caption = 'Balance Amount';
            DataClassification = CustomerContent;
        }

        field(15; "Repayment Date"; Date)
        {
            Caption = 'Repayment Date';
            DataClassification = CustomerContent;
        }

        field(16; "Loan Closed"; Boolean)
        {
            Caption = 'Loan Closed';
            DataClassification = CustomerContent;
        }
        field(17; "Loan Deduction Interval"; DateFormula)
        {
            Caption = 'Loan Deduction Interval';
            DataClassification = CustomerContent;
        }

        field(18; LoanId; Code[20])
        {
            Caption = 'Loan Id';
            DataClassification = CustomerContent;
            TableRelation = "Employee Loan"."Loan Id";
        }
    }

    keys
    {
        key(Key1; "Employee No", "Loan Code", LoanId, "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Location Code", "Salary Plan Code", "Loan Code", "Employee No", "Loan Closed")
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

