table 71017 "Admission Grade"
{
    DrillDownPageID = 71114;
    LookupPageID = 71114;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Obtained Mark"; Decimal)
        {
        }
        field(4; "Academic Year"; Code[10])
        {
            TableRelation = "Academic Year";
        }
        field(5; "Maximum Mark"; Decimal)
        {
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
        key(Key1; "Code", "Academic Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Academic Year" := Eduvertical.GetAdmissionYear;

        "User ID" := UserId;
    end;

    var
        Eduvertical: Codeunit "Education Vertical";
}

