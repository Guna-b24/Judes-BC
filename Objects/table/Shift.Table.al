table 72059 Shift
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.

    Caption = 'Shift';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Code", Description;
    DrillDownPageID = 72074;
    LookupPageID = 72074;

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
        field(3; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "First Half Starting Time"; Time)
        {
            Caption = 'First Half Starting Time';

            trigger OnValidate()
            begin
                if ("First Half Starting Time" = 0T) then begin
                    "First Half Ending Time" := 0T;
                    "First Half Total Hours" := 0;
                end;
            end;
        }
        field(6; "First Half Ending Time"; Time)
        {
            Caption = 'First Half Ending Time';

            trigger OnValidate()
            begin
                "First Half Total Hours" := TotalHours("First Half Starting Time", "First Half Ending Time");
                "Total Hours" := "First Half Total Hours" + "Second Half Total Hours";
            end;
        }
        field(7; "First Half Total Hours"; Decimal)
        {
            Caption = 'First Half Total Hours';
            Editable = false;
        }
        field(8; "Second Half Starting Time"; Time)
        {
            Caption = 'Second Half Starting Time';

            trigger OnValidate()
            begin
                if "Second Half Starting Time" = 0T then begin
                    "Second Half Starting Time" := 0T;
                    "Second Half Total Hours" := 0;
                end;
            end;
        }
        field(9; "Second Half Ending Time"; Time)
        {
            Caption = 'Second Half Ending Time';

            trigger OnValidate()
            begin
                "Second Half Total Hours" := TotalHours("Second Half Starting Time", "Second Half Ending Time");
                "Total Hours" := "First Half Total Hours" + "Second Half Total Hours";
            end;
        }
        field(10; "Second Half Total Hours"; Decimal)
        {
            Caption = 'Second Half Total Hours';
            Editable = false;
        }
        field(11; "Break Start Time"; Time)
        {
            Caption = 'Break Start Time';

            trigger OnValidate()
            begin
                if "Break Start Time" = 0T then begin
                    "Break End Time" := 0T;
                    "Break Total Hours" := 0;
                end;
            end;
        }
        field(12; "Break End Time"; Time)
        {
            Caption = 'Break End Time';

            trigger OnValidate()
            begin
                "Break Total Hours" := TotalHours("Break Start Time", "Break End Time");
                "Total Hours" := "First Half Total Hours" + "Second Half Total Hours";
            end;
        }
        field(13; "Break Total Hours"; Decimal)
        {
            Caption = 'Break Total Hours';
            Editable = false;
        }
        field(14; "Total Hours"; Decimal)
        {
            Caption = 'Total Hours';
            Editable = false;
        }
        field(15; "Punch Time Applicable"; Boolean)
        {
            Caption = 'Punch Time Applicable';
        }
        field(16; "Starting Punching Time"; Time)
        {
            Caption = 'Starting Punching Time';
        }
        field(17; "Ending Punching Time"; Time)
        {
            Caption = 'Ending Punching Time';
        }
        field(18; "Morning OT Applicable"; Boolean)
        {
            Caption = 'Morning OT Applicable';
        }
        field(19; "Morning OT Starts From"; Time)
        {
            Caption = 'Morning OT Starts From';
        }
        field(20; "Evening OT Applicable"; Boolean)
        {
            Caption = 'Evening OT Applicable';
        }
        field(21; "Evening OT Starts From"; Time)
        {
            Caption = 'Evening OT Starts From';
        }
        field(22; "Late Coming Applicable"; Boolean)
        {
            Caption = 'Late Coming Applicable';
        }
        field(23; "Late Coming Time Starts From"; Time)
        {
            Caption = 'Late Coming Time Starts From';
        }
        field(24; "Early Going Applicable"; Boolean)
        {
            Caption = 'Early Going Applicable';
        }
        field(25; "Early Going Time Starts From"; Time)
        {
            Caption = 'Early Going Time Starts From';
        }
        field(26; "Friday Over Time"; Boolean)
        {
            Caption = 'Friday Over Time';
        }
        field(27; "Punching Days"; Option)
        {
            Caption = 'Punching Days';
            OptionCaption = ' ,Mon,Tue,Wed,Thu,Fri,Sat,Sun';
            OptionMembers = " ",Mon,Tue,Wed,Thu,Fri,Sat,Sun;
        }
        field(28; "Friday Ending Punching Time"; Time)
        {
            Caption = 'Friday Ending Punching Time';
        }
        field(29; "Friday Time Limit Evening OT"; Time)
        {
            Caption = 'Friday Time Limit Evening OT';
        }
    }

    keys
    {
        key(Key1; "Code", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    [Scope('Internal')]
    procedure TotalHours(InTime: Time; OutTime: Time) TotalHoursMins: Decimal
    var
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        Day: Date;
        CheckTime: Time;
        TotalDuration: Integer;
        TotalHours: Integer;
        TotalMins: Integer;
    begin
        Clear(CheckTime);
        Clear(Day);
        Clear(StartDateTime);
        Clear(EndDateTime);
        Clear(TotalDuration);
        Clear(TotalHours);
        Clear(TotalMins);
        Clear(TotalHoursMins);

        if (InTime <> 0T) and (OutTime <> 0T) then begin
            CheckTime := 130000T;
            Day := Today;

            if (InTime > CheckTime) and (OutTime < CheckTime) then begin
                StartDateTime := CreateDateTime(Day, InTime);
                EndDateTime := CreateDateTime((Day + 1), OutTime);
                TotalDuration := (EndDateTime - StartDateTime);
                TotalHours := Round((TotalDuration / 3600000), 1, '<');
                TotalMins := ((TotalDuration - (TotalHours * 3600000)) / 60000);
                TotalHoursMins := TotalHours + (TotalMins / 100);
            end
            else begin
                TotalDuration := (OutTime - InTime);
                TotalHours := Round((TotalDuration / 3600000), 1, '<');
                TotalMins := ((TotalDuration - (TotalHours * 3600000)) / 60000);
                TotalHoursMins := TotalHours + (TotalMins / 100);
            end;
        end;

        if (InTime = 0T) and (OutTime = 0T) then
            TotalHoursMins := 0;
    end;
}

