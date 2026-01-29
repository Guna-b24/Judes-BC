table 72080 "Daily Attendance"
{
    Caption = 'Daily Attendance';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Salary Cyclic Code", "Employee No", Name;
    DrillDownPageID = 72112;
    LookupPageID = 72112;

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
        field(3; "Salary Cyclic Code"; Code[20])
        {
            Caption = 'Salary Cyclic Code';
            TableRelation = "Payroll Month & Year"."Salary Cyclic Code" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                               "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(4; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;
        }
        field(5; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(6; "Attendance Date"; Date)
        {
            Caption = 'Attendance Date';
        }
        field(7; "In Time"; Time)
        {
            Caption = 'In Time';

            trigger OnValidate()
            begin
                Validate("Out Time");
            end;
        }
        field(8; "Out Time"; Time)
        {
            Caption = 'Out Time';

            trigger OnValidate()
            var
                LateComingDuration: Integer;
            begin
                if "Shift Code" <> '' then begin
                    Shift.Get("Shift Code", "Location Code", "Salary Plan Code");

                    if ("In Time" <> 0T) or ("Out Time" = 0T) then
                        if Shift."Late Coming Applicable" then
                            if "In Time" > Shift."Late Coming Time Starts From" then begin
                                LateComingDuration := "In Time" - Shift."Late Coming Time Starts From";
                                "Late Coming Hours" := TotalHoursCalculation("In Time" - Shift."Late Coming Time Starts From");
                            end;
                end;

                if ("In Time" = 0T) and ("Out Time" = 0T) then begin
                    "Late Coming Hours" := 0;
                    "Early Going Hours" := 0;
                    "Early OT Hours" := 0;

                    "Total Permission In Mins" := 0;
                    "Total OT In Mins" := 0;
                    "Hours Worked" := 0;
                    "Total Hours Worked" := 0;
                end;

                if ("In Time" <> 0T) and ("Out Time" <> 0T) then
                    CalculateAllHours;

                if not "Non Working Day" then
                    if ("In Time" = 0T) and ("Out Time" = 0T) then begin
                        "Hours Worked" := 0;
                        "Total Hours Worked" := 0;
                        "First Half Attendance Type" := "First Half Attendance Type"::Absent;
                        "Second Half Attendance Type" := "Second Half Attendance Type"::Absent;
                        Validate("First Half Attendance Type");
                        Validate("Second Half Attendance Type");
                    end;

                if "Weekly Off Status" then begin
                    "First Half Attendance Type" := "First Half Attendance Type"::"Weekly Off";
                    "Second Half Attendance Type" := "Second Half Attendance Type"::"Weekly Off";
                    Validate("First Half Attendance Type");
                    Validate("Second Half Attendance Type");
                end;

                if "Holiday Status" then begin
                    "First Half Attendance Type" := "First Half Attendance Type"::Holiday;
                    "Second Half Attendance Type" := "Second Half Attendance Type"::Holiday;
                    Validate("First Half Attendance Type");
                    Validate("Second Half Attendance Type");
                end;

                if "Lay Off (Yes/No)" then
                    Validate("Lay Off (Yes/No)");
            end;
        }
        field(9; "Hours Worked"; Decimal)
        {
            Caption = 'Hours Worked';
            Editable = false;
        }
        field(10; "Actual Hrs"; Decimal)
        {
            Caption = 'Actual Hrs';
            Editable = false;
        }
        field(11; "Total OT In Mins"; Decimal)
        {
            Caption = 'Total OT In Mins';
            Editable = false;
        }
        field(12; "OT Approved Hrs"; Decimal)
        {
            Caption = 'OT Approved Hrs';
            Editable = false;
        }
        field(13; "Total Hours Worked"; Decimal)
        {
            Caption = 'Total Hours Worked';
            Editable = false;
        }
        field(14; "First Half Attendance Type"; Option)
        {
            Caption = 'First Half Attendance Type';
            OptionCaption = ' ,Present,Absent,Leave,Weekly Off,Holiday,On-Duty,Not Joined,Relieved,Lay Off';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved,"Lay Off";

            trigger OnValidate()
            begin
                ValidateAttendanceType;
            end;
        }
        field(15; "Second Half Attendance Type"; Option)
        {
            Caption = 'Second Half Attendance Type';
            OptionCaption = ' ,Present,Absent,Leave,Weekly Off,Holiday,On-Duty,Not Joined,Relieved,Lay Off';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved,"Lay Off";

            trigger OnValidate()
            begin
                ValidateAttendanceType;
            end;
        }
        field(16; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
        }
        field(17; Present; Decimal)
        {
            Caption = 'Present';
        }
        field(18; Absent; Decimal)
        {
            Caption = 'Absent';
        }
        field(19; Leave; Decimal)
        {
            Caption = 'Leave';
        }
        field(20; "Weekly Off"; Decimal)
        {
            Caption = 'Weekly Off';
        }
        field(21; Holiday; Decimal)
        {
            Caption = 'Holiday';
        }
        field(22; "On-Duty"; Decimal)
        {
            Caption = 'On-Duty';
        }
        field(23; "Not Joined"; Decimal)
        {
            Caption = 'Not Joined';
        }
        field(24; Relieved; Decimal)
        {
            Caption = 'Relieved';
        }
        field(25; "Payable Days"; Decimal)
        {
            Caption = 'Payable Days';
        }
        field(26; "Non Payable Days"; Decimal)
        {
            Caption = 'Non Payable Days';
        }
        field(27; "Permission (Yes/No)"; Boolean)
        {
            Caption = 'Permission (Yes/No)';

            trigger OnValidate()
            begin
                if "Permission (Yes/No)" then
                    Reason := 'Personal Work / Late'
                else
                    Reason := '';
            end;
        }
        field(28; "Total Permission In Mins"; Decimal)
        {
            Caption = 'Total Permission In Mins';

            trigger OnValidate()
            begin
                if "Total Permission In Mins" > 0 then begin
                    "Permission (Yes/No)" := true;
                    Reason := 'Personal Work / Late';
                end
                else begin
                    "Permission (Yes/No)" := false;
                    Reason := '';
                end;
            end;
        }
        field(29; Reason; Text[30])
        {
            Caption = 'Reason';
        }
        field(30; "Actual Time In"; Time)
        {
            Caption = 'Actual Time In';
        }
        field(31; "Actual Time Out"; Time)
        {
            Caption = 'Actual Time Out';
        }
        field(32; "Total Break Hours"; Decimal)
        {
            Caption = 'Total Break Hours';
            Editable = false;
        }
        field(33; Activity; Integer)
        {
            CalcFormula = Count ("Time Sheet" WHERE ("Location Code" = FIELD ("Location Code"),
                                                    "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                    "Employee No" = FIELD ("Employee No"),
                                                    "Attend Date" = FIELD ("Attendance Date")));
            Caption = 'Activity';
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Shift Code"; Code[20])
        {
            Caption = 'Shift Code';
            TableRelation = Shift;
        }
        field(35; "Day No."; Integer)
        {
            Caption = 'Day No.';
        }
        field(36; "Week No"; Integer)
        {
            Caption = 'Week No';
        }
        field(37; Year; Integer)
        {
            Caption = 'Year';
        }
        field(38; Month; Integer)
        {
            Caption = 'Month';
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
        }
        field(39; "Leave Year Code"; Code[10])
        {
            Caption = 'Leave Year Code';
            Editable = false;
        }
        field(40; Synchronize; Boolean)
        {
            Caption = 'Synchronize';
        }
        field(41; "Late Coming Hours"; Decimal)
        {
            Caption = 'Late Coming Hours';
        }
        field(42; "Early Going Hours"; Decimal)
        {
            Caption = 'Early Going Hours';
        }
        field(43; "Early OT Hours"; Decimal)
        {
            Caption = 'Early OT Hours';
        }
        field(44; "Late OT Hours"; Decimal)
        {
            Caption = 'Late OT Hours';
        }
        field(45; "Weekly Off Status"; Boolean)
        {
            Caption = 'Weekly Off Status';
        }
        field(46; "Holiday Status"; Boolean)
        {
            Caption = 'Holiday Status';
        }
        field(47; "Non Working Day"; Boolean)
        {
            Caption = 'Non Working Day';
        }
        field(48; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary,Class III Permanent,Class III Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary","Class III Permanent","Class III Temporary";
        }
        field(49; "Lay Off"; Decimal)
        {
            Caption = 'Lay Off';
        }
        field(50; "Manual Entry"; Boolean)
        {
            Caption = 'Manual Entry';
            Editable = false;
        }
        field(51; "System Entry"; Boolean)
        {
            Caption = 'System Entry';
            Editable = false;
        }
        field(52; "Attendance Verified"; Boolean)
        {
            Caption = 'Attendance Verified';
            Editable = false;
        }
        field(53; "Lay Off (Yes/No)"; Boolean)
        {
            Caption = 'Lay Off (Yes/No)';

            trigger OnValidate()
            begin
                if "Lay Off (Yes/No)" then begin
                    "First Half Attendance Type" := "First Half Attendance Type"::"Lay Off";
                    "Second Half Attendance Type" := "Second Half Attendance Type"::"Lay Off";
                    Validate("First Half Attendance Type");
                    Validate("Second Half Attendance Type");
                end;

                if not "Lay Off (Yes/No)" then begin
                    Validate("In Time");
                    Validate("Out Time");
                end;
            end;
        }
        field(54; "Comp Off Date"; Date)
        {
            Caption = 'Comp Off Date';
        }
        field(55; "Punch Total Mins Worked"; Decimal)
        {
            Caption = 'Punch Total Mins Worked';
            Editable = false;
        }
        field(56; "Salary Processed"; Boolean)
        {
        }
        field(57; "Leave Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Full Day,First Half Day,Second Half Day';
            OptionMembers = " ","Full Day","First Half Day","Second Half Day";

            trigger OnValidate()
            begin
                if "Leave Type" = "Leave Type"::" " then
                    "Leave Availed" := 0;

                if "Leave Type" = "Leave Type"::"Full Day" then
                    "Leave Availed" := 1;

                if "Leave Type" = "Leave Type"::"First Half Day" then
                    "Leave Availed" := 0.5;

                if "Leave Type" = "Leave Type"::"Second Half Day" then
                    "Leave Availed" := 0.5;
            end;
        }
        field(58; "Leave Application No"; Code[20])
        {
            Editable = false;
        }
        field(59; "Leave Availed"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Attendance Date", "Salary Cyclic Code", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
        key(Key2; Present, Absent, Leave, "Weekly Off", Holiday, "On-Duty")
        {
            SumIndexFields = Present, Absent, Leave, "Weekly Off", Holiday, "On-Duty";
        }
        key(Key3; "Not Joined", Relieved, "Payable Days", "Total OT In Mins", "Total Permission In Mins", "Lay Off")
        {
            SumIndexFields = "Not Joined", Relieved, "Payable Days", "Total OT In Mins", "Total Permission In Mins", "Lay Off";
        }
        key(Key4; "Location Code", "Salary Plan Code", "Leave Code", "Leave Year Code")
        {
            SumIndexFields = "Leave Availed";
        }
        key(Key5; "Attendance Date", "Location Code", "Salary Plan Code", "Salary Cyclic Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CheckTime: Time;
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        Shift: Record Shift;
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";

    [Scope('Internal')]
    procedure TotalHoursCalculation(TotalDuration: Integer): Decimal
    var
        TotalMins: Integer;
        TotalHrsMins: Decimal;
        TotalMiliSec: Integer;
        TotalRestSec: Integer;
        TotalSec: Integer;
        TotalRestMin: Integer;
        TotalMin: Integer;
        TotalRestHour: Integer;
    begin
        TotalMiliSec := TotalDuration mod 1000;
        TotalRestSec := TotalDuration div 1000;
        TotalSec := TotalRestSec mod 60;
        TotalRestMin := TotalRestSec div 60;
        TotalMin := TotalRestMin mod 60;
        TotalRestHour := TotalRestMin div 60;

        TotalHrsMins := TotalRestHour + (TotalMin / 100);
        exit(TotalHrsMins);
    end;

    [Scope('Internal')]
    procedure CalculateAllHours()
    var
        PersonInoutTotalDuration: Integer;
        BreakTotalDuration: Integer;
        PersonInOutDuration: Integer;
        BreakInOutDuration: Integer;
        LateComingDuration: Integer;
        EarlyGoingDuration: Integer;
        EarlyOTDuration: Integer;
        LateOTDuration: Integer;
        Employee: Record Employee;
        TotalOTHours: Decimal;
    begin
        HRPayrollSetup.Get(UserId);
        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");

        Employee.Get("Employee No");

        if "Shift Code" = '' then
            "Shift Code" := Employee."Working Shift Code";

        Shift.Get("Shift Code", "Location Code", "Salary Plan Code");

        Clear(PersonInoutTotalDuration);
        Clear(BreakTotalDuration);
        Clear(PersonInOutDuration);
        Clear(BreakInOutDuration);
        Clear(LateComingDuration);
        Clear(EarlyGoingDuration);
        Clear(EarlyOTDuration);
        Clear(LateOTDuration);

        Clear("Total Hours Worked");
        Clear("Late Coming Hours");
        Clear("Early Going Hours");
        Clear("Total Permission In Mins");
        Clear("Early OT Hours");
        Clear("Late OT Hours");
        Clear("Total Break Hours");
        Clear("Total OT In Mins");
        Clear(TotalOTHours);

        //-- Total Hours Calculation.

        PersonInOutDuration := "Out Time" - "In Time";
        "Hours Worked" := TotalHoursCalculation(PersonInOutDuration);

        //-- Break Hours Calculation.
        if (Shift."Break Start Time" <> 0T) and (Shift."Break End Time" <> 0T) then begin
            BreakInOutDuration := Shift."Break End Time" - Shift."Break Start Time";
            "Total Break Hours" := TotalHoursCalculation(BreakInOutDuration);
        end;

        "Total Hours Worked" := TotalHoursCalculation(PersonInOutDuration - BreakInOutDuration);

        if "Total Hours Worked" < 0 then
            "Total Hours Worked" := 0;

        // Permission Calculation.

        if Shift."Late Coming Applicable" then
            if "In Time" > Shift."Late Coming Time Starts From" then begin
                LateComingDuration := "In Time" - Shift."Late Coming Time Starts From";
                "Late Coming Hours" := TotalHoursCalculation("In Time" - Shift."Late Coming Time Starts From");
            end;

        //MESSAGE('Allow Early => %1  PersonOuttime => %2 ',AllowableEarlyGoingTime,PersonOutTime);

        if Shift."Early Going Applicable" then
            if "Out Time" < Shift."Late Coming Time Starts From" then begin
                EarlyGoingDuration := Shift."Late Coming Time Starts From" - "Out Time";
                "Early Going Hours" := TotalHoursCalculation(Shift."Late Coming Time Starts From" - "Out Time");
            end;

        "Total Permission In Mins" := (LateComingDuration + EarlyGoingDuration) / 60000;

        //-- OverTime Calculation.

        //MESSAGE('Time Starts Before => %1  PersonIntime => %2 ',EarlyOTTime,PersonInTime);

        if Shift."Morning OT Applicable" then
            if "In Time" < Shift."Morning OT Starts From" then begin
                EarlyOTDuration := Shift."Morning OT Starts From" - "In Time";
                "Early OT Hours" := TotalHoursCalculation(Shift."Morning OT Starts From" - "In Time");
            end;

        //MESSAGE('Time Starts Before => %1  PersonOuttime => %2 ',LateOTTime,PersonOutTime);

        if Shift."Evening OT Applicable" then
            if "Out Time" > Shift."Evening OT Starts From" then begin
                LateOTDuration := "Out Time" - Shift."Evening OT Starts From";
                "Late OT Hours" := TotalHoursCalculation("Out Time" - Shift."Evening OT Starts From");
            end;

        "Total OT In Mins" := (EarlyOTDuration + LateOTDuration) / 60000;

        //-- New Changes for HTC Footwear Division on 29/12/2009

        if Shift."Friday Over Time" then begin
            Clear(LateOTDuration);
            if "Day No." = Shift."Punching Days" then
                if Shift."Friday Ending Punching Time" <> 0T then begin
                    if "Out Time" > Shift."Friday Time Limit Evening OT" then begin
                        LateOTDuration := "Out Time" - Shift."Friday Ending Punching Time";
                        "Late OT Hours" := TotalHoursCalculation("Out Time" - Shift."Friday Ending Punching Time");
                    end;
                    "Total OT In Mins" := (EarlyOTDuration + LateOTDuration) / 60000;
                end;
        end;

        if "Total OT In Mins" <= LocationHRPayrollSetup."Over Time Min Minutes" then
            "Total OT In Mins" := 0;

        if Employee."Extra Allowance Applicable" then
            "Total OT In Mins" := 0;

        if "Non Working Day" then begin
            if Employee."Extra Allowance Applicable" then begin
                if ("Total Hours Worked" > LocationHRPayrollSetup."Extra Wages Min Hours") and
                    ("Total Hours Worked" < LocationHRPayrollSetup."Extra Wages Max Hours")
                then
                    "Total OT In Mins" := LocationHRPayrollSetup."Ex.Wages Days Min 3 To 6 Hours";

                if "Total Hours Worked" > LocationHRPayrollSetup."Extra Wages Max Hours" then
                    "Total OT In Mins" := LocationHRPayrollSetup."Ex.Wages Days 6 Hours Above";
            end;

            if Employee."OT Type" = Employee."OT Type"::"Hourly Based" then
                "Total OT In Mins" := "Convert Hours To Mins"("Total Hours Worked");

            "Total Permission In Mins" := 0;
            "Late Coming Hours" := 0;
            "Early Going Hours" := 0;
        end;

        //-- New Changes for HTC Footwear Division on 30/12/2009
        if not Employee."Extra Allowance Applicable" then
            if LocationHRPayrollSetup."Over Time Hours Round Off" then begin
                TotalOTHours := "Convert Mins To Hours"("Total OT In Mins");
                TotalOTHours := Round(TotalOTHours, 1, '<');
                "Total OT In Mins" := "Convert Hours To Mins"(TotalOTHours);
            end;

        //-- Holiday OT & Weekly off Over Time

        //--------------------------------

        if "Hours Worked" < LocationHRPayrollSetup."Absent Hours Limit" then begin
            "First Half Attendance Type" := "First Half Attendance Type"::Absent;
            "Second Half Attendance Type" := "Second Half Attendance Type"::Absent;
            Validate("First Half Attendance Type");
            Validate("Second Half Attendance Type");
        end;

        if "Hours Worked" > LocationHRPayrollSetup."Absent Hours Limit" then begin
            "First Half Attendance Type" := "First Half Attendance Type"::Present;
            "Second Half Attendance Type" := "Second Half Attendance Type"::Present;
            Validate("First Half Attendance Type");
            Validate("Second Half Attendance Type");
        end;

        if ("Hours Worked" >= LocationHRPayrollSetup."Absent Hours Limit") and
           ("Hours Worked" <= LocationHRPayrollSetup."No of Hours in Half Day")
        then begin
            "First Half Attendance Type" := "First Half Attendance Type"::Present;
            "Second Half Attendance Type" := "Second Half Attendance Type"::Absent;
            Validate("First Half Attendance Type");
            Validate("Second Half Attendance Type");
        end;

        /*
        IF "Early Going Hours" > LocationHRPayrollSetup."Early Going Permission Limit" THEN BEGIN
          "First Half Attendance Type" := "First Half Attendance Type"::Present;
          "Second Half Attendance Type" := "Second Half Attendance Type"::Absent;
          VALIDATE("First Half Attendance Type");
          VALIDATE("Second Half Attendance Type");
        END;
        
        IF "Late Coming Hours" > LocationHRPayrollSetup."Late Coming Permission Limit" THEN BEGIN
          "First Half Attendance Type" := "First Half Attendance Type"::Absent;
          "Second Half Attendance Type" := "Second Half Attendance Type"::Present;
          VALIDATE("First Half Attendance Type");
          VALIDATE("Second Half Attendance Type");
        END;
        */

    end;

    [Scope('Internal')]
    procedure ValidateAttendanceType()
    begin
        Present := 0;
        Absent := 0;
        Leave := 0;
        "Weekly Off" := 0;
        Holiday := 0;
        "On-Duty" := 0;
        "Not Joined" := 0;
        Relieved := 0;
        "Lay Off" := 0;

        if "First Half Attendance Type" = "First Half Attendance Type"::Present then begin
            Present := 0.5;
            "Payable Days" := 0.5;
        end;

        if "Second Half Attendance Type" = "Second Half Attendance Type"::Present then begin
            Present := 0.5;
            "Payable Days" := 0.5;

            if "First Half Attendance Type" = "First Half Attendance Type"::Present then begin
                Present := 1;
                "Payable Days" := 1;
                "Non Payable Days" := 0;
            end;
        end;

        if "First Half Attendance Type" = "First Half Attendance Type"::Absent then begin
            Absent := 0.5;
            "Non Payable Days" := 0.5;
        end;

        if "Second Half Attendance Type" = "Second Half Attendance Type"::Absent then begin
            Absent := 0.5;
            "Non Payable Days" := 0.5;
            if "First Half Attendance Type" = "First Half Attendance Type"::Absent then begin
                Absent := 1;
                "Payable Days" := 0;
                "Non Payable Days" := 1;
            end;
        end;

        if "First Half Attendance Type" = "First Half Attendance Type"::Leave then begin
            Leave := 0.5;
            "Payable Days" := 0.5;
        end;

        if "Second Half Attendance Type" = "Second Half Attendance Type"::Leave then begin
            if "Payable Days" = 0.5 then begin
                Leave := 0.5;
                "Payable Days" := 1;
            end else begin
                Leave := 0.5;
                "Payable Days" := 0.5;
                "Non Payable Days" := 0;
            end;

            if "First Half Attendance Type" = "First Half Attendance Type"::Leave then begin
                Leave := 1;
                "Payable Days" := 1;
            end;
        end;

        if "First Half Attendance Type" = "First Half Attendance Type"::"Weekly Off" then begin
            "Weekly Off" := 0.5;
            "Payable Days" := 0.5;
        end;

        if "Second Half Attendance Type" = "Second Half Attendance Type"::"Weekly Off" then begin
            if "Payable Days" = 0.5 then begin
                "Weekly Off" := 0.5;
                "Payable Days" := 1;
                "Non Payable Days" := 0;
            end else begin
                "Weekly Off" := 0.5;
                "Payable Days" := 0.5;
            end;

            if "First Half Attendance Type" = "First Half Attendance Type"::"Weekly Off" then begin
                "Weekly Off" := 1;
                "Payable Days" := 1;
                "Non Payable Days" := 0;
            end;
        end;

        if "First Half Attendance Type" = "First Half Attendance Type"::Holiday then begin
            Holiday := 0.5;
            "Payable Days" := 0.5;
        end;

        if "Second Half Attendance Type" = "Second Half Attendance Type"::Holiday then begin
            if "Payable Days" = 0.5 then begin
                Holiday := 0.5;
                "Payable Days" := 1;
                "Non Payable Days" := 0;
            end else begin
                Holiday := 0.5;
                "Payable Days" := 0.5;
            end;

            if "First Half Attendance Type" = "First Half Attendance Type"::Holiday then begin
                Holiday := 1;
                "Payable Days" := 1;
                "Non Payable Days" := 0;
            end;
        end;

        if "First Half Attendance Type" = "First Half Attendance Type"::"On-Duty" then begin
            "On-Duty" := 0.5;
            "Payable Days" := 0.5;
        end;

        if "Second Half Attendance Type" = "Second Half Attendance Type"::"On-Duty" then begin
            if "Payable Days" = 0.5 then begin
                "On-Duty" := 0.5;
                "Payable Days" := 1;
            end else begin
                "On-Duty" := 0.5;
                "Payable Days" := 0.5;
            end;

            if "First Half Attendance Type" = "First Half Attendance Type"::"On-Duty" then begin
                "On-Duty" := 1;
                "Payable Days" := 1;
                "Non Payable Days" := 0;
            end;
        end;

        if "First Half Attendance Type" = "First Half Attendance Type"::"Not Joined" then begin
            "Second Half Attendance Type" := "Second Half Attendance Type"::"Not Joined";
            Present := 0;
            Absent := 0;
            Leave := 0;
            "Weekly Off" := 0;
            Holiday := 0;
            "On-Duty" := 0;
            Relieved := 0;
            "Lay Off" := 0;
            "Payable Days" := 0;
            "Not Joined" := 1;
            "Payable Days" := 0;
            "Non Payable Days" := 1;
        end;

        if "First Half Attendance Type" = "First Half Attendance Type"::Relieved then begin
            "Second Half Attendance Type" := "Second Half Attendance Type"::Relieved;
            Present := 0;
            Absent := 0;
            Leave := 0;
            "Weekly Off" := 0;
            Holiday := 0;
            "On-Duty" := 0;
            "Not Joined" := 0;
            "Lay Off" := 0;
            "Payable Days" := 0;
            Relieved := 1;
            "Payable Days" := 0;
            "Non Payable Days" := 1;
        end;

        if "First Half Attendance Type" = "First Half Attendance Type"::"Lay Off" then begin
            "Second Half Attendance Type" := "Second Half Attendance Type"::"Lay Off";
            "Lay Off" := 1;
            //   "Payable Days" := 0.5;
            "Payable Days" := 0;
            Present := 0;
            Absent := 0;
            Leave := 0;
            "Weekly Off" := 0;
            Holiday := 0;
            "On-Duty" := 0;
            "Not Joined" := 0;
            Relieved := 0;
            "Non Payable Days" := 0;
        end;
    end;

    [Scope('Internal')]
    procedure "Convert Mins To Hours"(TotalHrsMins: Decimal): Decimal
    var
        ConvertHours: Decimal;
        DecimalPart: Decimal;
        IntegerPart: Integer;
    begin
        Clear(ConvertHours);
        Clear(DecimalPart);
        Clear(IntegerPart);

        DecimalPart := TotalHrsMins mod 60;
        IntegerPart := TotalHrsMins - DecimalPart;
        IntegerPart := IntegerPart / 60;
        ConvertHours := IntegerPart + (DecimalPart / 100);

        exit(ConvertHours);
    end;

    [Scope('Internal')]
    procedure "Convert Hours To Mins"(TotalHrsMins: Decimal): Decimal
    var
        ConvertHours: Decimal;
        DecimalPart: Decimal;
        IntegerPart: Integer;
    begin
        Clear(ConvertHours);
        Clear(DecimalPart);
        Clear(IntegerPart);

        ConvertHours := TotalHrsMins * 100;
        DecimalPart := ConvertHours mod 100;
        DecimalPart := DecimalPart / 100;
        IntegerPart := TotalHrsMins - DecimalPart;
        ConvertHours := (IntegerPart * 60) + (DecimalPart * 100);

        exit(ConvertHours);
    end;
}

