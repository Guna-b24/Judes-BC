table 71889 Grade
{
    Caption = 'Grade';
    DataClassification = SystemMetadata;
    DrillDownPageID = "Grade List";
    LookupPageID = "Grade List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the unique grade code.';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the description of the grade.';
        }
        field(3; "Max Percentage"; Decimal)
        {
            Caption = 'Max Percentage';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the maximum percentage for this grade.';
        }
        field(4; "Min Percentage"; Decimal)
        {
            Caption = 'Min Percentage';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the minimum percentage for this grade.';
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the academic year applicable for this grade.';
        }
        field(6; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the grade points.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the portal identifier.';
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

