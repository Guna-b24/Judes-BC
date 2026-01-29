table 71068 "Subject Formative Assesment"
{
    Caption = 'Subject Formative Assesment';
    DrillDownPageID = 33009228;
    LookupPageID = 33009228;

    fields
    {
        field(1; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
        }
        field(2; "Formative Assesment Code"; Code[20])
        {
            Caption = 'Formative Assesment Code';
            TableRelation = "Formative Assesment";
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
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
        key(Key1; "Subject Code", "Formative Assesment Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Academic Year" := EducationVertical.GetAcademicYear;
        "User ID" := UserId;
    end;

    var
        EducationVertical: Codeunit "Education Vertical";
}

