table 71077 "Co-Curricular Points Setup"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   15.12.09  VIGNESH  OnInsert()                 Code added to enter the User id

    Caption = 'Co-Curricular Points Setup';
    DrillDownPageID = 71087;
    LookupPageID = 71087;

    fields
    {
        field(1; "Competition type"; Code[20])
        {
            Caption = 'Competition type';
            TableRelation = "Competition Type";
        }
        field(2; "1st Place"; Decimal)
        {
            Caption = '1st Place';
        }
        field(3; "2nd Place"; Decimal)
        {
            Caption = '2nd Place';
        }
        field(4; "3rd Place"; Decimal)
        {
            Caption = '3rd Place';
        }
        field(5; "4th Place"; Decimal)
        {
            Caption = '4th Place';
        }
        field(6; Participation; Decimal)
        {
            Caption = 'Participation';
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
        field(70122; "5th Place"; Decimal)
        {
        }
        field(70123; "6th Place"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Competition type")
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

