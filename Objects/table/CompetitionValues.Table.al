table 50035 "Competition Values"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(4; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
        }
        field(10; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            Editable = true;
            TableRelation = "Student Division";
        }
        field(12; Points; Decimal)
        {
            Caption = 'Points';
            Editable = true;
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(21; "Event Code"; Code[20])
        {
            TableRelation = "Event Master";
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

