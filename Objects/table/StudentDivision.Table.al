table 71076 "Student Division"
{
    Caption = 'Student Division';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71086;
    LookupPageID = "Student Division List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            ToolTip = 'Specifies the unique code for the student division.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the student division.';
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal identifier for integration purposes.';
            DataClassification = SystemMetadata;
        }

        field(70122; IsAcademicDivision; Boolean)
        {
            Caption = 'Academic Division';
            ToolTip = 'Specifies whether this division is an academic division.';
            DataClassification = CustomerContent;
        }

        field(70123; Class; Integer)
        {
            Caption = 'Class';
            ToolTip = 'Specifies the class number associated with the division.';
            DataClassification = CustomerContent;
        }

        field(70124; Section; Text[5])
        {
            Caption = 'Section';
            ToolTip = 'Specifies the section associated with the division.';
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

}

