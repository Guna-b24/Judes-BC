table 71885 Quota
{
    Caption = 'Quota';
    // DrillDownPageID = 71885;
    LookupPageID = "Quota Card";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Quota Code';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique code for the quota.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the quota.';
        }

        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year to which the quota applies.';
        }

        field(4; Reserve; Boolean)
        {
            Caption = 'Reserve';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the quota is reserved.';
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal reference ID associated with the quota.';
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


    var

}

