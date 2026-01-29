table 71919 Department
{
    //   No   Date      Sign     Trigger                      Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.
    //   02  24/11/09  ABK       OnInsert                     Code to assign academic year

    Caption = 'Department';
    DrillDownPageID = 71925;
    LookupPageID = 71925;

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
        field(3; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(4; "Head of the Department"; Code[20])
        {
            Caption = 'Head of the Department';
            TableRelation = Employee;
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
        // Start 01. VANDHANA
        "User ID" := UserId;
        // Stop 01. VANDHANA

        // Start 02.ABK
        "Academic Year" := EducationVertical.GetAcademicYear;
        // Stop 02.ABK
    end;

    var
        EducationVertical: Codeunit "Education Vertical";
}

