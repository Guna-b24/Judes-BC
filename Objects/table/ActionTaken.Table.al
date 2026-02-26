table 71917 "Action Taken"
{
    Caption = 'Action Taken';
    LookupPageID = "Action Taken List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the Code of the action taken.';
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the action taken.';
            DataClassification = CustomerContent;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            ToolTip = 'Specifies the Type of the action taken.';
            OptionCaption = ' ,Staff,Student';
            OptionMembers = " ",Staff,Student;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the Portal ID of the action taken.';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
}

