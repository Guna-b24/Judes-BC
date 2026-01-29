table 72104 "Increment Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Increment Header';

    fields
    {
        field(1; "Pay Increment Id"; Code[20])
        {
            Caption = 'Pay Increment Id';

            trigger OnValidate()
            begin
                if "Pay Increment Id" <> xRec."Pay Increment Id" then begin
                    HRPayrollSetup.Get(UserId);
                    LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
                    NoSeriesMgt.TestManual(LocationHRPayrollSetup."Pay Revision No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Pay Increment Date"; Date)
        {
            Caption = 'Pay Increment Date';
        }
        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(5; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    Name := Employee."First Name";
                    "Scale of Pay" := Employee."Scale of Pay";
                end;
            end;
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(7; "Increment Starting Date"; Date)
        {
            Caption = 'Increment Starting Date';
        }
        field(8; "Increment Date Interval"; DateFormula)
        {
            Caption = 'Increment Date Interval';
        }
        field(9; "Salary From-1"; Decimal)
        {
            Caption = 'Salary From-1';
        }
        field(10; "Salary To-1"; Decimal)
        {
            Caption = 'Salary To-1';
        }
        field(11; "Increment Amount-1"; Decimal)
        {
            Caption = 'Increment Amount-1';
        }
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(13; "Scale of Pay"; Text[50])
        {
            Caption = 'Scale of Pay';
            Editable = false;
        }
        field(14; "Salary From-2"; Decimal)
        {
            Caption = 'Salary From-2';
        }
        field(15; "Salary To-2"; Decimal)
        {
            Caption = 'Salary To-2';
        }
        field(16; "Increment Amount-2"; Decimal)
        {
            Caption = 'Increment Amount-2';
        }
    }

    keys
    {
        key(Key1; "Pay Increment Id")
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
            IncrementLine.Reset;
            IncrementLine.SetRange("Pay Increment Id", "Pay Increment Id");
            if IncrementLine.FindFirst then begin
                IncrementLine.LockTable;
                IncrementLine.DeleteAll;
            end;
        end;
    end;

    trigger OnInsert()
    begin
        if "Pay Increment Id" = '' then begin
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Pay Revision No.");
            NoSeriesMgt.InitSeries(LocationHRPayrollSetup."Pay Revision No.", xRec."No. Series", 0D, "Pay Increment Id", "No. Series");
        end;

        if HRPayrollSetup.Get(UserId) then begin
            "Location Code" := HRPayrollSetup."Location Code";
            "Salary Plan Code" := HRPayrollSetup."Salary Plan Code";
        end;

        "Pay Increment Date" := Today;
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IncrementLine: Record "Increment Line";
        Employee: Record Employee;

    [Scope('Internal')]
    procedure AssistEdit(OldIncrementHeader: Record "Increment Header"): Boolean
    var
        IncrementHeader: Record "Increment Header";
    begin
        with IncrementHeader do begin
            IncrementHeader := Rec;
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Pay Revision No.");
            if NoSeriesMgt.SelectSeries(LocationHRPayrollSetup."Pay Revision No.", OldIncrementHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Pay Increment Id");
                Rec := IncrementHeader;
                exit(true);
            end;
        end;
    end;
}

