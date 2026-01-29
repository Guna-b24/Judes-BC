table 71945 "Academic Points"
{
    DrillDownPageID = 91914;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = true;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(3; "Exam Code"; Code[20])
        {
        }
        field(4; "Class Code"; Code[20])
        {
        }
        field(5; Points; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Student No.", "Academic Year", "Exam Code")
        {
            Clustered = true;
            SumIndexFields = Points;
        }
    }

    fieldgroups
    {
    }
}

