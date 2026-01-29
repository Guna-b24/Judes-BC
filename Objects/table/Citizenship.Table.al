table 71881 Citizenship
{
    //   No   Date        Sign       Trigger          Description
    // -----------------------------------------------------------------------------------------------
    //   01   17/09/09    Kathir                      Table Created by Kathir
    //   02   19/10/09    VANDHANA   OnInsert         Code to assign User ID.

    Caption = 'Citizenship';
    LookupPageID = 71881;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
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
        // Start 02. VANDHANA
        "User ID" := UserId;
        // Stop 02. VANDHANA
    end;
}

