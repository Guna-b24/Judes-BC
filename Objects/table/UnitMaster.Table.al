table 71900 "Unit Master"
{
    Caption = 'Unit Master';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71904;
    LookupPageID = "Unit Master List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique code for the unit.';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the unit.';
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year associated with the unit.';
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

