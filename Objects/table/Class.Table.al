table 71041 Class
{
    //   No   Date        Sign       Trigger          Description
    // -----------------------------------------------------------------------------------------------
    //   01   17/09/09    Kathir                      Table Created by Kathir
    //   02   19/10/09    VANDHANA   OnInsert         Code to assign User ID.

    Caption = 'Class';
    LookupPageID = 71041;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; Sequence; Integer)
        {
            Caption = 'Sequence';
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
        key(Key2; Sequence)
        {
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

