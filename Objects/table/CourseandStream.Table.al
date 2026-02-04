table 73000 "Course and Stream"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; primarykey; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; Course; Text[80])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Course Stream"; Text[30])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys

    {
        key(pk; primarykey)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
    //  myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}