table 71082 "Competition Entry Line"
{
    Caption = 'Competition Entry Line';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71094;
    // LookupPageID = 71094;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            TableRelation = "Student Division";
            DataClassification = CustomerContent;
        }
        field(4; "Min Age"; Integer)
        {
            Caption = 'Min Age';
            DataClassification = CustomerContent;
        }

        field(5; "Cut Off Date"; Date)
        {
            Caption = 'Cut Off Date';
            DataClassification = CustomerContent;
        }

        field(6; "Max Age"; Integer)
        {
            Caption = 'Max Age';
            DataClassification = CustomerContent;
        }

        field(7; "Team Size"; Integer)
        {
            Caption = 'Team Size';
            DataClassification = CustomerContent;
        }

        field(8; Substitute; Integer)
        {
            Caption = 'Substitute';
            DataClassification = CustomerContent;
        }

        field(50000; "Temp Cut off Date"; Date)
        {
            Caption = 'Temp Cut off Date';
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
        }

        field(70122; Gender; Option)
        {
            Caption = 'Gender';
            OptionMembers = " ",Male,Female,Both;
            OptionCaption = ' ,Male,Female,Both';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.", "Student Division")
        {
        }
        key(Key3; "Max Age")
        {
        }
    }

    fieldgroups
    {
    }

    var
        //  CompetitionEntryHeader: Record "Competition Entry Header";
        Text000: Label 'You cannot enter the substitute if event type is not Team.';
}

