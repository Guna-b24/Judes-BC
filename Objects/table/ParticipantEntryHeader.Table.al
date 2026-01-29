table 71083 "Participant Entry Header"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   15.12.09  VIGNESH  OnInsert()                            Code added to enter the User id,academic Year & No. Series
    // 02   15.12.09  VIGNESH  No. - OnValidate()                    Code added tfor generatring No. Series
    // 03   15.12.09  VIGNESH  Assistedit()                          Function called for generating No. Series
    // 04   15.12.09  VIGNESH  Competition Entry No. - OnValidate()  Code added to get the Competition Name & Type
    // 05   15.12.09  VIGNESH  Student Division - OnValidate()       Code added for validatidating the Student Division
    // 06   15.12.09  VIGNESH  House - OnValidate()                  Code added for validating House
    // SJ6.01 21/01/18 GB
    //   Autogenerate team no

    Caption = 'Participant Entry Header';
    DrillDownPageID = 71097;
    LookupPageID = 71097;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                // Start 02.VIGNESH
                if "No." <> xRec."No." then begin
                    CoCurricularSetup.Get;
                    CoCurricularSetup.TestField("Participant Entry No.");
                    NoSeriesMgt.TestManual(CoCurricularSetup."Participant Entry No.");
                    "No.Series" := '';
                end;
                // Stop 02.VIGNESH
            end;
        }
        field(2; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            TableRelation = "Competition Entry Header" WHERE ("Academic Year" = FIELD ("Academic Year"),
                                                              "Competition Status" = FILTER (<> Completed));

            trigger OnValidate()
            begin
                // Start 04.VIGNESH
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
                // Stop 04.VIGNESH

                // >> SJ6.01
                Validate("Event Type");
                // << SJ6.01
            end;
        }
        field(3; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            Editable = false;
        }
        field(4; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            TableRelation = "Competition Entry Line"."Student Division" WHERE ("Document No." = FIELD ("Competition Entry No."));

            trigger OnValidate()
            begin
                // Start 05.VIGNESH
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

                // Stop 05.VIGNESH
            end;
        }
        field(5; House; Code[20])
        {
            Caption = 'House';
            TableRelation = House;

            trigger OnValidate()
            begin
                // Start 06.VIGNESH
                if "Update Entry" then
                    Error(Text000);

                ParticipantEntryHeader.Reset;
                ParticipantEntryHeader.SetRange("Competition Entry No.", "Competition Entry No.");
                ParticipantEntryHeader.SetRange("Student Division", "Student Division");
                ParticipantEntryHeader.SetRange(House, House);
                if ParticipantEntryHeader.FindFirst then
                    Error(Text001);

                // Stop 06.VIGNESH
            end;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(7; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
        }
        field(8; "Competition Type"; Code[20])
        {
            Caption = 'Competition Type';
            Editable = true;
            TableRelation = "Competition Type";
        }
        field(9; "Update Entry"; Boolean)
        {
            Caption = 'Update Entry';
        }
        field(10; "Update Results"; Boolean)
        {
            Caption = 'Update Results';
        }
        field(11; "Event Type"; Option)
        {
            Caption = 'Event Type';
            Editable = false;
            OptionCaption = ' ,Individual,Team';
            OptionMembers = " ",Individual,Team;

            trigger OnValidate()
            begin
                // >> SJ6.01
                if ("Event Type" = "Event Type"::Team) and ("Team No." = '') then begin
                    CoCurricularSetup.Get;
                    CoCurricularSetup.TestField("Last Used Team No");
                    "Team No." := IncStr(CoCurricularSetup."Last Used Team No");
                    CoCurricularSetup."Last Used Team No" := "Team No.";
                    CoCurricularSetup.Modify;
                end;
                // << SJ6.01
            end;
        }
        field(12; "Team No."; Code[20])
        {
            Caption = 'Team No.';

            trigger OnValidate()
            begin
                // Start 04.VIGNESH
                if "Event Type" <> "Event Type"::Team then
                    Error(Text002);
                ParticipantEntryHeader.Reset;
                ParticipantEntryHeader.SetRange(ParticipantEntryHeader."Competition Name", "Competition Name");
                ParticipantEntryHeader.SetRange("Team No.", "Team No.");
                if ParticipantEntryHeader.FindFirst then
                    Error(Text003);
                // Stop 04.VIGNESH
            end;
        }
        field(13; "Team Size"; Integer)
        {
            Caption = 'Team Size';
        }
        field(14; Substitute; Integer)
        {
            Caption = 'Substitute';
        }
        field(15; "Competition Date"; Date)
        {
            Caption = 'Competition Date';
        }
        field(16; "Competition Status"; Option)
        {
            Caption = 'Competition Status';
            OptionCaption = ' ,Up Coming,On Going,Completed';
            OptionMembers = " ","Up Coming","On Going",Completed;
        }
        field(17; Class; Code[10])
        {
            TableRelation = Class;
        }
        field(18; "Event Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Event Master";
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
        field(70123; Section; Code[10])
        {
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
        // Start 01.VIGNESH
        CoCurricularSetup.Get;
        if "No.Series" = '' then begin
            CoCurricularSetup.TestField("Participant Entry No.");
            NoSeriesMgt.InitSeries(CoCurricularSetup."Participant Entry No.", xRec."No.Series", 0D, "No.", "No.Series");
        end;
        "User ID" := UserId;
        EducationSetup.Get;
        EducationSetup.TestField("Academic Year");
        "Academic Year" := EducationSetup."Academic Year";
        // Stop 01.VIGNESH

        if "Event Type" = "Event Type"::Individual then begin
            //  "Team Size":= 1;    SJ6.01
            Substitute := 1;
        end;
    end;

    var
        EducationSetup: Record "Education Setup";
        CoCurricularSetup: Record "Co-Curricular Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RecParticipant: Record "Participant Entry Header";
        CompetitionEntryHeader: Record "Competition Entry Header";
        CompetitionEntryLine: Record "Competition Entry Line";
        ParticipantEntryHeader: Record "Participant Entry Header";
        Text000: Label 'You cannot modify the entry, entry is updated.';
        Text001: Label 'House has already been selected before.';
        Text002: Label 'Only for the team event type, team no. is required.';
        Text003: Label 'Team no. should be unique.';
        Text004: Label 'Entry time expired';

    [Scope('Internal')]
    procedure Assistedit(OldParticipant: Record "Participant Entry Header"): Boolean
    begin
        // Start 03.VIGNESH
        with RecParticipant do begin
            RecParticipant := Rec;
            CoCurricularSetup.Get;
            CoCurricularSetup.TestField(CoCurricularSetup."Participant Entry No.");
            if NoSeriesMgt.SelectSeries(CoCurricularSetup."Participant Entry No.", OldParticipant."No.Series", "No.Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := RecParticipant;
                exit(true);
            end;
        end;
        // Stop 03.VIGNESH
    end;
}

