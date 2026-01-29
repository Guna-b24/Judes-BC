table 72069 "Leave Master"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Leave Master';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Leave Code", Description;
    DrillDownPageID = 72096;
    LookupPageID = 72096;

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
        field(3; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; Regular; Boolean)
        {
            Caption = 'Regular';
        }
        field(6; "Total Leaves in a Year Regular"; Decimal)
        {
            Caption = 'Total Leaves in a Year Regular';
            Editable = false;
        }
        field(7; "Credit Interval Regular"; DateFormula)
        {
            Caption = 'Credit Interval Regular';

            trigger OnValidate()
            begin
                "Calculate Leave Days Year Reg";
            end;
        }
        field(8; "Leave in a Credit Int. Regular"; Decimal)
        {
            Caption = 'Leave in a Credit Int. Regular';

            trigger OnValidate()
            begin
                "Calculate Leave Days Year Reg";
            end;
        }
        field(9; Probationary; Boolean)
        {
            Caption = 'Probationary';
        }
        field(10; "Total Leaves in a Year Prob."; Decimal)
        {
            Caption = 'Total Leaves in a Year Prob.';
            Editable = false;
        }
        field(11; "Credit Interval Prob."; DateFormula)
        {
            Caption = 'Credit Interval Prob.';

            trigger OnValidate()
            begin
                "Calculate Leave Days Year Pro"
            end;
        }
        field(12; "Leave in a Credit Int. Prob."; Decimal)
        {
            Caption = 'Leave in a Credit Int. Prob.';

            trigger OnValidate()
            begin
                "Calculate Leave Days Year Pro";
            end;
        }
        field(13; "Encash Leave"; Boolean)
        {
            Caption = 'Encash Leave';
        }
        field(14; "Maximum Encash Leave"; Decimal)
        {
            Caption = 'Maximum Encash Leave';
        }
        field(15; "Carry Forward"; Boolean)
        {
            Caption = 'Carry Forward';
        }
        field(16; "Paid Leave"; Boolean)
        {
            Caption = 'Paid Leave';

            trigger OnValidate()
            begin
                "UnPaid Leave" := false;
            end;
        }
        field(17; "UnPaid Leave"; Boolean)
        {
            Caption = 'UnPaid Leave';

            trigger OnValidate()
            begin
                "Paid Leave" := false;
            end;
        }
        field(18; "Create Leave Balance"; Boolean)
        {
            Caption = 'Create Leave Balance';
        }
        field(19; "Full Day"; Boolean)
        {
            Caption = 'Full Day';
        }
        field(20; "Mark As Full Day First Half"; Option)
        {
            Caption = 'Mark As Full Day First Half';
            OptionCaption = ' ,Present,Absent,Leave,,,On-Duty';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
        }
        field(21; "Mark As Full Day Secod Half"; Option)
        {
            Caption = 'Mark As Full Day Secod Half';
            OptionCaption = ' ,Present,Absent,Leave,,,On-Duty';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
        }
        field(22; "First Half Day"; Boolean)
        {
            Caption = 'First Half Day';
        }
        field(23; "I'st Mark As First Half Day"; Option)
        {
            Caption = 'I''st Mark As First Half Day';
            OptionCaption = ' ,Present,Absent,Leave,,,On-Duty';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
        }
        field(24; "I'st Mark As Second Half Day"; Option)
        {
            Caption = 'I''st Mark As Second Half Day';
            OptionCaption = ' ,Present,Absent,Leave,,,On-Duty';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
        }
        field(25; "Second Half Day"; Boolean)
        {
            Caption = 'Second Half Day';
        }
        field(26; "II'nd Mark As First Half Day"; Option)
        {
            Caption = 'II''nd Mark As First Half Day';
            OptionCaption = ' ,Present,Absent,Leave,,,On-Duty';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
        }
        field(27; "II'nd Mark As Second Half Day"; Option)
        {
            Caption = 'II''nd Mark As Second Half Day';
            OptionCaption = ' ,Present,Absent,Leave,,,On-Duty';
            OptionMembers = " ",Present,Absent,Leave,"Weekly Off",Holiday,"On-Duty","Not Joined",Relieved;
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

    [Scope('Internal')]
    procedure "Calculate Leave Days Year Reg"()
    begin
        if Format("Credit Interval Regular") <> '' then begin
            NoofMonths := 0;
            TempDate := WorkDate;
            TempDate1 := WorkDate;
            TempDate := CalcDate("Credit Interval Regular", TempDate);
            repeat
                TempDate1 := CalcDate('+1M', TempDate1);
                NoofMonths += 1;
            until TempDate1 >= TempDate;
            "Total Leaves in a Year Regular" := "Leave in a Credit Int. Regular" * 12 / NoofMonths;
        end;
    end;

    [Scope('Internal')]
    procedure "Calculate Leave Days Year Pro"()
    begin
        if Format("Credit Interval Prob.") <> '' then begin
            NoofMonths := 0;
            TempDate := WorkDate;
            TempDate1 := WorkDate;
            TempDate := CalcDate("Credit Interval Prob.", TempDate);
            repeat
                TempDate1 := CalcDate('+1M', TempDate1);
                NoofMonths += 1;
            until TempDate1 >= TempDate;
            "Total Leaves in a Year Prob." := "Leave in a Credit Int. Prob." * 12 / NoofMonths;
        end;
    end;
}

