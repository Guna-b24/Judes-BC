table 71880 "Medium of Instruction"
{
    Caption = 'Medium of Instruction';
    DataClassification = CustomerContent;
    //LookupPageID = 71880;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique code for the medium of instruction.';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the medium of instruction.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Portal ID for this medium.';
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

