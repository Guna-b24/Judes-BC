table 71908 "Initial Fee Setup"
{
    // 
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01  23.09.09  VIGNESH   Fee Type Code - OnLookup()  Code added to get the description from Fee type
    // 02  19/10/09  VANDHANA  OnInsert                    Code to assign User ID.

    Caption = 'Initial Fee Setup';
    DrillDownPageID = 71912;
    LookupPageID = 71912;

    fields
    {
        field(1; "Fee Type Code"; Code[20])
        {
            Caption = 'Fee Type Code';
            NotBlank = true;
            TableRelation = "Fee Type";

            trigger OnValidate()
            begin
                // Start 01.VIGNESH
                if FeeType.Get("Fee Type Code") then
                    Description := FeeType.Description
                else
                    Description := '';
                // Stop 01.VIGNESH
            end;
        }
        field(2; Description; Text[30])
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
        key(Key1; "Fee Type Code")
        {
            Clustered = true;
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

    var
        FeeType: Record "Fee Type";
}

