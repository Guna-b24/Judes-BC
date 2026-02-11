table 72069 "Leave Master"
{
    Caption = 'Leave Master';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Leave Code", Description;
    DataClassification = CustomerContent;
    // DrillDownPageID = 72096;
    // LookupPageID = 72096;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the location for which the leave is defined.';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
        }

        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            ToolTip = 'Specifies the salary plan applicable for this leave.';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }

        field(3; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            ToolTip = 'Specifies the unique code for the leave type.';
            DataClassification = CustomerContent;
        }

        field(4; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the leave.';
            DataClassification = CustomerContent;
        }

        field(5; Regular; Boolean)
        {
            Caption = 'Regular';
            ToolTip = 'Specifies whether this leave is applicable for regular employees.';
            DataClassification = CustomerContent;
        }
        field(6; "Total Leaves in a Year Regular"; Decimal)
        {
            Caption = 'Total Leaves in a Year (Regular)';
            ToolTip = 'Shows the total number of leaves credited in a year for regular employees.';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(7; "Credit Interval Regular"; DateFormula)
        {
            Caption = 'Credit Interval (Regular)';
            ToolTip = 'Specifies the interval at which leave is credited for regular employees.';
            DataClassification = CustomerContent;


            trigger OnValidate()
            begin
                "Calculate Leave Days Year Reg"();
            end;
        }
        field(8; "Leave in a Credit Int. Regular"; Decimal)
        {
            Caption = 'Leave per Credit Interval (Regular)';
            ToolTip = 'Specifies the number of leaves credited per interval for regular employees.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Calculate Leave Days Year Reg"();
            end;
        }
        field(9; Probationary; Boolean)
        {
            Caption = 'Probationary';
            ToolTip = 'Specifies whether this leave is applicable for probationary employees.';
            DataClassification = CustomerContent;
        }

        field(10; "Total Leaves in a Year Prob."; Decimal)
        {
            Caption = 'Total Leaves in a Year (Probation)';
            ToolTip = 'Shows the total number of leaves credited in a year for probationary employees.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; "Credit Interval Prob."; DateFormula)
        {
            Caption = 'Credit Interval (Probation)';
            ToolTip = 'Specifies the interval at which leave is credited for probationary employees.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Calculate Leave Days Year Pro"();
            end;
        }
        field(12; "Leave in a Credit Int. Prob."; Decimal)
        {
            Caption = 'Leave per Credit Interval (Probation)';
            ToolTip = 'Specifies the number of leaves credited per interval for probationary employees.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Calculate Leave Days Year Pro"();
            end;
        }
        field(13; "Encash Leave"; Boolean)
        {
            Caption = 'Encash Leave';
            ToolTip = 'Specifies whether this leave can be encashed.';
            DataClassification = CustomerContent;
        }

        field(14; "Maximum Encash Leave"; Decimal)
        {
            Caption = 'Maximum Encash Leave';
            ToolTip = 'Specifies the maximum number of leaves that can be encashed.';
            DataClassification = CustomerContent;
        }

        field(15; "Carry Forward"; Boolean)
        {
            Caption = 'Carry Forward';
            ToolTip = 'Specifies whether unused leave can be carried forward.';
            DataClassification = CustomerContent;
        }

        field(16; "Paid Leave"; Boolean)
        {
            Caption = 'Paid Leave';
            ToolTip = 'Specifies whether this leave is paid.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "UnPaid Leave" := false;
            end;
        }
        field(17; "UnPaid Leave"; Boolean)
        {
            Caption = 'Unpaid Leave';
            ToolTip = 'Specifies whether this leave is unpaid.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Paid Leave" := false;
            end;
        }
        field(18; "Create Leave Balance"; Boolean)
        {
            Caption = 'Create Leave Balance';
            ToolTip = 'Specifies whether leave balance should be created automatically.';
            DataClassification = CustomerContent;
        }

        field(19; "Full Day"; Boolean)
        {
            Caption = 'Full Day';
            ToolTip = 'Specifies whether the leave is treated as a full-day leave.';
            DataClassification = CustomerContent;
        }
        field(20; "Mark As Full Day First Half"; Option)
        {
            Caption = 'Mark As Full Day (First Half)';
            ToolTip = 'Specifies the attendance status for the first half when marked as full day.';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
            DataClassification = CustomerContent;
        }

        field(21; "Mark As Full Day Secod Half"; Option)
        {
            Caption = 'Mark As Full Day (Second Half)';
            ToolTip = 'Specifies the attendance status for the second half when marked as full day.';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
            DataClassification = CustomerContent;
        }

        field(22; "First Half Day"; Boolean)
        {
            Caption = 'First Half Day';
            ToolTip = 'Specifies whether the leave is applicable for the first half of the day.';
            DataClassification = CustomerContent;
        }

        field(23; "I'st Mark As First Half Day"; Option)
        {
            Caption = 'First Half – Mark As';
            ToolTip = 'Specifies the attendance status for the first half of the day.';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
            DataClassification = CustomerContent;
        }

        field(24; "I'st Mark As Second Half Day"; Option)
        {
            Caption = 'Second Half – Mark As';
            ToolTip = 'Specifies the attendance status for the second half of the day.';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
            DataClassification = CustomerContent;
        }

        field(25; "Second Half Day"; Boolean)
        {
            Caption = 'Second Half Day';
            ToolTip = 'Specifies whether the leave is applicable for the second half of the day.';
            DataClassification = CustomerContent;
        }
        field(26; "II'nd Mark As First Half Day"; Option)
        {
            Caption = 'Second Day – First Half';
            ToolTip = 'Specifies the attendance status for the first half of the second day.';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
            DataClassification = CustomerContent;
        }

        field(27; "II'nd Mark As Second Half Day"; Option)
        {
            Caption = 'Second Day – Second Half';
            ToolTip = 'Specifies the attendance status for the second half of the second day.';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Leave Code", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        NoofMonths: Integer;
        TempDate: Date;
        TempDate1: Date;

    procedure "Calculate Leave Days Year Reg"()
    begin
        if Format("Credit Interval Regular") <> '' then begin
            NoofMonths := 0;
            TempDate := WorkDate();
            TempDate1 := WorkDate();
            TempDate := CalcDate("Credit Interval Regular", TempDate);
            repeat
                TempDate1 := CalcDate('<+1M>', TempDate1);
                NoofMonths += 1;
            until TempDate1 >= TempDate;
            "Total Leaves in a Year Regular" := "Leave in a Credit Int. Regular" * 12 / NoofMonths;
        end;
    end;

    procedure "Calculate Leave Days Year Pro"()
    begin
        if Format("Credit Interval Prob.") <> '' then begin
            NoofMonths := 0;
            TempDate := WorkDate();
            TempDate1 := WorkDate();
            TempDate := CalcDate("Credit Interval Prob.", TempDate);
            repeat
                TempDate1 := CalcDate('<+1M>', TempDate1);
                NoofMonths += 1;
            until TempDate1 >= TempDate;
            "Total Leaves in a Year Prob." := "Leave in a Credit Int. Prob." * 12 / NoofMonths;
        end;
    end;
}

