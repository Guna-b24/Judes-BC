table 71041 Class
{
    Caption = 'Class';
    //LookupPageID = 71041;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the unique code for the class.';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the class.';
            DataClassification = CustomerContent;
        }
        field(3; Sequence; Integer)
        {
            Caption = 'Sequence';
            ToolTip = 'Specifies the display or processing order of the class.';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference ID for the class.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Sequence)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

    end;
}

