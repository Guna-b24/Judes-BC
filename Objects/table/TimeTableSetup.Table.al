table 71153 "Time Table Setup"
{
    Caption = 'Time Table Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the primary key for the timetable setup record.';
        }
        field(2; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year for the timetable setup.';
            TableRelation = "Academic Year";
        }
        field(3; "Time Table Theory Code"; Code[20])
        {
            Caption = 'Time Table Theory Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the code used for theory periods in the timetable.';
        }
        field(4; "Time Table Lab Code"; Code[20])
        {
            Caption = 'Time Table Lab Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the code used for lab periods in the timetable.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier associated with the record.';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}

