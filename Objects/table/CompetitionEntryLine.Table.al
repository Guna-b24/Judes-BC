table 71082 "Competition Entry Line"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   15.12CompetitionEntryHeader.Gender.09  VIGNESH  OnInsert()              Code added to enter the User id
    // 
    // SJ6.01 21/01/18 GB
    //   Remove team size validation

    Caption = 'Competition Entry Line';
    DrillDownPageID = 71094;
    LookupPageID = 71094;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            TableRelation = "Student Division";
        }
        field(4; "Min Age"; Integer)
        {
            Caption = 'Min Age';
        }
        field(5; "Cut Off Date"; Date)
        {
            Caption = 'Cut Off Date';
        }
        field(6; "Max Age"; Integer)
        {
            Caption = 'Max Age';
        }
        field(7; "Team Size"; Integer)
        {
            Caption = 'Team Size';

            trigger OnValidate()
            begin
                // >> SJ6.01
                // Start 01.VIGNESH
                //CompetitionEntryHeader.GET("Document No.");
                //IF (CompetitionEntryHeader."Event Type" <> CompetitionEntryHeader."Event Type"::Team) AND ("Team Size" <> 0) THEN BEGIN
                //  "Team Size" := 0;
                //  Substitute := 0;
                //  ERROR(Text000);
                //END;
                // Stop 01.VIGNESH
                // << SJ6.01
            end;
        }
        field(8; Substitute; Integer)
        {
            Caption = 'Substitute';

            trigger OnValidate()
            begin
                // >> SJ6.01
                // Start 02.VIGNESH
                //CompetitionEntryHeader.GET("Document No.");
                //IF (CompetitionEntryHeader."Event Type" <> CompetitionEntryHeader."Event Type"::Team) AND (Substitute <> 0) THEN BEGIN
                //  "Team Size" := 0;
                //  Substitute := 0;
                //  ERROR(Text000);
                //END;
                // Stop 02.VIGNESH
                // << SJ6.01
            end;
        }
        field(50000; "Temp Cut off Date"; Date)
        {
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
        field(70122; Gender; Option)
        {
            OptionCaption = ' ,Male,Female,Both';
            OptionMembers = " ",Male,Female,Both;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Student Division")
        {
            Clustered = true;
        }
        key(Key2; "Max Age")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.VIGNESH
        "User ID" := UserId;
        // Stop 01.VIGNESH
    end;

    var
        CompetitionEntryHeader: Record "Competition Entry Header";
        Text000: Label 'You cannot enter the substitute if event type is not Team.';
}

