table 71081 "Competition Entry Header"
{
    Caption = 'Competition Entry Header';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71093;
    LookupPageID = "Competition Entry List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the unique number of the competition entry document.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CoCurricularSetup.Get();
                    CoCurricularSetup.TestField("Competition Entry No.");
                    NoSeriesMgt.TestManual(CoCurricularSetup."Competition Entry No.");
                    "No.Series" := '';
                end;
            end;
        }
        field(2; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            ToolTip = 'Specifies the name of the competition.';
            DataClassification = CustomerContent;
        }

        field(3; "Competition Type"; Code[20])
        {
            Caption = 'Competition Type';
            ToolTip = 'Specifies the type of competition.';
            TableRelation = "Competition Type";
            DataClassification = CustomerContent;
        }

        field(4; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year for which the competition is conducted.';
            TableRelation = "Academic Year";
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "No.Series"; Code[20])
        {
            Caption = 'No. Series';
            ToolTip = 'Specifies the number series used for the competition entry.';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(6; "Event Type"; Option)
        {
            Caption = 'Event Type';
            ToolTip = 'Specifies whether the competition is an individual, team, or relay event.';
            OptionCaption = ' ,Individual,Team,Relay';
            OptionMembers = " ",Individual,Team,Relay;
            DataClassification = CustomerContent;
        }

        field(7; "Competition Date"; Date)
        {
            Caption = 'Competition Date';
            ToolTip = 'Specifies the date on which the competition is conducted.';
            DataClassification = CustomerContent;
        }

        field(8; "Competition Status"; Option)
        {
            Caption = 'Competition Status';
            ToolTip = 'Specifies the current status of the competition.';
            OptionCaption = ' ,Up Coming,On Going,Completed';
            OptionMembers = " ","Up Coming","On Going",Completed;
            DataClassification = CustomerContent;
        }
        field(9; "Event Code"; Code[20])
        {
            Caption = 'Event Code';
            ToolTip = 'Specifies the event master linked to this competition.';
            TableRelation = "Event Master";
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference identifier.';
            DataClassification = CustomerContent;
        }

        field(70122; Gender; Option)
        {
            Caption = 'Gender';
            ToolTip = 'Specifies the gender eligibility for the competition.';
            OptionCaption = ' ,Male,Female,Both';
            OptionMembers = " ",Male,Female,Both;
            DataClassification = CustomerContent;
        }
        field(70123; "Participant Entry From"; Date)
        {
            Caption = 'Participant Entry From';
            ToolTip = 'Specifies the starting date for participant entry.';
            DataClassification = CustomerContent;
        }

        field(70124; "Participant Entry Till"; Date)
        {
            Caption = 'Participant Entry Till';
            ToolTip = 'Specifies the last date for participant entry.';
            DataClassification = CustomerContent;
        }

        field(70125; ChampionShip; Code[30])
        {
            Caption = 'Championship';
            ToolTip = 'Specifies the championship or tournament name.';
            DataClassification = CustomerContent;
        }

        field(70126; ParticipantEntryUsers; Text[100])
        {
            Caption = 'Participant Entry Users';
            ToolTip = 'Specifies the users allowed to enter participant details.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            CoCurricularSetup.Get();
            CoCurricularSetup.TestField("Competition Entry No.");
            "No.Series" := CoCurricularSetup."Competition Entry No.";
            "No." := NoSeriesMgt.GetNextNo("No.Series");
        end;

        EducationSetup.Get();
        EducationSetup.TestField("Academic Year");
        "Academic Year" := EducationSetup."Academic Year";
    end;

    var
        EducationSetup: Record "Education Setup";
        CoCurricularSetup: Record "Co-Curricular Setup";
        RecEntry: Record "Competition Entry Header";
        NoSeriesMgt: Codeunit "No. Series";
        Text000: Label 'Once Completed it cannot be change';

    procedure Assistedit(OldEntry: Record "Competition Entry Header"): Boolean
    begin
        RecEntry := Rec;
        CoCurricularSetup.Get();
        CoCurricularSetup.TestField("Competition Entry No.");
        if NoSeriesMgt.LookupRelatedNoSeries(CoCurricularSetup."Competition Entry No.", OldEntry."No.Series", "No.Series") then begin
            RecEntry."No." := NoSeriesMgt.GetNextNo(RecEntry."No.Series");
            Rec := RecEntry;
            exit(true);
        end;
    end;
}

