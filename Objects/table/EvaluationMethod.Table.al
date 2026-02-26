table 71007 "Evaluation Method"
{

    Caption = 'Evaluation Method';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71015;
    LookupPageID = "Evaluation Method List";

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
        field(3; "Prequalification Mark"; Boolean)
        {
            Caption = 'Prequalification Mark';
            ToolTip = 'Specifies whether this evaluation method is used for prequalification.';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = SystemMetadata;
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

