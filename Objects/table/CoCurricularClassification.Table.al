table 71898 "Co-Curricular Classification"
{
    Caption = 'Co-Curricular Classification';
    // DrillDownPageID = 71903;
    LookupPageID = "Co-Curricular Classification";

    fields
    {
        field(1; "Co-Curricular Code"; Code[20])
        {
            Caption = 'Co-Curricular Code';
            TableRelation = "Co-Curricular Activities";
            ToolTip = 'Specifies the unique code for the co-curricular.';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; "Classification Code"; Code[20])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the unique code for the co-curricular Classification.';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the co-curricular activity.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Co-Curricular Code", "Classification Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

