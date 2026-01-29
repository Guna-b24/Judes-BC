table 71896 "User Group Company"
{
    Caption = 'User Group Company';
    DataPerCompany = false;
    LookupPageID = 71899;

    fields
    {
        field(1; "User Group"; Code[20])
        {
            Caption = 'User Group';
            TableRelation = "User Groups";
        }
        field(2; "Company Access"; Text[30])
        {
            Caption = 'Company Access';
            TableRelation = Company;
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

