table 71050 "Subject Group"
{
    // 
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'Subject Group';
    LookupPageID = 71051;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
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
    end;
}

