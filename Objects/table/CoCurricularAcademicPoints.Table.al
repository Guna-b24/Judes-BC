table 71078 "Co-Curricular Academic Points"
{
    Caption = 'Co-Curricular Academic Points';
    DataClassification = CustomerContent;

    // DrillDownPageID = 71088;
    LookupPageID = "Co-Curricular Points";

    fields
    {
        field(1; Grade; Code[20])
        {
            Caption = 'Grade';
            ToolTip = 'Specifies the grade for which academic points are defined.';
            TableRelation = Grade;
            DataClassification = CustomerContent;
        }

        field(2; Points; Decimal)
        {
            Caption = 'Points';
            ToolTip = 'Specifies the points assigned to the selected grade.';
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the external portal reference ID.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Grade)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


}

