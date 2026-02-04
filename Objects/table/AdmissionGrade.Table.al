table 71017 "Admission Grade"
{
    // DrillDownPageID = 71114;
    // LookupPageID = 71114;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Grade Code';
            ToolTip = 'Specifies the unique code for the admission grade.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the admission grade.';
            DataClassification = CustomerContent;
        }
        field(3; "Obtained Mark"; Decimal)
        {
            Caption = 'Obtained Mark';
            ToolTip = 'Specifies the marks obtained for the admission criteria.';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year for which the admission grade applies.';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year";
        }
        field(5; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            ToolTip = 'Specifies the maximum marks possible for the admission criteria.';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the identifier used to sync the admission grade with the portal.';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Code", "Academic Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Academic Year" := this.Eduvertical.GetAdmissionYear();
    end;

    var
        Eduvertical: Codeunit "Education Vertical";
}

