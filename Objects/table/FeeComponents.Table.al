table 71905 "Fee Components"
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'Fee Components';
    DataPerCompany = false;
    DrillDownPageID = 71909;
    LookupPageID = 71909;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
        }
        field(4; "Fee Group"; Option)
        {
            Caption = 'Fee Group';
            OptionCaption = ' ,Admission,Exam ';
            OptionMembers = " ",Admission,"Exam ";
        }
        field(5; "Check Duplication"; Boolean)
        {
            Caption = 'Check Duplication';
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
}

