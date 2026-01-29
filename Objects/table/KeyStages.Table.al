table 71044 KeyStages
{
    // 
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'KeyStages';
    DrillDownPageID = 71044;
    LookupPageID = 71044;

    fields
    {
        field(1; "Divison Code"; Code[20])
        {
            Caption = 'Divison Code';
            TableRelation = Divsion."Division Code";
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = Class;

            trigger OnValidate()
            begin
                // Start 02.VIGNESH
                if Class.Get(Code) then
                    Description := Class.Description
                else
                    Description := '';

                // Stop 02.VIGNESH
            end;
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
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

    trigger OnInsert()
    begin
        // Start 01. VANDHANA

        "User ID" := UserId;

        // Stop 01. VANDHANA
    end;

    var
        Class: Record Class;
}

