table 71152 "Period Line"
{
    Caption = 'Period Line';
    DataClassification = CustomerContent;
    LookupPageID = "Period Line List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the period header code to which this line belongs.';
            TableRelation = "Period Header";
        }
        field(2; "Period Time"; Time)
        {
            Caption = 'Period Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the starting time of the period.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the line number of the period.';
        }
        field(4; Period; Text[30])
        {
            Caption = 'Period';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the name or description of the period.';
        }
        field(5; "Interval Check"; Boolean)
        {
            Caption = 'Interval Check';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether this period is marked as an interval break.';
        }
        field(6; "Lab Start Hour"; Boolean)
        {
            Caption = 'Lab Start Hour';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether this period is the starting hour of a lab session.';
        }
    }

    keys
    {
        key(Key1; "Code", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Period Time")
        {
        }
        key(Key3; "Code", "Lab Start Hour")
        {
        }
    }

    fieldgroups
    {
    }
}

