table 71010 "Application Certificate"
{
    Caption = 'Application Certificate';
    DataClassification = CustomerContent;
    LookupPageID = "Application Certificate List";

    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            TableRelation = Application."No.";
            ToolTip = 'Specifies the application number to which the certificate is linked.';
            DataClassification = CustomerContent;
        }
        field(2; Certificate; Code[20])
        {
            Caption = 'Certificate';
            ToolTip = 'Specifies the certificate required or submitted for the application.';
            TableRelation = Certificate;
            DataClassification = CustomerContent;
        }
        field(3; "Certificate Status"; Option)
        {
            Caption = 'Status';
            ToolTip = 'Specifies whether the certificate is received or will be submitted later.';
            OptionCaption = ' ,Received,Submit Later';
            OptionMembers = " ",Received,"Submit Later";
            DataClassification = CustomerContent;
        }
        field(4; "Receipt Date / Submission date"; Date)
        {
            Caption = 'Receipt Date / Submission Date';
            ToolTip = 'Specifies the date on which the certificate was received or is expected to be submitted.';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal identifier associated with this certificate record.';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Application No.", Certificate)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
    end;
}

