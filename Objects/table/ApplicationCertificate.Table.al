table 71010 "Application Certificate"
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'Application Certificate';
    LookupPageID = 71017;

    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'Application No.';
        }
        field(2; Ceritificate; Code[20])
        {
            Caption = 'Ceritificate';
            TableRelation = Certificate;
        }
        field(3; "Certificate Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,Received,Submit Later';
            OptionMembers = " ",Received,"Submit Later";
        }
        field(4; "Receipt Date / Submission date"; Date)
        {
            Caption = 'Receipt Date / Submission date';
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
        key(Key1; "Application No.", Ceritificate)
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

