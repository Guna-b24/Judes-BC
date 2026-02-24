table 71083 "Participant Entry Header"
{
    Caption = 'Participant Entry Header';
    DataClassification = ToBeClassified;
    LookupPageID = "Participant Entry List";
    DrillDownPageID = "Participant Entry List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            ToolTip = 'Unique number for the participant entry.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CoCurricularSetup.Get();
                    CoCurricularSetup.TestField("Participant Entry No.");
                    NoSeriesMgt.TestManual(CoCurricularSetup."Participant Entry No.");
                    "No.Series" := '';
                end;
            end;
        }
        field(2; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            DataClassification = ToBeClassified;
            ToolTip = 'Reference to the competition entry.';
            TableRelation = "Competition Entry Header" WHERE("Academic Year" = FIELD("Academic Year"),
                                                              "Competition Status" = FILTER(<> Completed));

            trigger OnValidate()
            begin
                if "Update Entry" then
                    Error(Text000);

                if CompetitionEntryHeader.Get("Competition Entry No.") then begin
                    if (CompetitionEntryHeader."Participant Entry From" <= Today) and
                       (CompetitionEntryHeader."Participant Entry Till" >= Today) then begin
                        "Competition Name" := CompetitionEntryHeader."Competition Name";
                        "Competition Type" := CompetitionEntryHeader."Competition Type";
                        "Event Type" := CompetitionEntryHeader."Event Type";
                        Gender := CompetitionEntryHeader.Gender;
                        "Team No." := '';
                        "Student Division" := '';
                        "Competition Date" := CompetitionEntryHeader."Competition Date";
                        "Competition Status" := CompetitionEntryHeader."Competition Status";
                        "Event Code" := CompetitionEntryHeader."Event Code";
                    end
                    else
                        Error(Text004);
                end else begin
                    "Competition Name" := '';
                    "Competition Type" := '';
                    "Event Type" := 0;
                    "Team No." := '';
                    "Student Division" := '';
                end;
                Validate("Event Type");

            end;
        }
        field(3; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            DataClassification = ToBeClassified;
            ToolTip = 'Name of the competition.';
            Editable = false;
        }
        field(4; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            DataClassification = ToBeClassified;
            ToolTip = 'The student division for the entry.';
            TableRelation = "Competition Entry Line"."Student Division" WHERE("Document No." = FIELD("Competition Entry No."));

            trigger OnValidate()
            begin
                if "Update Entry" then
                    Error(Text000);

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
        field(5; House; Code[20])
        {
            Caption = 'House';
            DataClassification = ToBeClassified;
            ToolTip = 'House selected by the participant.';
            TableRelation = House;

            trigger OnValidate()
            begin

                if "Update Entry" then
                    Error(Text000);

                ParticipantEntryHeader.Reset();
                ParticipantEntryHeader.SetRange("Competition Entry No.", "Competition Entry No.");
                ParticipantEntryHeader.SetRange("Student Division", "Student Division");
                ParticipantEntryHeader.SetRange(House, House);
                if ParticipantEntryHeader.FindFirst() then
                    Error(Text001);

            end;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = ToBeClassified;
            ToolTip = 'Academic year of the competition.';
        }
        field(7; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = ToBeClassified;
            ToolTip = 'No series for automatic numbering.';
        }
        field(8; "Competition Type"; Code[20])
        {
            Caption = 'Competition Type';
            DataClassification = ToBeClassified;
            ToolTip = 'Type of the competition.';
            Editable = true;
            TableRelation = "Competition Type";
        }
        field(9; "Update Entry"; Boolean)
        {
            Caption = 'Update Entry';
            DataClassification = ToBeClassified;
            ToolTip = 'Indicates whether this entry is updated.';
        }
        field(10; "Update Results"; Boolean)
        {
            Caption = 'Update Results';
            DataClassification = ToBeClassified;
            ToolTip = 'Indicates whether results are updated.';
        }
        field(11; "Event Type"; Option)
        {
            Caption = 'Event Type';
            DataClassification = ToBeClassified;
            ToolTip = 'Type of event (Individual/Team).';
            Editable = false;
            OptionCaption = ' ,Individual,Team';
            OptionMembers = " ",Individual,Team;
            trigger OnValidate()
            begin
                if ("Event Type" = "Event Type"::Team) and ("Team No." = '') then begin
                    CoCurricularSetup.Get();
                    CoCurricularSetup.TestField("Last Used Team No");
                    "Team No." := IncStr(CoCurricularSetup."Last Used Team No");
                    CoCurricularSetup."Last Used Team No" := "Team No.";
                    CoCurricularSetup.Modify();
                end;
            end;
        }
        field(12; "Team No."; Code[20])
        {
            Caption = 'Team No.';
            DataClassification = ToBeClassified;
            ToolTip = 'Team number for the entry.';

            trigger OnValidate()
            begin
                if "Event Type" <> "Event Type"::Team then
                    Error(Text002);
                ParticipantEntryHeader.Reset();
                ParticipantEntryHeader.SetRange(ParticipantEntryHeader."Competition Name", "Competition Name");
                ParticipantEntryHeader.SetRange("Team No.", "Team No.");
                if ParticipantEntryHeader.FindFirst() then
                    Error(Text003);

            end;
        }
        field(13; "Team Size"; Integer)
        {
            Caption = 'Team Size';
            DataClassification = ToBeClassified;
            ToolTip = 'Size of the team.';
        }
        field(14; Substitute; Integer)
        {
            Caption = 'Substitute';
            DataClassification = ToBeClassified;
            ToolTip = 'Number of substitutes.';
        }
        field(15; "Competition Date"; Date)
        {
            Caption = 'Competition Date';
            DataClassification = ToBeClassified;
            ToolTip = 'Date of the competition.';
        }
        field(16; "Competition Status"; Option)
        {
            Caption = 'Competition Status';
            DataClassification = ToBeClassified;
            ToolTip = 'Status of the competition.';
            OptionCaption = ' ,Up Coming,On Going,Completed';
            OptionMembers = " ","Up Coming","On Going",Completed;
        }
        field(17; Class; Code[10])
        {
            Caption = 'Class';
            DataClassification = ToBeClassified;
            ToolTip = 'Class of the participant.';
            TableRelation = Class;
        }
        field(18; "Event Code"; Code[20])
        {
            Caption = 'Event Code';
            DataClassification = ToBeClassified;
            ToolTip = 'Code of the event.';
            Editable = false;
            TableRelation = "Event Master";
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = ToBeClassified;
            ToolTip = 'Portal ID for external reference.';
        }
        field(70122; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = ToBeClassified;
            ToolTip = 'Gender of participant.';
            OptionCaption = ' ,Male,Female,Both';
            OptionMembers = " ",Male,Female,Both;
        }
        field(70123; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = ToBeClassified;
            ToolTip = 'Section of participant.';
            TableRelation = Section;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Competition Entry No.", "Student Division")
        {
        }
        key(Key3; "Competition Entry No.", "Student Division", House)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            CoCurricularSetup.Get();
            CoCurricularSetup.TestField("Participant Entry No.");
            "No.series" := CoCurricularSetup."Participant Entry No.";
            "No." := NoSeriesMgt.GetNextNo("No.Series");

        end;
        EducationSetup.Get();
        EducationSetup.TestField("Academic Year");
        "Academic Year" := EducationSetup."Academic Year";


        if "Event Type" = "Event Type"::Individual then
            Substitute := 1;
    end;


    var
        EducationSetup: Record "Education Setup";
        CoCurricularSetup: Record "Co-Curricular Setup";
        RecParticipant: Record "Participant Entry Header";
        CompetitionEntryHeader: Record "Competition Entry Header";
        CompetitionEntryLine: Record "Competition Entry Line";
        ParticipantEntryHeader: Record "Participant Entry Header";
        NoSeriesMgt: Codeunit "No. Series";
        Text000: Label 'You cannot modify the entry, entry is updated.';
        Text001: Label 'House has already been selected before.';
        Text002: Label 'Only for the team event type, team no. is required.';
        Text003: Label 'Team no. should be unique.';
        Text004: Label 'Entry time expired';

    procedure Assistedit(OldParticipant: Record "Participant Entry Header"): Boolean
    begin

        RecParticipant := Rec;
        CoCurricularSetup.Get();
        CoCurricularSetup.TestField(CoCurricularSetup."Participant Entry No.");
        if NoSeriesMgt.LookupRelatedNoSeries(CoCurricularSetup."Participant Entry No.", OldParticipant."No.Series", "No.Series") then begin
            RecParticipant."No." := NoSeriesMgt.GetNextNo(RecParticipant."No.Series");
            Rec := RecParticipant;
            exit(true);
        end;
    end;

}

