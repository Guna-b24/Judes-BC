table 71077 "Co-Curricular Points Setup"
{
    Caption = 'Co-Curricular Points Setup';
    // DrillDownPageID = 71087;
    LookupPageID = "Co-Curricular Points Setup";

    fields
    {
        field(1; "Competition type"; Code[20])
        {
            Caption = 'Competition Type';
            ToolTip = 'Specifies the type of competition for which points are defined.';
            TableRelation = "Competition Type";
            NotBlank = true;
            DataClassification = CustomerContent;
        }

        field(2; "1st Place"; Decimal)
        {
            Caption = '1st Place';
            ToolTip = 'Specifies the points awarded for securing first place.';
            DataClassification = CustomerContent;
        }

        field(3; "2nd Place"; Decimal)
        {
            Caption = '2nd Place';
            ToolTip = 'Specifies the points awarded for securing second place.';
            DataClassification = CustomerContent;
        }
        field(4; "3rd Place"; Decimal)
        {
            Caption = '3rd Place';
            ToolTip = 'Specifies the points awarded for securing third place.';
            DataClassification = CustomerContent;
        }

        field(5; "4th Place"; Decimal)
        {
            Caption = '4th Place';
            ToolTip = 'Specifies the points awarded for securing fourth place.';
            DataClassification = CustomerContent;
        }
        field(70122; "5th Place"; Decimal)
        {
            Caption = '5th Place';
            ToolTip = 'Specifies the points awarded for securing fifth place.';
            DataClassification = CustomerContent;
        }

        field(70123; "6th Place"; Decimal)
        {
            Caption = '6th Place';
            ToolTip = 'Specifies the points awarded for securing sixth place.';
            DataClassification = CustomerContent;
        }
        field(6; Participation; Decimal)
        {
            Caption = 'Participation';
            ToolTip = 'Specifies the points awarded for participation in the competition.';
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference identifier.';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Competition type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


}

