table 72112 "Gate Pass"
{
    Caption = 'Gate Pass';
    DrillDownPageID = 72148;
    LookupPageID = 72148;

    fields
    {
        field(1; "Out Pass No."; Code[20])
        {
            Caption = 'Out Pass No.';

            trigger OnValidate()
            begin
                if "Out Pass No." <> xRec."Out Pass No." then begin
                    HRPayrollSetup.Get(UserId);
                    LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
                    NoSeriesMgt.TestManual(LocationHRPayrollSetup."Employee Gate Pass No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Out Pass Date"; Date)
        {
            Caption = 'Out Pass Date';
            Editable = false;
        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(4; "Gate Pass Type"; Option)
        {
            Caption = 'Gate Pass Type';
            OptionCaption = 'Permission,On-Duty';
            OptionMembers = Permission,"On-Duty";
        }
        field(5; "Employee No."; Code[10])
        {
            Caption = 'Employee No.';
            TableRelation = Employee WHERE (Status = FILTER (Active));

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then begin
                    Name := Employee."First Name";
                    Designation := Employee."Designation Code";
                end
                else begin
                    Name := '';
                    Designation := '';
                end;
            end;
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(7; Designation; Text[50])
        {
            Caption = 'Designation';
            Editable = false;
        }
        field(8; Reason; Text[50])
        {
            Caption = 'Reason';
        }
        field(9; "Out Date"; Date)
        {
            Caption = 'Out Date';
        }
        field(10; "Out Time"; Time)
        {
            Caption = 'Out Time';
        }
        field(11; "In Date"; Date)
        {
            Caption = 'In Date';
        }
        field(12; "In Time"; Time)
        {
            Caption = 'In Time';
        }
        field(13; "Sanction In-Charge"; Code[20])
        {
            Caption = 'Sanction In-Charge';
            TableRelation = Employee WHERE (Status = FILTER (Active));

            trigger OnValidate()
            begin
                if Employee.Get("Sanction In-Charge") then
                    "In-Charge Name" := Employee."First Name"
                else
                    "In-Charge Name" := '';
            end;
        }
        field(14; "In-Charge Name"; Text[50])
        {
            Caption = 'In-Charge Name';
            Editable = false;
        }
        field(15; "Authorized Person"; Code[20])
        {
            Caption = 'Authorized Person';
            TableRelation = Employee WHERE (Status = FILTER (Active));

            trigger OnValidate()
            begin
                if Employee.Get("Authorized Person") then
                    "Authorized Name" := Employee."First Name"
                else
                    "Authorized Name" := '';
            end;
        }
        field(16; "Authorized Name"; Text[50])
        {
            Caption = 'Authorized Name';
            Editable = false;
        }
        field(17; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(18; "Creator Date"; Date)
        {
            Caption = 'Creator Date';
        }
    }

    keys
    {
        key(Key1; "Out Pass No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        HRPayrollSetup.Get(UserId);
        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
        if "Out Pass No." = '' then begin
            LocationHRPayrollSetup.TestField("Employee Gate Pass No");
            NoSeriesMgt.InitSeries(LocationHRPayrollSetup."Employee Gate Pass No", xRec."No. Series", 0D, "Out Pass No.", "No. Series");
        end;

        "Out Pass Date" := Today;
        "Out Date" := Today;
        "Out Time" := Time;
        "In Date" := Today;
        "In Time" := Time;
        "User ID" := UserId;
        "Creator Date" := Today;
    end;

    var
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record Employee;
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";

    [Scope('Internal')]
    procedure AssistEdit(OldGatePass: Record "Gate Pass"): Boolean
    var
        GatePass: Record "Gate Pass";
    begin
        with GatePass do begin
            GatePass := Rec;
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Employee Gate Pass No");
            if NoSeriesMgt.SelectSeries(LocationHRPayrollSetup."Employee Gate Pass No", OldGatePass."No. Series", "No. Series") then begin
                HRPayrollSetup.Get(UserId);
                LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
                LocationHRPayrollSetup.TestField("Employee Gate Pass No");
                NoSeriesMgt.SetSeries("Out Pass No.");
                Rec := GatePass;
                exit(true);
            end;
        end;
    end;
}

