table 71854 "Stores Setup"
{
    Caption = 'Stores Setup';
    DataClassification = CustomerContent;
    LookupPageId = "Stores Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the primary key for the stores setup record.';
        }
        field(2; "Bulk Issues No."; Code[20])
        {
            Caption = 'Bulk Issues No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used for bulk issue transactions.';
        }
        field(3; "Fee Code"; Code[20])
        {
            Caption = 'Fee Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fee code associated with store transactions.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal ID associated with the stores setup.';
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
}
