table 72095 "Final Settlement Header"
{
    Caption = 'Final Settlement Header';
    DataClassification = ToBeClassified;

    // DrillDownPageID = 72136;
    // LookupPageID = 72136;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the location for which the final settlement is processed.';
        }

        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary plan applicable to the employee.';
        }
        field(3; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            TableRelation = "Payroll Month & Year" WHERE("Location Code" = FIELD("Location Code"),
                                                          "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(4; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll start date.';
        }

        field(5; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll end date.';
        }

        field(6; Month; Integer)
        {
            Caption = 'Month';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll month.';
        }
        field(7; Year; Integer)
        {
            Caption = 'Year';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll year.';
        }
        field(8; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee WHERE("Location Code" = FIELD("Location Code"),
                                            "Salary Plan Code" = FIELD("Salary Plan Code"),
                                            Status = CONST(Inactive));

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

                LeaveMaster.Reset();
                LeaveMaster.SetRange("Location Code", "Location Code");
                LeaveMaster.SetRange("Salary Plan Code", "Salary Plan Code");
                LeaveMaster.SetRange("Encash Leave", true);
                if LeaveMaster.FindFirst() then
                    repeat
                        LeaveEntitlement.Reset();
                        LeaveEntitlement.SetRange("Location Code", "Location Code");
                        LeaveEntitlement.SetRange("Salary Plan Code", "Salary Plan Code");
                        LeaveEntitlement.SetRange("Leave Code", LeaveMaster."Leave Code");
                        LeaveEntitlement.SetRange("Employee No", "Employee No.");
                        if LeaveEntitlement.FindFirst() then
                            repeat
                                "Total Encash Leave" += LeaveEntitlement."Leave Closing Balance";
                            until LeaveEntitlement.Next() = 0;
                    until LeaveMaster.Next() = 0;
            end;
        }
        field(9; Name; Text[100])
        {
            Caption = 'Name';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee name.';
        }

        field(10; "Date of Joining"; Date)
        {
            Caption = 'Date of Joining';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee joining date.';
        }
        field(11; "Date of Leaving"; Date)
        {
            Caption = 'Date of Leaving';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee leaving date.';
        }

        field(12; "Grautity Service Year"; Integer)
        {
            Caption = 'Gratuity Service Year';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the gratuity service period in years.';
        }
        field(13; "Total Encash Leave"; Decimal)
        {
            Caption = 'Total Encash Leave';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies total leave days eligible for encashment.';
        }
        field(14; "Days Worked"; Decimal)
        {
            CalcFormula = Sum("Daily Attendance"."Payable Days" WHERE("Location Code" = FIELD("Location Code"),
                                                                       "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                       "Employee No" = FIELD("Employee No."),
                                                                       "Salary Cyclic Code" = FIELD("Salary Cycle Code")));
            Caption = 'Days Worked';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Total Gross Earnings"; Decimal)
        {
            CalcFormula = Sum("Final Settlement Line"."Payable Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                              "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                              "Salary Cycle Code" = FIELD("Salary Cycle Code"),
                                                                              "Employee No" = FIELD("Employee No."),
                                                                              "Pay Type" = FILTER(<> Deduction)));
            Caption = 'Total Gross Earnings';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Total Deductions"; Decimal)
        {
            CalcFormula = - Sum("Final Settlement Line"."Payable Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                               "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                               "Salary Cycle Code" = FIELD("Salary Cycle Code"),
                                                                               "Employee No" = FIELD("Employee No."),
                                                                               "Pay Type" = CONST(Deduction)));
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
            CalcFormula = Sum("Final Settlement Line"."Payable Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                              "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                              "Salary Cycle Code" = FIELD("Salary Cycle Code"),
                                                                              "Employee No" = FIELD("Employee No.")));
            Caption = 'Net Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the journal template used for posting.';
        }

        field(19; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the journal batch used for posting.';
        }

        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the posting date.';
        }

        field(21; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the document number.';
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
            FinalSettlementLine.Reset();
            FinalSettlementLine.SetRange("Location Code", "Location Code");
            FinalSettlementLine.SetRange("Salary Plan Code", "Salary Plan Code");
            FinalSettlementLine.SetRange("Employee No", "Employee No.");
            if FinalSettlementLine.FindFirst() then begin
                FinalSettlementLine.LockTable();
                FinalSettlementLine.DeleteAll();
            end;
        end;
    end;

    var
        Employee: Record Employee;
        LeaveMaster: Record "Leave Master";
        LeaveEntitlement: Record "Leave Entitlement";
        FinalSettlementLine: Record "Final Settlement Line";
}

