table 72059 Shift
{
    Caption = 'Shift';
    DataClassification = CustomerContent;
    DataCaptionFields = "Location Code", "Salary Plan Code", "Code", Description;
    // DrillDownPageID = 72074;
    LookupPageID = "Shift List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = "Location HR & Payroll Setup";
            ToolTip = 'Specifies the location for the shift.';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
            TableRelation = "Salary Plan";
            ToolTip = 'Specifies the salary plan.';
        }
        field(3; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the shift code.';
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the shift description.';
        }
        field(5; "First Half Starting Time"; Time)
        {
            Caption = 'First Half Starting Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the starting time of the first half.';

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
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the ending time of the first half.';

            trigger OnValidate()
            begin
                "First Half Total Hours" := TotalHours("First Half Starting Time", "First Half Ending Time");
                "Total Hours" := "First Half Total Hours" + "Second Half Total Hours";
            end;
        }
        field(7; "First Half Total Hours"; Decimal)
        {
            Caption = 'First Half Total Hours';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Shows the total hours calculated for the first half.';
        }
        field(8; "Second Half Starting Time"; Time)
        {
            Caption = 'Second Half Starting Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the starting time of the second half.';


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
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the ending time of the second half.';
            trigger OnValidate()
            begin
                "Second Half Total Hours" := TotalHours("Second Half Starting Time", "Second Half Ending Time");
                "Total Hours" := "First Half Total Hours" + "Second Half Total Hours";
            end;
        }
        field(10; "Second Half Total Hours"; Decimal)
        {
            Caption = 'Second Half Total Hours';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Shows the total hours calculated for the second half.';
        }
        field(11; "Break Start Time"; Time)
        {
            Caption = 'Break Start Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the break start time.';

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
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the break end time.';

            trigger OnValidate()
            begin
                "Break Total Hours" := TotalHours("Break Start Time", "Break End Time");
                "Total Hours" := "First Half Total Hours" + "Second Half Total Hours";
            end;
        }
        field(13; "Break Total Hours"; Decimal)
        {
            Caption = 'Break Total Hours';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Shows the total break hours.';
        }
        field(14; "Total Hours"; Decimal)
        {
            Caption = 'Total Hours';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Shows the total working hours excluding break.';
        }
        field(15; "Punch Time Applicable"; Boolean)
        {
            Caption = 'Punch Time Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether punch time tracking is applicable.';
        }
        field(16; "Starting Punching Time"; Time)
        {
            Caption = 'Starting Punching Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the allowed starting punching time.';
        }
        field(17; "Ending Punching Time"; Time)
        {
            Caption = 'Ending Punching Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the allowed ending punching time.';
        }
        field(18; "Morning OT Applicable"; Boolean)
        {
            Caption = 'Morning OT Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether morning overtime is applicable.';
        }
        field(19; "Morning OT Starts From"; Time)
        {
            Caption = 'Morning OT Starts From';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the time from which morning overtime starts.';
        }
        field(20; "Evening OT Applicable"; Boolean)
        {
            Caption = 'Evening OT Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether evening overtime is applicable.';
        }
        field(21; "Evening OT Starts From"; Time)
        {
            Caption = 'Evening OT Starts From';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the time from which evening overtime starts.';
        }
        field(22; "Late Coming Applicable"; Boolean)
        {
            Caption = 'Late Coming Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether late coming rules are applicable.';
        }
        field(23; "Late Coming Time Starts From"; Time)
        {
            Caption = 'Late Coming Time Starts From';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the time from which late coming is considered.';
        }
        field(24; "Early Going Applicable"; Boolean)
        {
            Caption = 'Early Going Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether early going rules are applicable.';
        }
        field(25; "Early Going Time Starts From"; Time)
        {
            Caption = 'Early Going Time Starts From';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the time from which early leaving is considered.';
        }
        field(26; "Friday Over Time"; Boolean)
        {
            Caption = 'Friday Over Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether Friday overtime rules apply.';
        }
        field(27; "Punching Days"; Option)
        {
            Caption = 'Punching Days';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Mon,Tue,Wed,Thu,Fri,Sat,Sun';
            OptionMembers = " ",Mon,Tue,Wed,Thu,Fri,Sat,Sun;
            ToolTip = 'Specifies the punching day.';
        }
        field(28; "Friday Ending Punching Time"; Time)
        {
            Caption = 'Friday Ending Punching Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the ending punching time for Friday.';
        }
        field(29; "Friday Time Limit Evening OT"; Time)
        {
            Caption = 'Friday Time Limit Evening OT';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Friday time limit for evening overtime.';
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

    procedure TotalHours(InTime: Time; OutTime: Time) TotalHoursMins: Decimal
    var
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        Day: Date;
        CheckTime: Time;
        TotalDuration: Integer;
        TotalHoursvar: Integer;
        TotalMins: Integer;
    begin
        Clear(CheckTime);
        Clear(Day);
        Clear(StartDateTime);
        Clear(EndDateTime);
        Clear(TotalDuration);
        Clear(TotalHoursvar);
        Clear(TotalMins);
        Clear(TotalHoursMins);

        if (InTime <> 0T) and (OutTime <> 0T) then begin
            CheckTime := 130000T;
            Day := Today;

            if (InTime > CheckTime) and (OutTime < CheckTime) then begin
                StartDateTime := CreateDateTime(Day, InTime);
                EndDateTime := CreateDateTime((Day + 1), OutTime);
                TotalDuration := (EndDateTime - StartDateTime);
                TotalHoursvar := Round((TotalDuration / 3600000), 1, '<');
                TotalMins := ((TotalDuration - (TotalHoursvar * 3600000)) / 60000);
                TotalHoursMins := TotalHoursvar + (TotalMins / 100);
            end
            else begin
                TotalDuration := (OutTime - InTime);
                TotalHoursvar := Round((TotalDuration / 3600000), 1, '<');
                TotalMins := ((TotalDuration - (TotalHoursvar * 3600000)) / 60000);
                TotalHoursMins := TotalHoursvar + (TotalMins / 100);
            end;
        end;

        if (InTime = 0T) and (OutTime = 0T) then
            TotalHoursMins := 0;
    end;
}

