table 71905 "Fee Components"
{
    Caption = 'Fee Components';
    DataPerCompany = false;
    DataClassification = ToBeClassified;
    // DrillDownPageID = 71909;
    // LookupPageID = 71909;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Unique code for the fee component.';
        }

        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Description of the fee component.';
        }

        field(3; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            DataClassification = AccountData;
            ToolTip = 'General Ledger account associated with this fee component.';
        }
        field(4; "Fee Group"; Option)
        {
            Caption = 'Fee Group';
            OptionCaption = ' ,Admission,Exam';
            OptionMembers = " ",Admission,"Exam";
            DataClassification = ToBeClassified;
            ToolTip = 'Type of fee group this component belongs to.';
        }

        field(5; "Check Duplication"; Boolean)
        {
            Caption = 'Check Duplication';
            DataClassification = ToBeClassified;
            ToolTip = 'Specifies whether duplication check is required for this component.';
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = ToBeClassified;
            ToolTip = 'Portal identifier for integration purposes.';
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

}

