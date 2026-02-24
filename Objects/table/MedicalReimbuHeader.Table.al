table 72072 "Medical Reimbu. Header"
{
    Caption = 'Medical Reimbu. Header';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Pay Element Code", "Employee No.", Name;
    LookupPageID = "Medical Reimbu. List";
    DrillDownPageID = "Medical Reimbu. List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(3; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            TableRelation = "Pay Elements";
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then
                    Name := Employee."First Name" + ' ' + Employee.Initials;
            end;
        }
        field(5; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(7; "No of Bills"; Integer)
        {
            CalcFormula = Count("Medical Reimbu. Line" WHERE("Location Code" = FIELD("Location Code"),
                                                              "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                              "Employee No." = FIELD("Employee No."),
                                                              "Pay Element Code" = FIELD("Pay Element Code"),
                                                              Blocked = CONST(false)));
            Caption = 'No of Bills';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Last Year Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Last Year Amount';
            MinValue = 0;

            trigger OnValidate()
            begin
                "Total Amount" := "Last Year Amount" + "Current Year Eligible Amount";
                "Balance Amount" := "Total Amount" - "Claimed Amount";
            end;
        }
        field(9; "Current Year Eligible Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Current Year Eligible Amount';
            MinValue = 0;

            trigger OnValidate()
            begin
                "Total Amount" := "Last Year Amount" + "Current Year Eligible Amount";
                "Balance Amount" := "Total Amount" - "Claimed Amount";
            end;
        }
        field(10; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
        }
        field(11; "Claimed Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Medical Reimbu. Line"."Bill Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                          "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                          "Employee No." = FIELD("Employee No."),
                                                                          "Pay Element Code" = FIELD("Pay Element Code"),
                                                                          Blocked = CONST(false)));
            Caption = 'Claimed Amount';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Total Amount" := "Last Year Amount" + "Current Year Eligible Amount";
                "Balance Amount" := "Total Amount" - "Claimed Amount";
            end;
        }
        field(12; "Balance Amount"; Decimal)
        {
            Caption = 'Balance Amount';
            Editable = false;
        }
        field(13; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Pay Element Code", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Confirm('Are Sure to Delete the Records <Yes/No> Delete All Lines..!!') then begin
            MedicalReimbuLine.Reset();
            MedicalReimbuLine.SetRange("Employee No.", "Employee No.");
            MedicalReimbuLine.SetRange("Pay Element Code", "Pay Element Code");
            MedicalReimbuLine.SetRange("Location Code", "Location Code");
            MedicalReimbuLine.SetRange("Salary Plan Code", "Salary Plan Code");
            if MedicalReimbuLine.FindFirst() then begin
                MedicalReimbuLine.LockTable();
                MedicalReimbuLine.DeleteAll();
            end;
        end;
    end;

    var
        Employee: Record Employee;
        MedicalReimbuLine: Record "Medical Reimbu. Line";
}

