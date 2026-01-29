table 71151 "Period Header"
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'Period Header';
    DrillDownPageID = 71151;
    LookupPageID = 71151;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Starting time"; Time)
        {
            Caption = 'Starting time';
        }
        field(3; "No.Of Periods/Day"; Integer)
        {
            Caption = 'No.Of Periods/Day';
        }
        field(4; "Minutes/Period"; Integer)
        {
            Caption = 'Minutes/Period';
        }
        field(5; "Interval Start Time"; Time)
        {
            Caption = 'Interval Start Time';
        }
        field(6; "Interval End Time"; Time)
        {
            Caption = 'Interval End Time';
        }
        field(7; "Lunch Start Time"; Time)
        {
            Caption = 'Lunch Start Time';
        }
        field(8; "Lunch End Time"; Time)
        {
            Caption = 'Lunch End Time';
        }
        field(9; "Working Days Per Week"; Integer)
        {
            Caption = 'Working Days Per Week';
        }
        field(10; "No.Of Periods/Half Day"; Integer)
        {
            Caption = 'No.Of Periods/Half Day';
        }
        field(11; "Max Lab Hours/Day"; Integer)
        {
            Caption = 'Max Lab Hours/Day';
        }
        field(12; "End time"; Time)
        {
            Caption = 'End time';
        }
        field(13; "Academic Year"; Code[20])
        {
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
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
        // Start 01. VANDHANA

        "User ID" := UserId;

        // Stop 01. VANDHANA

        EduSetup.Get;
        "Academic Year" := EduSetup."Academic Year";
    end;

    var
        EduSetup: Record "Education Setup";
}

