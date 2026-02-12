tableextension 50001 "Employee Extension" extends Employee
{
    fields
    {
        field(50100; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Worker Permanent","Worker Temporary";
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Worker Permanent,Worker Temporary';
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

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
    // myInt: Integer;
}