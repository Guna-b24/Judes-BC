table 71091 "Employee Alll"
{
    Caption = 'Employee All';
    DataPerCompany = false;
    // DrillDownPageID = 71936;
    LookupPageID = "Employee All List";
    fields

    {
        field(1; "Employee No."; Code[10])
        {
            Caption = 'Employee No.';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the unique number of the employee.';
        }

        field(2; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = Company;
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the company to which the employee belongs.';
        }

        field(3; Name; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the full name of the employee.';
        }
        field(50000; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the employment category of the employee.';
        }

        field(51000; "Class From"; Code[10])
        {
            Caption = 'Class From';
            Description = 'Coding added by kathir for Employee category HM';
            TableRelation = Class;
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the starting class assigned to the employee.';
        }

        field(51001; "Class To"; Code[10])
        {
            Caption = 'Class To';
            Description = 'Coding added by kathir for Employee category HM';
            TableRelation = Class;
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the ending class assigned to the employee.';
        }
        field(51002; "Employee Type"; Option)
        {
            Caption = 'Employee Type';
            OptionCaption = ' ,Teaching,Non-Teaching,HOD,Principal,Sub Staff,HM';
            OptionMembers = " ",Teaching,"Non-Teaching",HOD,Principal,"Sub Staff",HM;
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the role or designation of the employee.';
        }

        field(51003; Gender; Option)
        {
            Caption = 'Gender';
            OptionMembers = " ",Female,Male;
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the gender of the employee.';
        }

        field(51004; "Employee Image File"; Text[250])
        {
            Caption = 'Employee Image File Path';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the file path of the employee image.';
        }
        field(51005; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the date when the employee joined.';
        }

        field(51006; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the birth date of the employee.';
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

