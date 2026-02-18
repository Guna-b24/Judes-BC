tableextension 50001 "Employee Extension" extends Employee
{
    fields
    {
        field(50100; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Worker Permanent","Worker Temporary","Class IV Permanent","Class IV Temporary";
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Worker Permanent,Worker Temporary,Class IV Permanent,Class IV Temporary';
            DataClassification = CustomerContent;
        }
        field(50101; "Working Shift Code"; code[20])
        {
            Caption = 'Working Shift Code';
            DataClassification = CustomerContent;
        }
        field(50102; "Extra Allowance Applicable"; Boolean)
        {
            Caption = 'Extra Allowance Applicable';
            DataClassification = CustomerContent;
        }
        field(50103; "OT Type"; Option)
        {
            Caption = 'OT Type';
            OptionMembers = " ","Hourly Based","Fixed Amount","Per Daily Amount";
            OptionCaption = ' ,Hourly Based,Fixed Amount,Per Daily Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies how overtime is calculated.';
        }
        field(50104; "Department Code"; code[10])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
        }
        field(50105; "Department Name"; text[50])
        {
            Caption = 'Department Name';
            DataClassification = CustomerContent;
        }
        field(50106; "Designation Code"; code[20])
        {
            Caption = 'Designation Code';
            DataClassification = CustomerContent;
        }
        field(50107; "Division Code"; code[10])
        {
            Caption = 'Division Code';
            DataClassification = CustomerContent;
        }
        field(50108; "Location Code"; code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(50109; "Salary Plan Code"; code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
        }
        field(50110; "Date of Relieving"; Date)
        {
            Caption = 'Date of Relieving';
            DataClassification = CustomerContent;
        }
        field(50111; "Section Code"; code[10])
        {
            Caption = 'Section Code';
            DataClassification = CustomerContent;
        }
        field(50112; "Attendance Generated"; Boolean)
        {
            Caption = 'Attendance Generated';
            DataClassification = CustomerContent;
        }
        field(50113; "Bonus Applicable"; Boolean)
        {
            Caption = 'Bonus Applicable';
            DataClassification = CustomerContent;
        }
        field(50114; "Designation Name"; text[30])
        {
            Caption = 'Designation Name';
            DataClassification = CustomerContent;
        }
        field(50115; "PAN No"; code[20])
        {
            Caption = 'PAN No';
            DataClassification = CustomerContent;
        }
        field(50116; "Metro / Non Metro"; Option)
        {
            Caption = 'Metro / Non Metro';
            DataClassification = CustomerContent;
            OptionMembers = "","Metro","Non Metro";
            OptionCaption = ', Metro, Non Metro';
        }
        field(50117; "Leave Generated"; Boolean)
        {
            Caption = 'Leave Generated';
            DataClassification = CustomerContent;
        }
        field(50118; "Probationary"; Boolean)
        {
            Caption = 'Probationary';
            DataClassification = CustomerContent;
        }
        field(50119; "Grade Code"; code[20])
        {
            Caption = 'Grade Code';
            DataClassification = CustomerContent;
        }
        field(50120; "Pay Bus. Posting Group"; code[20])
        {
            Caption = 'Pay Bus. Posting Group';
            DataClassification = CustomerContent;
        }
        field(50121; "Emp Posting Group"; code[20])
        {
            Caption = 'Emp Posting Group';
            DataClassification = CustomerContent;
        }
        field(50122; "Payment Method"; Option)
        {
            Caption = 'Payment Method';
            DataClassification = CustomerContent;
            OptionMembers = "","Cash","Cheque","Bank Transfer";
            OptionCaption = ', Cash, Cheque,Bank Transfer';
        }
        field(50123; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(50124; "Stop Payment"; Boolean)
        {
            Caption = 'Stop Payment';
            DataClassification = CustomerContent;
        }
        field(50125; "Layoff Applicable"; Boolean)
        {
            Caption = 'Layoff Applicable';
            DataClassification = CustomerContent;
        }
        field(50126; "Credit Days Applicable"; Boolean)
        {
            Caption = 'Credit Days Applicable';
            DataClassification = CustomerContent;
        }
        field(50127; "Attendance Bonus Applicable"; Boolean)
        {
            Caption = 'Attendance Bonus Applicable';
            DataClassification = CustomerContent;
        }
        field(50128; "Attendance Bonus Amount"; Decimal)
        {
            Caption = 'Attendance Bonus Amount';
            DataClassification = CustomerContent;
        }
        field(50129; "PF Applicable"; Boolean)
        {
            Caption = 'PF Applicable';
            DataClassification = CustomerContent;
        }
        field(50130; "VPF Applicable"; Boolean)
        {
            Caption = 'VPF Applicable';
            DataClassification = CustomerContent;
        }
        field(50131; "Employee VPF ( Employee) %"; Decimal)
        {
            Caption = 'Employee VPF ( Employee) %';
            DataClassification = CustomerContent;
        }
        field(50132; "ESI Applicable"; Boolean)
        {
            Caption = 'ESI Applicable';
            DataClassification = CustomerContent;
        }
        field(50133; "PT Applicable"; Boolean)
        {
            Caption = 'PT Applicable';
            DataClassification = CustomerContent;
        }
        field(50134; "PT Branch Code"; code[20])
        {
            Caption = 'PT Branch Code';
            DataClassification = CustomerContent;
        }
        field(50135; "Insurance Applicable"; Boolean)
        {
            Caption = 'Insurance Applicable';
            DataClassification = CustomerContent;
        }
        field(50136; "Medical Reimbu. Applicable"; Boolean)
        {
            Caption = 'Medical Reimbu. Applicable';
            DataClassification = CustomerContent;
        }
        field(50137; "OT Applicable"; Boolean)
        {
            Caption = 'OT Applicable';
            DataClassification = CustomerContent;
        }
        field(50138; "Over Time Multiplier"; Decimal)
        {
            Caption = 'Over Time Multiplier';
            DataClassification = CustomerContent;
        }
        field(50139; "Per Daily Amount"; Boolean)
        {
            Caption = 'Per Daily Amount';
            DataClassification = CustomerContent;
        }
        field(50140; "Weekly Off Cut"; Boolean)
        {
            Caption = 'Weekly Off Cut';
            DataClassification = CustomerContent;
        }
        field(50141; "Weekly Off / Holiday Cut"; Boolean)
        {
            Caption = 'Weekly Off / Holiday Cut';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        // Add "Layoff Applicable" to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
    // myInt: Integer;
}