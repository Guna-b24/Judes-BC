table 72056 "Weekly Off"
{
    Caption = 'Weekly Off';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Calendar Year", "Day No.";

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
        field(4; "Day No."; Integer)
        {
            Caption = 'Day No.';
        }
        field(5; Day; Option)
        {
            Caption = 'Day';
            OptionCaption = ' ,Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday';
            OptionMembers = " ",Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;

            trigger OnValidate()
            begin
                if Day = 0 then
                    "Day No." := 0;
                if Day = 1 then
                    "Day No." := 7;
                if Day = 2 then
                    "Day No." := 1;
                if Day = 3 then
                    "Day No." := 2;
                if Day = 4 then
                    "Day No." := 3;
                if Day = 5 then
                    "Day No." := 4;
                if Day = 6 then
                    "Day No." := 5;
                if Day = 7 then
                    "Day No." := 6;
            end;
        }
        field(6; "Week Wise (Weekly Off)"; Option)
        {
            Caption = 'Week Wise (Weekly Off)';
            OptionCaption = 'All Week,1st-Week,2nd-Week,3rd-Week,4th-Week,5th-Week';
            OptionMembers = "All Week","1st-Week","2nd-Week","3rd-Week","4th-Week","5th-Week";
        }
        field(7; "First Half (Weekly Off)"; Boolean)
        {
            Caption = 'First Half (Weekly Off)';

            trigger OnValidate()
            begin
                if "First Half (Weekly Off)" then
                    "Non Working Days" := true;

                if not "First Half (Weekly Off)" and not "Second Half (Weekly Off)" then
                    "Non Working Days" := false;
            end;
        }
        field(8; "Second Half (Weekly Off)"; Boolean)
        {
            Caption = 'Second Half (Weekly Off)';

            trigger OnValidate()
            begin
                if "Second Half (Weekly Off)" then
                    "Non Working Days" := true;

                if not "First Half (Weekly Off)" and not "Second Half (Weekly Off)" then
                    "Non Working Days" := false;
            end;
        }
        field(9; "Non Working Days"; Boolean)
        {
            Caption = 'Non Working Days';
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Calendar Year", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

