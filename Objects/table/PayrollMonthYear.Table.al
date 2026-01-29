table 72055 "Payroll Month & Year"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.

    Caption = 'Payroll Month & Year';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Salary Year Code", "Salary Cyclic Code", "Salary Start Date", "Salary End Date";
    DrillDownPageID = 72069;
    LookupPageID = 72069;

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
        field(3; "Salary Year Code"; Code[20])
        {
            Caption = 'Salary Year Code';
            TableRelation = "Payroll Year";
        }
        field(4; "Salary Cyclic Code"; Code[20])
        {
            Caption = 'Salary Cyclic Code';
        }
        field(5; "Salary Start Date"; Date)
        {
            Caption = 'Salary Start Date';
        }
        field(6; "Salary End Date"; Date)
        {
            Caption = 'Salary End Date';
        }
        field(7; "Salary Month"; Integer)
        {
            Caption = 'Salary Month';
        }
        field(8; "Salary Year"; Integer)
        {
            Caption = 'Salary Year';
        }
        field(9; "Attendance Generated"; Boolean)
        {
            Caption = 'Attendance Generated';
        }
        field(10; "Salary Processed"; Boolean)
        {
            Caption = 'Salary Processed';
        }
        field(11; "No of Employee Processed"; Integer)
        {
            Caption = 'No of Employee Processed';
        }
        field(12; "Salary Posted"; Boolean)
        {
            Caption = 'Salary Posted';
        }
        field(13; "No of Employee Posted"; Integer)
        {
            Caption = 'No of Employee Posted';
        }
        field(14; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(15; "Income Tax Salary Posted"; Boolean)
        {
            Caption = 'Income Tax Salary Posted';
        }
        field(16; "VDA Starting Points"; Integer)
        {
            Caption = 'VDA Starting Points';

            trigger OnValidate()
            begin
                Validate("VDA Ending Points");
            end;
        }
        field(17; "VDA Ending Points"; Integer)
        {
            Caption = 'VDA Ending Points';

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
        }
        field(19; "Points Rate"; Decimal)
        {
            Caption = 'Points Rate';

            trigger OnValidate()
            begin
                "Total VDA Amount" := "Total Points" * "Points Rate";
            end;
        }
        field(20; "Total VDA Amount"; Decimal)
        {
            Caption = 'Total VDA Amount';
            Editable = false;
        }
        field(21; "Staff VDA Amount"; Decimal)
        {
            Caption = 'Staff VDA Amount';
        }
        field(22; "Workmen VDA Amount"; Decimal)
        {
            Caption = 'Workmen VDA Amount';
        }
        field(23; "VDA Minimum Daily Wages Range"; Decimal)
        {
            Caption = 'VDA Minimum Daily Wages Range';
        }
        field(24; "VDA Differance Amount"; Decimal)
        {
            Caption = 'VDA Differance Amount';
        }
        field(25; "PF Challan Date"; Date)
        {
            Caption = 'PF Challan Date';
        }
        field(26; "ESI Challan Date"; Date)
        {
            Caption = 'ESI Challan Date';
        }
        field(27; "Challan Bank Name"; Text[50])
        {
            Caption = 'Challan Bank Name';
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

