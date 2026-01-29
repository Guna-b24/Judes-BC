table 71078 "Co-Curricular Academic Points"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   15.12.09  VIGNESH  OnInsert()                 Code added to enter the User id

    Caption = 'Co-Curricular Academic Points';
    DrillDownPageID = 71088;
    LookupPageID = 71088;

    fields
    {
        field(1; Grade; Code[20])
        {
            Caption = 'Grade';
            TableRelation = Grade;
        }
        field(2; Points; Decimal)
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
        key(Key1; Grade)
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
        "User ID" := UserId;
        // Stop 01.VIGNESH
    end;
}

