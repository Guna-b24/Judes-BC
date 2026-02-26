table 72027 "Daily BioMetric Info"
{
    Caption = 'Daily BioMetric Info';
    LookupPageId = "Daily BioMetric Info List";

    fields
    {
        field(1; StaffId; Text[20])
        {
            Caption = 'StaffId';
        }
        field(2; "Attendance Date"; Date)
        {
            Caption = 'Attendance Date';
        }
        field(3; "Attendance Time"; Time)
        {
            Caption = 'Attendance Time';
        }
    }

    keys
    {
        key(Key1; StaffId, "Attendance Date", "Attendance Time")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

