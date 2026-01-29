table 71900 "Unit Master"
{
    Caption = 'Unit Master';
    DrillDownPageID = 71904;
    LookupPageID = 71904;

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
    end;

    var
        EducationVertical: Codeunit "Education Vertical";
}

