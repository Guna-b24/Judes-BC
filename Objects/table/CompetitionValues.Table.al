table 50035 "Competition Values"
{
    DataClassification = CustomerContent;
    LookupPageId = "Competition Values List";

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the unique line number for the competition value record.';
        }

        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the student number associated with the competition.';
        }

        field(4; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the name of the student.';
        }

        field(10; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            Editable = true;
            TableRelation = "Student Division";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the division or category of the student.';
        }

        field(12; Points; Decimal)
        {
            Caption = 'Points';
            Editable = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the points awarded to the student for the competition.';
        }

        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year applicable to the competition.';
        }

        field(21; "Event Code"; Code[20])
        {
            TableRelation = "Event Master";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the event code linked to the competition.';
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Student No.", "Student Name", Points)
        {
        }
        key(Key3; "Student Division", Points)
        {
        }
    }

    fieldgroups
    {
    }
}

