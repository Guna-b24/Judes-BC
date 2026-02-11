table 71044 KeyStages
{
    Caption = 'KeyStages';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71044;
    // LookupPageID = 71044;

    fields
    {
        field(1; "Divison Code"; Code[20])
        {
            Caption = 'Division Code';
            ToolTip = 'Specifies the division to which this key stage belongs.';
            TableRelation = Divsion."Division Code";
            DataClassification = CustomerContent;
        }

        field(2; Code; Code[10])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the key stage code.';
            TableRelation = Class;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Class.Get(Code) then
                    Description := Class.Description
                else
                    Description := '';
            end;
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the key stage.';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference ID associated with this key stage.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Divison Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Class: Record Class;
}

