table 71153 "Time Table Setup"
{
    //   No   Date        Sign       Trigger          Description
    // ------------------------------------------------------------------------------------------
    //   01  17/09/09    VIGNESH                     Table Created by Vignesh
    //   02  19/10/09    VANDHANA    OnInsert        Code to assign User ID.

    Caption = 'Time Table Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(3; "Time Table Theory Code"; Code[20])
        {
            Caption = 'Time Table Theory Code';
        }
        field(4; "Time Table Lab Code"; Code[20])
        {
            Caption = 'Time Table Lab Code';
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
        key(Key1; "Primary Key")
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

