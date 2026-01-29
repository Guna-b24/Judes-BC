table 71152 "Period Line"
{
    Caption = 'Period Line';
    LookupPageID = 71424;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Period Time"; Time)
        {
            Caption = 'Period Time';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Period; Text[30])
        {
            Caption = 'Period';
        }
        field(5; "Interval Check"; Boolean)
        {
            Caption = 'Interval Check';
        }
        field(6; "Lab Start Hour"; Boolean)
        {
            Caption = 'Lab Start Hour';
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

