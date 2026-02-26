table 71901 "Chapter Master"
{
    Caption = 'Chapter Master';
    // DrillDownPageID = 71905;
    LookupPageID = "Chapter Master List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the unique code for the chapter.';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description or name of the chapter.';
            DataClassification = CustomerContent;
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year to which the chapter belongs.';
            DataClassification = CustomerContent;
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
        "Academic Year" := EducationVertical.GetAcademicYear();
    end;

    var
        EducationVertical: Codeunit "Education Vertical";
}

