table 72058 Calendar
{
    Caption = 'Calendar';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Calendar Year", Date, Description;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the location for which the calendar is defined.';
            DataClassification = CustomerContent;
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            ToolTip = 'Specifies the salary plan associated with the calendar.';
            DataClassification = CustomerContent;
            TableRelation = "Salary Plan";
        }
        field(3; "Calendar Year"; Code[20])
        {
            Caption = 'Calendar Year';
            ToolTip = 'Specifies the payroll or calendar year.';
            DataClassification = CustomerContent;
            TableRelation = "Payroll Year";
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the calendar date.';
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the calendar day.';
            DataClassification = CustomerContent;
        }
        field(6; "Non-Working Days"; Boolean)
        {
            Caption = 'Non-Working Day';
            ToolTip = 'Specifies whether the date is a non-working day.';
            DataClassification = CustomerContent;
        }
        field(7; Holiday; Boolean)
        {
            Caption = 'Holiday';
            ToolTip = 'Specifies whether the date is a holiday.';
            DataClassification = CustomerContent;
        }
        field(8; "First Half (Holiday)"; Boolean)
        {
            Caption = 'First Half (Holiday)';
            ToolTip = 'Specifies whether the first half of the day is a holiday.';
            DataClassification = CustomerContent;
        }
        field(9; "Second Half (Holiday)"; Boolean)
        {
            Caption = 'Second Half (Holiday)';
            ToolTip = 'Specifies whether the second half of the day is a holiday.';
            DataClassification = CustomerContent;
        }
        field(10; WeeklyOff; Boolean)
        {
            Caption = 'Weekly Off';
            ToolTip = 'Specifies whether the date is a weekly off.';
            DataClassification = CustomerContent;
        }
        field(11; "First Half (Weekly Off)"; Boolean)
        {
            Caption = 'First Half (Weekly Off)';
            ToolTip = 'Specifies whether the first half of the day is a weekly off.';
            DataClassification = CustomerContent;
        }
        field(12; "Second Half (Weekly Off)"; Boolean)
        {
            Caption = 'Second Half (Weekly Off)';
            ToolTip = 'Specifies whether the second half of the day is a weekly off.';
            DataClassification = CustomerContent;
        }
        field(13; "Day No."; Integer)
        {
            Caption = 'Day No.';
            ToolTip = 'Specifies the day number within the calendar year.';
            DataClassification = CustomerContent;
        }
        field(14; "OT Applicable for the Day"; Boolean)
        {
            Caption = 'OT Applicable for the Day';
            ToolTip = 'Specifies whether overtime is applicable for the date.';
            DataClassification = CustomerContent;
        }
        field(15; "Week No."; Integer)
        {
            Caption = 'Week No.';
            ToolTip = 'Specifies the week number of the year for the date.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Date, "Calendar Year", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

