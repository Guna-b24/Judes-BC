table 71890 Community
{
    // No   Date      Sign     Trigger       Description
    // -----------------------------------------------------------------------------------------------
    // 01   19/09/09  KATHIR   OnInsert      Code added for Academic year from Setup
    // 02   19/10/09  VANDHANA OnInsert      Code to assign User ID.

    Caption = 'Community';
    DrillDownPageID = 71890;
    LookupPageID = 71890;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
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
        // Start 01.KATHIR
        "Academic Year" := EduVert.GetAcademicYear;
        // Stop 01.KATHIR
        // Start 02. VANDHANA
        "User ID" := UserId;
        // Stop 02. VANDHANA
    end;

    var
        RecComp: Record "Company Information";
        EduVert: Codeunit "Education Vertical";
}

