table 71155 "Time Table Ledger"
{
    Caption = 'Time Table Ledger';
    DataClassification = CustomerContent;
    LookupPageId = "Time Table Ledger List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the unique entry number of the timetable ledger record.';
        }
        field(2; Class; Code[20])
        {
            Caption = 'Class';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class for the timetable entry.';
        }
        field(3; Section; Code[10])
        {
            Caption = 'Section';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the section for the timetable entry.';
        }
        field(4; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the curriculum associated with the class.';
        }
        field(5; "Day No"; Integer)
        {
            Caption = 'Day No';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the day number for the timetable entry.';
        }
        field(6; "Hour No"; Text[30])
        {
            Caption = 'Hour No';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the hour or period number.';
        }
        field(7; Subject; Code[20])
        {
            Caption = 'Subject';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the subject scheduled for this period.';
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
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee assigned to the period.';
            TableRelation = "Employee Alll";

            trigger OnValidate()
            var
                PeriodTime: Record "Period Line";
                PeriodHead: Record "Period Header";
            begin
                if Employee.Get("Employee Code") then
                    "Faculty Name" := Employee."First Name"
                else
                    "Faculty Name" := '';
                PeriodTime.Reset();
                PeriodTime.SetRange(Period, "Hour No");
                if PeriodTime.FindFirst() then begin
                    "Start Time" := CreateDateTime("Time Table Date", PeriodTime."Period Time");
                    PeriodHead.Get(PeriodTime.Code);
                    "End Time" := CreateDateTime("Time Table Date", (PeriodTime."Period Time" + (60 * 1000 * PeriodHead."Minutes/Period")));
                end;
            end;
        }
        field(9; "Time Table Date"; Date)
        {
            Caption = 'Time Table Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date of the timetable entry.';
        }
        field(10; "Alternate Employee"; Code[10])
        {
            Caption = 'Alternate Employee';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the alternate employee assigned for the period.';
        }
        field(11; "Alternate Subject"; Code[10])
        {
            Caption = 'Alternate Subject';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the alternate subject assigned for the period.';
        }
        field(12; "Attendance Code"; Code[10])
        {
            Caption = 'Attendance Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the attendance code applied to the timetable entries.';


            trigger OnValidate()
            begin
                TimeTableLedger.Reset();
                TimeTableLedger.SetRange(TimeTableLedger."Time Table Date", "Time Table Date");
                TimeTableLedger.SetRange(TimeTableLedger."Class Code", "Class Code");
                if "Hour No" = '1' then begin
                    TimeTableLedger.SetFilter(TimeTableLedger."Entry No.", '<>%1', "Entry No.");
                    TimeTableLedger.SetFilter(TimeTableLedger."Hour No", '%1|%2|%3|%4|%5', '2', '3', '4', '5', '6');
                    if TimeTableLedger.FindSet() then
                        TimeTableLedger.ModifyAll(TimeTableLedger."Attendance Code", "Attendance Code");
                end else begin
                    TimeTableLedger.SetFilter(TimeTableLedger."Entry No.", '<>%1', "Entry No.");
                    TimeTableLedger.SetFilter(TimeTableLedger."Hour No", '%1|%2', '7', '8');
                    if TimeTableLedger.FindSet() then
                        TimeTableLedger.ModifyAll(TimeTableLedger."Attendance Code", "Attendance Code");
                end;
            end;
        }
        field(13; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year for the timetable entry.';
        }
        field(14; "Subject Description"; Text[50])
        {
            CalcFormula = Lookup(Subject.Description WHERE(Code = FIELD(Subject)));
            Caption = 'Subject Description';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Displays the description of the selected subject.';
        }
        field(15; "Start Time"; DateTime)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the start time of the period.';
        }
        field(16; "End Time"; DateTime)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the end time of the period.';
        }
        field(17; "Faculty Name"; Text[30])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the name of the faculty assigned to the period.';
        }
        field(18; Reason; Text[50])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the reason for any changes or remarks for the period.';
        }
        field(19; "Exam Status"; Option)
        {
            Caption = 'Exam Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the status of the exam for the period.';
            OptionCaption = ' ,Deffered,Closed';
            OptionMembers = " ",Deffered,Closed;
        }
        field(20; "Exam Code"; Code[20])
        {
            Caption = 'Exam Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the exam code associated with the period.';


            trigger OnValidate()
            begin
                if "Exam Code" <> '' then
                    "Period Type" := "Period Type"::Exam;
            end;
        }
        field(21; "Exam Description"; Text[50])
        {
            Caption = 'Exam Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the exam.';
        }
        field(25; "Period Type"; Option)
        {
            Caption = 'Period Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the period is normal or exam.';
            OptionCaption = 'Normal,Exam';
            OptionMembers = Normal,Exam;
        }
        field(26; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class section code.';
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
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier associated with the record.';
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

    var
        ClassSection: Record "Class Section";
        Employee: Record Employee;
        TimeTableLedger: Record "Time Table Ledger";
        RecSubject: Record Subject;
        Text000: Label 'Internal exam %1 is not allottted for this subject.';
}

