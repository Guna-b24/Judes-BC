table 72117 "Bonus Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Bonus Line';

    fields
    {
        field(1; "Bonus Id."; Code[20])
        {
            Caption = 'Bonus Id.';
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(4; "Bonus Year"; Code[20])
        {
            Caption = 'Bonus Year';
        }
        field(5; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    Name := Employee."First Name" + ' ' + Employee.Initials;
                    "Employee Category" := Employee."Employee Category";
                end
                else begin
                    Name := '';
                    "Employee Category" := "Employee Category"::" ";
                end;
            end;
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(7; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
        }
        field(8; "Service Year"; Integer)
        {
            Caption = 'Service Year';
        }
        field(9; "No of Days Worked"; Decimal)
        {
            CalcFormula = Sum ("Bonus Detailed Line"."Days Worked" WHERE ("Bonus Id." = FIELD ("Bonus Id."),
                                                                         "Location Code" = FIELD ("Location Code"),
                                                                         "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                         "Bonus Year" = FIELD ("Bonus Year"),
                                                                         "Employee No" = FIELD ("Employee No")));
            Caption = 'No of Days Worked';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Bonusable Earnings"; Decimal)
        {
            CalcFormula = Sum ("Bonus Detailed Line"."Bonusable Earnings" WHERE ("Bonus Id." = FIELD ("Bonus Id."),
                                                                                "Location Code" = FIELD ("Location Code"),
                                                                                "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                                "Bonus Year" = FIELD ("Bonus Year"),
                                                                                "Employee No" = FIELD ("Employee No")));
            Caption = 'Bonusable Earnings';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Bonus %"; Decimal)
        {
            Caption = 'Bonus %';
        }
        field(12; "Ex-Gratia %"; Decimal)
        {
            Caption = 'Ex-Gratia %';
        }
        field(13; "Bonus Amt"; Decimal)
        {
            Caption = 'Bonus Amt';
        }
        field(14; "Ex-Gratia Amt"; Decimal)
        {
            Caption = 'Ex-Gratia Amt';
        }
        field(15; "Gross Bonus Amt"; Decimal)
        {
            CalcFormula = Sum ("Bonus Misc Add/Deductions".Amount WHERE ("Location Code" = FIELD ("Location Code"),
                                                                        "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                        "Bonus ID." = FIELD ("Bonus Id."),
                                                                        "Employee No." = FIELD ("Employee No"),
                                                                        "Pay Type" = FILTER (Addition)));
            Caption = 'Gross Bonus Amt';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Deduction Amt"; Decimal)
        {
            CalcFormula = Sum ("Bonus Misc Add/Deductions".Amount WHERE ("Location Code" = FIELD ("Location Code"),
                                                                        "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                        "Bonus ID." = FIELD ("Bonus Id."),
                                                                        "Employee No." = FIELD ("Employee No"),
                                                                        "Pay Type" = FILTER (Deduction)));
            Caption = 'Deduction Amt';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Total Net Bonus Amt"; Decimal)
        {
            Caption = 'Total Net Bonus Amt';
            Editable = false;
        }
        field(18; "Select (Y/N)"; Boolean)
        {
            Caption = 'Select (Y/N)';
        }
        field(19; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Worker Permanent,Worker Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Worker Permanent","Worker Temporary";
        }
        field(20; "Service Month"; Decimal)
        {
            Caption = 'Service Month';
        }
        field(21; "Total Days In a Year"; Decimal)
        {
            Caption = 'Total Days In a Year';
        }
    }

    keys
    {
        key(Key1; "Bonus Id.", "Location Code", "Salary Plan Code", "Bonus Year", "Employee No")
        {
            Clustered = true;
        }
        key(Key2; "Employee Category", "Service Year", "Service Month", "Employee No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        BonusDetailedLine.Reset;
        BonusDetailedLine.SetRange("Location Code", "Location Code");
        BonusDetailedLine.SetRange("Salary Plan Code", "Salary Plan Code");
        BonusDetailedLine.SetRange("Bonus Id.", "Bonus Id.");
        BonusDetailedLine.SetRange("Employee No", "Employee No");
        if BonusDetailedLine.FindFirst then begin
            BonusDetailedLine.LockTable;
            BonusDetailedLine.DeleteAll;
        end;
    end;

    var
        Employee: Record Employee;
        BonusDetailedLine: Record "Bonus Detailed Line";
}

