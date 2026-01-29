table 71155 "Time Table Ledger"
{
    // 
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.
    //   02  23/11/09   VIGNESH  Class - OnValidate()                Code added to get the Class Section & Curriculum
    //   03  23/11/09   VIGNESH  Class - OnLookup()                  Code added to get the Class Section & Curriculum
    //   04  23/11/09   VIGNESH  Curriculum - OnValidate()           Code added to get the Class Section & Curriculum
    //   05  23/11/09   VIGNESH  Curriculum - OnLookup()             Code added to get the Class Section & Curriculum
    //   06  23/11/09   VIGNESH  Section - OnValidate()              Code added to get the Class Section & Curriculum
    //   07  23/11/09   VIGNESH  Section - OnLookup()                Code added to get the Class Section & Curriculum

    Caption = 'Time Table Ledger';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; Class; Code[10])
        {
            Caption = 'Class';
            Editable = false;

            trigger OnValidate()
            begin
                // Start 02.VIGNESH
            end;
        }
        field(3; Section; Code[10])
        {
            Caption = 'Section';
            Editable = false;
        }
        field(4; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            Editable = false;
        }
        field(5; "Day No"; Integer)
        {
            Caption = 'Day No';
        }
        field(6; "Hour No"; Text[30])
        {
            Caption = 'Hour No';
        }
        field(7; Subject; Code[20])
        {
            Caption = 'Subject';
            TableRelation = Subject;

            trigger OnValidate()
            begin

                if RecSubject.Get(Subject) then
                    "Subject Description" := RecSubject.Description
                else
                    "Subject Description" := '';
            end;
        }
        field(8; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            TableRelation = "Employee Alll";

            trigger OnValidate()
            var
                PeriodTime: Record "Period Line";
                PeriodHead: Record "Period Header";
            begin
                // Start 05.VIGNESH
                if Employee.Get("Employee Code") then
                    "Faculty Name" := Employee."First Name"
                else
                    "Faculty Name" := '';
                // Stop 05.VIGNESH
                // Start 03.GUNA
                PeriodTime.Reset;
                PeriodTime.SetRange(Period, "Hour No");
                if PeriodTime.FindFirst then begin
                    "Start Time" := CreateDateTime("Time Table Date", PeriodTime."Period Time");
                    PeriodHead.Get(PeriodTime.Code);
                    "End Time" := CreateDateTime("Time Table Date", (PeriodTime."Period Time" + (60 * 1000 * PeriodHead."Minutes/Period")));
                end;
                // Stop 03.GUNA
            end;
        }
        field(9; "Time Table Date"; Date)
        {
            Caption = 'Time Table Date';
        }
        field(10; "Alternate Employee"; Code[10])
        {
            Caption = 'Alternate Employee';
        }
        field(11; "Alternate Subject"; Code[10])
        {
            Caption = 'Alternate Subject';
        }
        field(12; "Attendance Code"; Code[10])
        {
            Caption = 'Attendance Code';

            trigger OnValidate()
            begin
                TimeTableLedger.Reset;
                TimeTableLedger.SetRange(TimeTableLedger."Time Table Date", "Time Table Date");
                TimeTableLedger.SetRange(TimeTableLedger."Class Code", "Class Code");
                if "Hour No" = '1' then begin
                    TimeTableLedger.SetFilter(TimeTableLedger."Entry No.", '<>%1', "Entry No.");
                    TimeTableLedger.SetFilter(TimeTableLedger."Hour No", '%1|%2|%3|%4|%5', '2', '3', '4', '5', '6');
                    if TimeTableLedger.FindSet then
                        TimeTableLedger.ModifyAll(TimeTableLedger."Attendance Code", "Attendance Code");
                end else begin
                    TimeTableLedger.SetFilter(TimeTableLedger."Entry No.", '<>%1', "Entry No.");
                    TimeTableLedger.SetFilter(TimeTableLedger."Hour No", '%1|%2', '7', '8');
                    if TimeTableLedger.FindSet then
                        TimeTableLedger.ModifyAll(TimeTableLedger."Attendance Code", "Attendance Code");
                end;
            end;
        }
        field(13; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = false;
        }
        field(14; "Subject Description"; Text[30])
        {
            CalcFormula = Lookup (Subject.Description WHERE (Code = FIELD (Subject)));
            Caption = 'Subject Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Start Time"; DateTime)
        {
            Caption = 'Start Time';
        }
        field(16; "End Time"; DateTime)
        {
            Caption = 'End Time';
        }
        field(17; "Faculty Name"; Text[30])
        {
            Caption = 'Faculty Name';
        }
        field(18; Reason; Text[50])
        {
            Caption = 'Reason';
        }
        field(19; "Exam Status"; Option)
        {
            Caption = 'Exam Status';
            OptionCaption = ' ,Deffered,Closed';
            OptionMembers = " ",Deffered,Closed;
        }
        field(20; "Exam Code"; Code[20])
        {
            Caption = 'Exam Code';

            trigger OnValidate()
            begin
                // Start 06.VIGNESH
                if "Exam Code" <> '' then
                    "Period Type" := "Period Type"::Exam;
            end;
        }
        field(21; "Exam Description"; Text[50])
        {
            Caption = 'Exam Description';
        }
        field(25; "Period Type"; Option)
        {
            Caption = 'Period Type';
            OptionCaption = 'Normal,Exam';
            OptionMembers = Normal,Exam;
        }
        field(26; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";

            trigger OnValidate()
            begin
                if ClassSection.Get("Class Code") then begin
                    Class := ClassSection.Class;
                    Section := ClassSection.Section;
                    Curriculum := ClassSection.Curriculum;
                    "Academic Year" := ClassSection."Academic Year";
                end;
            end;
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
        key(Key1; "Entry No.")
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
    end;

    var
        ClassSection: Record "Class Section";
        Employee: Record Employee;
        Text000: Label 'Internal exam %1 is not allottted for this subject.';
        TimeTableLedger: Record "Time Table Ledger";
        RecSubject: Record Subject;
}

