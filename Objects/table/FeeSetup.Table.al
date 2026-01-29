table 71072 "Fee Setup"
{
    // 
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'Fee Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Class Fee No."; Code[10])
        {
            Caption = 'Class Fee No.';
            TableRelation = "No. Series";
        }
        field(3; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(4; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Journal Template Name"));
        }
        field(5; "Fee Number"; Code[20])
        {
            Caption = 'Fee Number';
            TableRelation = "No. Series";
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
        field(70122; "Caution Deposit Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(70123; "Caution Deposit Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Caution Deposit Template"));
        }
        field(70124; "Caution Deposit Number"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(70125; "Fee Receipt Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(70126; "Fee Receipt Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Fee Receipt Template"));
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
        // Start 01. VANDHANA

        "User ID" := UserId;

        // Stop 01. VANDHANA
    end;
}

