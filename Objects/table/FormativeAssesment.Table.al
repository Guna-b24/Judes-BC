table 71067 "Formative Assesment"
{
    Caption = 'Formative Assesment';
    DrillDownPageID = 33009227;
    LookupPageID = 33009227;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
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
        key(Key1; "Code")
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

