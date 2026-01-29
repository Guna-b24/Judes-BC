table 71897 "User Groups"
{
    // 
    // No   Date      Sign     Trigger                  Description
    // -----------------------------------------------------------------------------------------------
    // 01  19.10.09   GUNA    SID-ONVALIDATE         TO COPY LOGIN NAME

    Caption = 'User Group';
    DataPerCompany = false;
    LookupPageID = 71902;

    fields
    {
        field(1; "User Group"; Code[20])
        {
            Caption = 'User Group';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; SID; Text[120])
        {
            Caption = 'SID';
        }
        field(4; "Windows Login"; Text[150])
        {
            Caption = 'Windows Login';
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
                UserMgt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.ValidateUserID("User ID");
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

