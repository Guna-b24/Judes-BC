table 71020 "Subject Detail Exam Schedule"
{

    fields
    {
        field(1; "Exam Schedule No."; Code[20])
        {
        }
        field(2; "Subject Code"; Code[20])
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; "Class Code"; Code[20])
        {
        }
        field(5; "Exam Slot"; Code[20])
        {
            TableRelation = Table33009196;
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Scholastic,Non-Scholastic';
            OptionMembers = Scholastic,"Non-Scholastic";
        }
    }

    keys
    {
        key(Key1; "Exam Schedule No.", "Subject Code")
        {
            Clustered = true;
        }
        key(Key2; Type)
        {
        }
    }

    fieldgroups
    {
    }
}

