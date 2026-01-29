table 71895 "Portal Users"
{
    Caption = 'Portal Users';
    DataPerCompany = false;
    LookupPageID = 71897;

    fields
    {
        field(1; "Login ID"; Code[20])
        {
            Caption = 'Login ID';
        }
        field(2; Password; Code[20])
        {
            Caption = 'Password';
        }
        field(3; "User Groups"; Code[20])
        {
            Caption = 'User Groups';
            Editable = true;
            TableRelation = "User Groups";

            trigger OnValidate()
            begin
                if "User Groups" = 'FACULTY' then begin
                    if Emp.Get("Login ID") then;
                    Name := Emp."First Name";
                    Modify;
                end;

                if "User Groups" = 'STUDENT' then begin
                    if Stud.Get("Login ID") then;
                    Name := Stud.Name;
                    Modify;
                end;
            end;
        }
        field(10; Name; Text[80])
        {
        }
        field(11; PwdReset; Boolean)
        {
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

