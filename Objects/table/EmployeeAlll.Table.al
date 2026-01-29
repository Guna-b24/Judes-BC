table 71091 "Employee Alll"
{
    DataPerCompany = false;
    DrillDownPageID = 71936;
    LookupPageID = 71936;

    fields
    {
        field(1; "Employee No."; Code[10])
        {
        }
        field(2; "Company Name"; Text[30])
        {
            TableRelation = Company;
        }
        field(3; Name; Text[100])
        {
        }
        field(50000; "Employee Category"; Option)
        {
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary";
        }
        field(51000; "Class From"; Code[10])
        {
            Description = 'Coding added by kathir for Employee category HM';
            TableRelation = Class;
        }
        field(51001; "Class To"; Code[10])
        {
            Description = 'Coding added by kathir for Employee category HM';
            TableRelation = Class;
        }
        field(51002; "Employee Type"; Option)
        {
            Caption = 'Employee Type';
            OptionCaption = ' ,Teaching,Non-Teaching,HOD,Principal,Sub Staff,HM';
            OptionMembers = " ",Teaching,"Non-Teaching",HOD,Principal,"Sub Staff",HM;
        }
        field(51003; Gender; Option)
        {
            OptionMembers = " ",Female,Male;
        }
        field(51004; "Employee Image File"; Text[250])
        {
        }
        field(51005; "Employment Date"; Date)
        {
        }
        field(51006; "Date of Birth"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

