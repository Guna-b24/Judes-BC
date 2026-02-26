table 71087 "Competition Result Team"
{
    Caption = 'Competition Result Team';
    DataClassification = CustomerContent;
    LookupPageId = "Competition Result Team List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique number for the competition team result.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CoCurricularSetup.Get();
                    CoCurricularSetup.TestField("Result Team Entry No.");
                    NoSeriesMgt.TestManual(CoCurricularSetup."Result Team Entry No.");
                    "No.Series" := '';
                end;
            end;
        }
        field(2; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the competition entry number linked to this team result.';
            TableRelation = "Competition Entry Header" WHERE("Academic Year" = FIELD("Academic Year"),
                                                              "Event Type" = FILTER(Team | Relay));

            trigger OnValidate()
            begin
                if CompetitionEntryHeader.Get("Competition Entry No.") then begin
                    "Competition Name" := CompetitionEntryHeader."Competition Name";
                    "Competition Type" := CompetitionEntryHeader."Competition Type";
                    "Event Type" := CompetitionEntryHeader."Event Type";
                    "Student Division" := '';
                    "Team Size" := 0;
                    Substitute := 0;
                end else begin
                    "Competition Name" := '';
                    "Competition Type" := '';
                    "Event Type" := 0;
                    "Student Division" := '';
                    "Team Size" := 0;
                    Substitute := 0;
                end;
            end;
        }
        field(3; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Displays the name of the competition.';
        }
        field(4; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the student division participating in the competition.';
            TableRelation = "Competition Entry Line"."Student Division" WHERE("Document No." = FIELD("Competition Entry No."));

            trigger OnValidate()
            begin
                TestField("Competition Entry No.");
                if CompetitionEntryLine.Get("Competition Entry No.", "Student Division") then begin
                    "Team Size" := CompetitionEntryLine."Team Size";
                    Substitute := CompetitionEntryLine.Substitute;
                end else begin
                    "Team Size" := 0;
                    Substitute := 0;
                end;
            end;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year for the competition result.';
        }
        field(7; "No.Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series used to generate the document number.';
        }

        field(8; "Competition Type"; Code[20])
        {
            Caption = 'Competition Type';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the type of competition.';
            TableRelation = "Competition Type";
        }
        field(9; "Competition Date"; Date)
        {
            Caption = 'Competition Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date on which the competition was held.';
        }

        field(10; "Competition Status"; Option)
        {
            Caption = 'Competition Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the current status of the competition.';
            OptionCaption = ' ,Up Coming,On Going,Completed';
            OptionMembers = " ","Up Coming","On Going",Completed;
        }

        field(11; "Event Type"; Option)
        {
            Caption = 'Event Type';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the competition is a team or relay event.';
            OptionCaption = ' ,Individual,Team,Relay';
            OptionMembers = " ",Individual,Team,Relay;
        }

        field(12; "Update Results"; Boolean)
        {
            Caption = 'Update Results';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the competition results are finalized and locked.';
        }
        field(21; "Team Size"; Integer)
        {
            Caption = 'Team Size';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number of participants allowed in the team.';
        }

        field(22; Substitute; Integer)
        {
            Caption = 'Substitute';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number of substitute participants allowed.';
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier for integration or tracking.';
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
            CoCurricularSetup.TestField("Result Team Entry No.");
            "No.Series"
            := CoCurricularSetup."Result Team Entry No.";
            "No." := NoSeriesMgt.GetNextNo("No.Series");
        end;
        EducationSetup.Get();
        EducationSetup.TestField("Academic Year");
        "Academic Year" := EducationSetup."Academic Year";
    end;

    var
        EducationSetup: Record "Education Setup";
        CoCurricularSetup: Record "Co-Curricular Setup";
        RecResult: Record "Competition Result Team";
        CompetitionEntryHeader: Record "Competition Entry Header";
        CompetitionEntryLine: Record "Competition Entry Line";
        NoSeriesMgt: Codeunit "No. Series";

    procedure Assistedit(OldResult: Record "Competition Result Team"): Boolean
    begin

        RecResult := Rec;
        CoCurricularSetup.Get();
        CoCurricularSetup.TestField("Result Team Entry No.");
        if NoSeriesMgt.LookupRelatedNoSeries(CoCurricularSetup."Result Team Entry No.", OldResult."No.Series", "No.Series") then begin
            RecResult."No." := NoSeriesMgt.GetNextNo("No.Series");
            Rec := RecResult;
            exit(true);
        end;
    end;

}

