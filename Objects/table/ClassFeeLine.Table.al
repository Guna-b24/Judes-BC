table 71071 "Class Fee Line"
{
    //    No  Date     Sign    Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    //   01  22/09/09  KATHIR Fee Code - OnValidate()    Coding added to get description from fee component

    Caption = 'Class Fee Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Fee Code"; Code[20])
        {
            Caption = 'Fee Code';
            TableRelation = "Fee Components";

            trigger OnValidate()
            begin
                // Start 01.KATHIR
                if RecFeeComp.Get("Fee Code") then
                    Description := RecFeeComp.Description
                else
                    Clear(Description);
                // Stop 01.KATHIR
            end;
        }
        field(4; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(7; "Fee Type Code"; Code[20])
        {
            Caption = 'Fee Type Code';
            TableRelation = "Fee Type";
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecFeeComp: Record "Fee Components";
}

