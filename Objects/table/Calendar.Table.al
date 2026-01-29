table 72058 Calendar
{
    Caption = 'Calendar';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Calendar Year", Date, Description;

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
        field(3; "Calendar Year"; Code[20])
        {
            Caption = 'Calendar Year';
            TableRelation = "Payroll Year";
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; "Non-Working Days"; Boolean)
        {
            Caption = 'Non-Working Days';
        }
        field(7; Holiday; Boolean)
        {
            Caption = 'Holiday';
        }
        field(8; "First Half (Holiday)"; Boolean)
        {
            Caption = 'First Half (Holiday)';
        }
        field(9; "Second Half (Holiday)"; Boolean)
        {
            Caption = 'Second Half (Holiday)';
        }
        field(10; WeeklyOff; Boolean)
        {
            Caption = 'WeeklyOff';
        }
        field(11; "First Half (Weekly Off)"; Boolean)
        {
            Caption = 'First Half (Weekly Off)';
        }
        field(12; "Second Half (Weekly Off)"; Boolean)
        {
            Caption = 'Second Half (Weekly Off)';
        }
        field(13; "Day No."; Integer)
        {
            Caption = 'Day No.';
        }
        field(14; "OT Applicable for the Day"; Boolean)
        {
            Caption = 'OT Applicable for the Day';
        }
        field(15; "Week No."; Integer)
        {
            Caption = 'Week No.';
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

