table 71889 Grade
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01  29.09.09  VIGNESH   OnInsert()        Code added to insert the Academic year
    // 02  19/10/09  VANDHANA  OnInsert          Code to assign User ID.
    // 03  17/10/09  VIGNESH                     Added new filed points

    Caption = 'Grade';
    DrillDownPageID = 71889;
    LookupPageID = 71889;

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
        field(3; "Max Percentage"; Decimal)
        {
            Caption = 'Max Percentage';
        }
        field(4; "Min Percentage"; Decimal)
        {
            Caption = 'Min Percentage';
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(6; Points; Decimal)
        {
            Caption = 'Points';
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
        // Start 01.VIGNESH
        "Academic Year" := EducationVertical.GetAcademicYear;
        // Stop 01.VIGNESH

        // Start 02. VANDHANA
        "User ID" := UserId;
        // Stop 02. VANDHANA
    end;

    var
        EducationVertical: Codeunit "Education Vertical";
}

