table 71896 "User Group Company"
{
    Caption = 'User Group Company';
    DataPerCompany = false;
    DataClassification = CustomerContent;
    LookupPageID = "User Group Company List";

    fields
    {
        field(1; "User Group"; Code[20])
        {
            Caption = 'User Group';
            TableRelation = "User Groups";
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the user group that is granted access.';
        }
        field(2; "Company Access"; Text[30])
        {
            Caption = 'Company Access';
            TableRelation = Company;
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the company that the user group has access to.';
        }
    }

    keys
    {
        key(Key1; "User Group", "Company Access")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

