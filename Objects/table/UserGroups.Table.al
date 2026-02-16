table 71897 "User Groups"
{
    Caption = 'User Group';
    DataPerCompany = false;
    DataClassification = CustomerContent;
    // LookupPageID = 71902;

    fields
    {
        field(1; "User Group"; Code[20])
        {
            Caption = 'User Group';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the unique code for the user group.';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the description of the user group.';
        }
        field(3; SID; Text[120])
        {
            Caption = 'SID';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the security identifier (SID) associated with the user or group.';
        }
        field(4; "Windows Login"; Text[150])
        {
            Caption = 'Windows Login';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the Windows login associated with the user group.';
        }
        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                // UserMgt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                //   UserMgt.ValidateUserID("User ID");
            end;
        }
    }

    keys
    {
        key(Key1; "User Group")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

