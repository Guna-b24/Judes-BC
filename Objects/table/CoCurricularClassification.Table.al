table 71898 "Co-Curricular Classification"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01  16/10/09  VIGNESH                       Created new table for co curicular classification

    Caption = 'Co-Curricular Classification';
    DrillDownPageID = 71903;
    LookupPageID = 71903;

    fields
    {
        field(1; "Co-Curricular Code"; Code[20])
        {
            Caption = 'Co-Curricular Code';
            TableRelation = "Co-Curricular Activities";
        }
        field(2; "Classification Code"; Code[20])
        {
            Caption = 'Classification Code';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
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

