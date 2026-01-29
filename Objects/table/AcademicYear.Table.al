table 71904 "Academic Year"
{
    //   No   Date        Sign       Trigger          Description
    // -----------------------------------------------------------------------------------------------
    //   01   17/09/09    Kathir                      Table Created by Kathir
    //   02   19/10/09    VANDHANA  OnInsert          Code to assign User ID.
    //   03   07/11/09    GUNA                        New field Sequence has been added
    //   04   07/11/09    GUNA                        New field CLOSED has been added to close the older entries

    Caption = 'Academic Year';
    DrillDownPageID = 71908;
    LookupPageID = 71908;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; Sequence; Integer)
        {
            AutoIncrement = true;
            Caption = 'Sequence';
        }
        field(4; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
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
        // Start 02. VANDHANA

        "User ID" := UserId;

        // Stop 02. VANDHANA
    end;

    trigger OnModify()
    begin

        if Closed then
            Error(Text000);
    end;

    var
        Text000: Label 'Cannot be modified';
}

