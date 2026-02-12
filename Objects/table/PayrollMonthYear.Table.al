table 72055 "Payroll Month & Year"
{
    Caption = 'Payroll Month & Year';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Location Code", "Salary Plan Code", "Salary Year Code", "Salary Cyclic Code", "Salary Start Date", "Salary End Date";
    // DrillDownPageID = 72069;
    // LookupPageID = 72069;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the payroll location.';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the salary plan.';
        }
        field(3; "Salary Year Code"; Code[20])
        {
            Caption = 'Salary Year Code';
            TableRelation = "Payroll Year";
        }
        field(4; "Salary Cyclic Code"; Code[20])
        {
            Caption = 'Salary Year Code';
            TableRelation = "Payroll Year";
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the payroll year.';
        }
        field(5; "Salary Start Date"; Date)
        {
            Caption = 'Salary Start Date';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the start date of the payroll period.';
        }
        field(6; "Salary End Date"; Date)
        {
            Caption = 'Salary End Date';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the end date of the payroll period.';
        }
        field(7; "Salary Month"; Integer)
        {
            Caption = 'Salary Month';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the payroll month.';
        }
        field(8; "Salary Year"; Integer)
        {
            Caption = 'Salary Year';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the payroll year.';
        }
        field(9; "Attendance Generated"; Boolean)
        {
            Caption = 'Attendance Generated';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies whether attendance has been generated.';
        }
        field(10; "Salary Processed"; Boolean)
        {
            Caption = 'Salary Processed';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies whether salary has been processed.';
        }
        field(11; "No of Employee Processed"; Integer)
        {
            Caption = 'No of Employee Processed';
            Editable = false;
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the number of employees processed.';
        }
        field(12; "Salary Posted"; Boolean)
        {
            Caption = 'Salary Posted';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies whether salary has been posted.';
        }
        field(13; "No of Employee Posted"; Integer)
        {
            Caption = 'No of Employee Posted';
            Editable = false;
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the number of employees posted.';
        }
        field(14; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies whether the payroll period is closed.';
        }
        field(15; "Income Tax Salary Posted"; Boolean)
        {
            Caption = 'Income Tax Salary Posted';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies whether income tax salary entries are posted.';
        }
        field(16; "VDA Starting Points"; Integer)
        {
            Caption = 'VDA Starting Points';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the starting VDA points.';

            trigger OnValidate()
            begin
                Validate("VDA Ending Points");
            end;
        }
        field(17; "VDA Ending Points"; Integer)
        {
            Caption = 'VDA Ending Points';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the ending VDA points.';

            trigger OnValidate()
            begin
                "Total Points" := "VDA Ending Points" - "VDA Starting Points";

                if "Total Points" < 0 then
                    "Total Points" := 0;

                Validate("Points Rate");
            end;
        }
        field(18; "Total Points"; Integer)
        {
            Caption = 'Total Points';
            Editable = false;
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the calculated total VDA points.';
        }
        field(19; "Points Rate"; Decimal)
        {
            Caption = 'Points Rate';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the rate per VDA point.';
            trigger OnValidate()
            begin
                "Total VDA Amount" := "Total Points" * "Points Rate";
            end;
        }
        field(20; "Total VDA Amount"; Decimal)
        {
            Caption = 'Total VDA Amount';
            Editable = false;
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the calculated total VDA amount.';
        }
        field(21; "Staff VDA Amount"; Decimal)
        {
            Caption = 'Staff VDA Amount';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the VDA amount for staff.';
        }
        field(22; "Workmen VDA Amount"; Decimal)
        {
            Caption = 'Workmen VDA Amount';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the VDA amount for workmen.';
        }
        field(23; "VDA Minimum Daily Wages Range"; Decimal)
        {
            Caption = 'VDA Minimum Daily Wages Range';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the minimum daily wages range for VDA.';
        }
        field(24; "VDA Differance Amount"; Decimal)
        {
            Caption = 'VDA Difference Amount';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the VDA difference amount.';
        }
        field(25; "PF Challan Date"; Date)
        {
            Caption = 'PF Challan Date';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the PF challan date.';
        }
        field(26; "ESI Challan Date"; Date)
        {
            Caption = 'ESI Challan Date';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the ESI challan date.';
        }
        field(27; "Challan Bank Name"; Text[50])
        {
            Caption = 'Challan Bank Name';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies the bank name used for challan payment.';
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Salary Cyclic Code", "Salary Start Date", "Salary End Date")
        {
            Clustered = true;
        }
        key(Key2; "Location Code", "Salary Plan Code", "Salary Start Date", "Salary End Date")
        {
        }
    }

    fieldgroups
    {
    }
}

