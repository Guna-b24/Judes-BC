table 72070 "Insurance Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Insurance Header';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Pay Element Code", "Employee No.", Name;
    DrillDownPageID = 72091;
    LookupPageID = 72091;

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
        field(7; "No. of Policy"; Integer)
        {
            CalcFormula = Count ("Insurance Line" WHERE ("Location Code" = FIELD ("Location Code"),
                                                        "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                        "Employee No." = FIELD ("Employee No."),
                                                        "Pay Element Code" = FIELD ("Pay Element Code"),
                                                        Blocked = CONST (false)));
            Caption = 'No. of Policy';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Total Premium Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum ("Insurance Line"."Premium Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                       "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                       "Employee No." = FIELD ("Employee No."),
                                                                       "Pay Element Code" = FIELD ("Pay Element Code"),
                                                                       Blocked = CONST (false)));
            Caption = 'Total Premium Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Total Value Insured"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum ("Insurance Line"."Insured Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                       "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                       "Employee No." = FIELD ("Employee No."),
                                                                       "Pay Element Code" = FIELD ("Pay Element Code"),
                                                                       Blocked = CONST (false)));
            Caption = 'Total Value Insured';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
    }

    keys
    {
        key(Key1; "Pay Element Code", "Employee No.", "Location Code", "Salary Plan Code")
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
            LICLine.Reset;
            LICLine.SetRange("Employee No.", "Employee No.");
            LICLine.SetRange("Pay Element Code", "Pay Element Code");
            LICLine.SetRange("Location Code", "Location Code");
            LICLine.SetRange("Salary Plan Code", "Salary Plan Code");
            if LICLine.FindFirst then begin
                LICLine.LockTable;
                LICLine.DeleteAll;
            end;
        end;
    end;

    var
        Employee: Record Employee;
        LICLine: Record "Insurance Line";
}

