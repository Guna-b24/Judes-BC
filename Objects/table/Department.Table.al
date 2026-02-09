table 71919 Department
{
    Caption = 'Department';
    // DrillDownPageID = 71925;
    // LookupPageID = 71925;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            DataClassification = CustomerContent;
        }
        field(4; "Head of the Department"; Code[20])
        {
            Caption = 'Head of the Department';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
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

