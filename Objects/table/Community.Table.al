table 71890 Community
{
    Caption = 'Community';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71890;
    LookupPageID = "Community";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the unique code for the community.';
            NotBlank = true;
            DataClassification = CustomerContent;
        }

        field(2; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description or name of the community.';
            DataClassification = CustomerContent;
        }

        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year applicable to this community.';
            TableRelation = "Academic Year";
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference identifier.';
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
        "Academic Year" := EduVert.GetAcademicYear();
    end;

    var
        // RecComp: Record "Company Information";
        EduVert: Codeunit "Education Vertical";
}

