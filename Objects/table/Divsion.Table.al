table 71043 Divsion
{
    //   No   Date        Sign       Trigger          Description
    // -----------------------------------------------------------------------------------------------
    //   01   21/09/09   KATHIR    OnInsert()       Coding added to get current academic year
    //   02   19/10/09   VANDHANA  OnInsert         Code to assign User ID.

    Caption = 'Divsion';
    LookupPageID = 71043;

    fields
    {
        field(1; "Division Code"; Code[20])
        {
            Caption = 'Division Code';
        }
        field(2; "Division Description"; Text[50])
        {
            Caption = 'Division Description';
        }
        field(3; "Created Academic Year"; Code[20])
        {
            Caption = 'Created Academic Year';
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
        key(Key1; "Division Code", "Created Academic Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.KATHIR
        "Created Academic Year" := EduVert.GetAdmissionYear;
        // Stop 01.KATHIR

        // Start 02. VANDHANA

        "User ID" := UserId;

        // Stop 02. VANDHANA
    end;

    var
        EduVert: Codeunit "Education Vertical";
}

