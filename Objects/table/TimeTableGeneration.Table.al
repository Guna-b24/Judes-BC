table 71154 "Time Table Generation"
{
    Caption = 'Time Table Generation';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the unique entry number of the timetable generation record.';
        }
        field(2; Class; Code[10])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class for which the timetable is generated.';
        }
        field(3; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the section of the class.';
        }
        field(4; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the curriculum associated with the class.';
        }
        field(5; "Day No"; Integer)
        {
            Caption = 'Day No';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the day number in the timetable cycle.';
        }
        field(6; "Hour No"; Integer)
        {
            Caption = 'Hour No';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the hour or period number.';
        }
        field(7; Subject; Code[20])
        {
            Caption = 'Subject';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the subject assigned for the period.';
        }
        field(8; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee assigned to the period.';
        }
        field(9; "Generate Date"; Date)
        {
            Description = 'Asc Time Table';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date on which the timetable was generated.';
        }
        field(10; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year for the timetable.';
        }
        field(11; Joint; Boolean)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the period is a joint class.';
        }
        field(12; "Period Length"; Integer)
        {
            CalcFormula = Lookup(Subject."Period Length" WHERE(Code = FIELD(Subject)));
            FieldClass = FlowField;
            ToolTip = 'Displays the period length defined for the selected subject.';
        }
        field(13; Archived; Boolean)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the timetable entry is archived.';
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
        key(Key2; Class, Section)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        EduSetup.Get();
        "Academic Year" := EduSetup."Academic Year";
    end;

    var
        EduSetup: Record "Education Setup";
}

