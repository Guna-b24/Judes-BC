table 71894 "Rank Generation"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01  13.10.09  VIGNESH   OnInsert()        Code added to generate the Entry No.
    // 02  19/10/09  VANDHANA  OnInsert          Code to assign User ID.

    Caption = 'Rank Generation';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Average"; Decimal)
        {
            Caption = 'Average';
        }
        field(3; Rank; Integer)
        {
            Caption = 'Rank';
        }
        field(4; "Entry No."; Code[20])
        {
            Caption = 'Entry No.';
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
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Average")
        {
        }
        key(Key3; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.VIGNESH
        EducationSetup.Get;
        EducationSetup.TestField(EducationSetup."Rank Generation No.");

        "Entry No." := "No.seriesManagement".GetNextNo(EducationSetup."Rank Generation No.", 0D, true);
        // Stop 01.VIGNESH

        // Start 02. VANDHANA
        "User ID" := UserId;
        // Stop 02. VANDHANA
    end;

    var
        EducationSetup: Record "Education Setup";
        "No.seriesManagement": Codeunit NoSeriesManagement;
}

