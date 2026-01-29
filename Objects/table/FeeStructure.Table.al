table 50010 "Fee Structure"
{
    DataPerCompany = false;

    fields
    {
        field(1; "Academic Year"; Code[10])
        {
        }
        field(2; "From Class"; Integer)
        {
        }
        field(3; "To Class"; Integer)
        {
        }
        field(4; "Fee Code"; Code[20])
        {
            TableRelation = "Fee Components";

            trigger OnValidate()
            begin
                if FeeComponent.Get("Fee Code") then begin
                    "Fee Description" := FeeComponent.Description;
                    "G/L Account" := FeeComponent."G/L Account";
                end;
            end;
        }
        field(5; "Fee Description"; Text[30])
        {
        }
        field(6; Amount; Decimal)
        {
            Editable = true;
        }
        field(7; "Type Of Fees"; Option)
        {
            OptionCaption = ' ,Initial,Term1,Term2';
            OptionMembers = " ",Initial,Term1,Term2;
        }
        field(8; Company; Code[30])
        {
        }
        field(9; "G/L Account"; Code[20])
        {
        }
        field(10; Thai; Boolean)
        {
        }
        field(11; Group; Option)
        {
            OptionCaption = ' ,Group A,Group B,Group C,Group D,Group E,Group F';
            OptionMembers = " ","Group A","Group B","Group C","Group D","Group E","Group F";
        }
        field(12; "Staff Child"; Boolean)
        {
        }
        field(13; "Group Subject"; Code[20])
        {
            TableRelation = Subject;
        }
        field(14; "Caution Depoit Select"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Academic Year", "From Class", "To Class", "Fee Code", Company, "Type Of Fees")
        {
            Clustered = true;
        }
        key(Key2; "Fee Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FeeComponent: Record "Fee Components";
}

