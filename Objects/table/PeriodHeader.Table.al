table 71151 "Period Header"
{
    Caption = 'Period Header';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71151;
    LookupPageID = "Period Header List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique code for the period structure.';
        }
        field(2; "Starting time"; Time)
        {
            Caption = 'Starting time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the starting time of the first period.';
        }
        field(3; "No.Of Periods/Day"; Integer)
        {
            Caption = 'No.Of Periods/Day';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total number of periods in a working day.';
        }
        field(4; "Minutes/Period"; Integer)
        {
            Caption = 'Minutes/Period';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the duration of each period in minutes.';
        }
        field(5; "Interval Start Time"; Time)
        {
            Caption = 'Interval Start Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the starting time of the interval break.';
        }
        field(6; "Interval End Time"; Time)
        {
            Caption = 'Interval End Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the ending time of the interval break.';
        }
        field(7; "Lunch Start Time"; Time)
        {
            Caption = 'Lunch Start Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the starting time of the lunch break.';
        }
        field(8; "Lunch End Time"; Time)
        {
            Caption = 'Lunch End Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the ending time of the lunch break.';
        }
        field(9; "Working Days Per Week"; Integer)
        {
            Caption = 'Working Days Per Week';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number of working days in a week.';
        }
        field(10; "No.Of Periods/Half Day"; Integer)
        {
            Caption = 'No.Of Periods/Half Day';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number of periods applicable for a half working day.';
        }
        field(11; "Max Lab Hours/Day"; Integer)
        {
            Caption = 'Max Lab Hours/Day';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the maximum number of laboratory hours allowed per day.';
        }
        field(12; "End time"; Time)
        {
            Caption = 'End time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the ending time of the last period.';
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year for which this period structure is defined.';
            TableRelation = "Academic Year"; // adjust if different table name
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier associated with this period header.';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        EduSetup.Get();
        "Academic Year" := EduSetup."Academic Year";
    end;

    var
        EduSetup: Record "Education Setup";
}

