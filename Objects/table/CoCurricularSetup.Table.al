table 71080 "Co-Curricular Setup"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   15.12.09  VIGNESH  OnInsert()                 Code added to enter the User id
    // SJ6.01 21/01/18 GB
    //   Autogenerate team no

    Caption = 'Co-Curricular Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            TableRelation = "No. Series";
        }
        field(3; "Participant Entry No."; Code[20])
        {
            Caption = 'Participant Entry No.';
            TableRelation = "No. Series";
        }
        field(4; "Result Individual Entry No."; Code[20])
        {
            Caption = 'Result Individual Entry No.';
            TableRelation = "No. Series";
        }
        field(5; "Result Team Entry No."; Code[20])
        {
            Caption = 'Result Team Entry No.';
            TableRelation = "No. Series";
        }
        field(50000; "Last Used Team No"; Code[20])
        {
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

    trigger OnModify()
    begin
        // Start 01.VIGNESH
        "User ID" := UserId;
        // Stop 01.VIGNESH
    end;
}

