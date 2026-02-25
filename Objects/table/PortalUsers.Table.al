table 71895 "Portal Users"
{
    Caption = 'Portal Users';
    DataClassification = CustomerContent;
    DataPerCompany = false;
    LookupPageID = "Portal Users List";

    fields
    {
        field(1; "Login ID"; Code[20])
        {
            Caption = 'Login ID';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the unique login ID used to access the portal.';
        }

        field(2; Password; Code[20])
        {
            Caption = 'Password';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the password used for portal authentication.';
        }
        field(3; "User Groups"; Code[20])
        {
            Caption = 'User Groups';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the user group assigned to this portal user.';
            Editable = true;
            TableRelation = "User Groups";

            trigger OnValidate()
            begin
                if "User Groups" = 'FACULTY' then begin
                    if Emp.Get("Login ID") then;
                    Name := Emp."First Name";
                    Modify();
                end;

                if "User Groups" = 'STUDENT' then begin
                    if Stud.Get("Login ID") then;
                    Name := Stud.Name;
                    Modify();
                end;
            end;
        }
        field(10; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the portal user.';
        }

        field(11; PwdReset; Boolean)
        {
            Caption = 'Password Reset Required';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the user must reset the password at next login.';
        }
    }

    keys
    {
        key(Key1; "Login ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Emp: Record Employee;
        Stud: Record Customer;
}

