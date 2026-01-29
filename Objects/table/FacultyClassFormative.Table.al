table 71069 "Faculty Class Formative"
{
    Caption = 'Faculty Class Formative';

    fields
    {
        field(1; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
        }
        field(2; "Formative Code"; Code[20])
        {
            Caption = 'Formative Code';
            TableRelation = "Subject Formative Assesment"."Formative Assesment Code" WHERE ("Subject Code" = FIELD ("Subject Code"));
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Academic Year"; Code[20])
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
        key(Key1; "Document No.", "Subject Code", "Formative Code")
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

