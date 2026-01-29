table 72095 "Final Settlement Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Final Settlement Header';
    DrillDownPageID = 72136;
    LookupPageID = 72136;

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
        field(3; "Salary Cycle Code"; Code[20])
        {
            TableRelation = "Payroll Month & Year" WHERE ("Location Code" = FIELD ("Location Code"),
                                                          "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(4; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
            Editable = false;
        }
        field(5; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
            Editable = false;
        }
        field(6; Month; Integer)
        {
            Caption = 'Month';
            Editable = false;
        }
        field(7; Year; Integer)
        {
            Caption = 'Year';
            Editable = false;
        }
        field(8; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee WHERE ("Location Code" = FIELD ("Location Code"),
                                            "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                            Status = CONST (Inactive));

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then begin
                    Name := Employee."First Name" + ' ' + Employee.Initials;
                    "Date of Joining" := Employee."Employment Date";
                    "Date of Leaving" := Employee."Date of Relieving";
                    Month := Date2DMY("Date of Leaving", 2);
                    Year := Date2DMY("Date of Leaving", 3);
                    "Grautity Service Year" := Round((("Date of Leaving" - "Date of Joining") / 365.2364), 1, '>');
                end;

                LeaveMaster.Reset;
                LeaveMaster.SetRange("Location Code", "Location Code");
                LeaveMaster.SetRange("Salary Plan Code", "Salary Plan Code");
                LeaveMaster.SetRange("Encash Leave", true);
                if LeaveMaster.FindFirst then
                    repeat
                        LeaveEntitlement.Reset;
                        LeaveEntitlement.SetRange("Location Code", "Location Code");
                        LeaveEntitlement.SetRange("Salary Plan Code", "Salary Plan Code");
                        LeaveEntitlement.SetRange("Leave Code", LeaveMaster."Leave Code");
                        LeaveEntitlement.SetRange("Employee No", "Employee No.");
                        if LeaveEntitlement.FindFirst then
                            repeat
                                "Total Encash Leave" += LeaveEntitlement."Leave Closing Balance";
                            until LeaveEntitlement.Next = 0;
                    until LeaveMaster.Next = 0;
            end;
        }
        field(9; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(10; "Date of Joining"; Date)
        {
            Caption = 'Date of Joining';
            Editable = false;
        }
        field(11; "Date of Leaving"; Date)
        {
            Caption = 'Date of Leaving';
            Editable = false;
        }
        field(12; "Grautity Service Year"; Integer)
        {
            Caption = 'Grautity Service Year';
            Editable = false;
        }
        field(13; "Total Encash Leave"; Decimal)
        {
            Caption = 'Total Encash Leave';
            Editable = false;
        }
        field(14; "Days Worked"; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance"."Payable Days" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                       "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                       "Employee No" = FIELD ("Employee No."),
                                                                       "Salary Cyclic Code" = FIELD ("Salary Cycle Code")));
            Caption = 'Days Worked';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Total Gross Earnings"; Decimal)
        {
            CalcFormula = Sum ("Final Settlement Line"."Payable Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                              "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                              "Salary Cycle Code" = FIELD ("Salary Cycle Code"),
                                                                              "Employee No" = FIELD ("Employee No."),
                                                                              "Pay Type" = FILTER (<> Deduction)));
            Caption = 'Total Gross Earnings';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Total Deductions"; Decimal)
        {
            CalcFormula = - Sum ("Final Settlement Line"."Payable Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                               "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                               "Salary Cycle Code" = FIELD ("Salary Cycle Code"),
                                                                               "Employee No" = FIELD ("Employee No."),
                                                                               "Pay Type" = CONST (Deduction)));
            Caption = 'Total Deductions';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Net Amount" := "Total Gross Earnings" - "Total Deductions";
            end;
        }
        field(17; "Net Amount"; Decimal)
        {
            CalcFormula = Sum ("Final Settlement Line"."Payable Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                              "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                              "Salary Cycle Code" = FIELD ("Salary Cycle Code"),
                                                                              "Employee No" = FIELD ("Employee No.")));
            Caption = 'Net Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
        }
        field(19; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(21; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Salary Cycle Code", "Employee No.")
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
            FinalSettlementLine.Reset;
            FinalSettlementLine.SetRange("Location Code", "Location Code");
            FinalSettlementLine.SetRange("Salary Plan Code", "Salary Plan Code");
            FinalSettlementLine.SetRange("Employee No", "Employee No.");
            if FinalSettlementLine.FindFirst then begin
                FinalSettlementLine.LockTable;
                FinalSettlementLine.DeleteAll;
            end;
        end;
    end;

    var
        Employee: Record Employee;
        LeaveMaster: Record "Leave Master";
        LeaveEntitlement: Record "Leave Entitlement";
        FinalSettlementLine: Record "Final Settlement Line";
}

