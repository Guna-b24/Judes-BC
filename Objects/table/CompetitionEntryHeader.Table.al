table 71081 "Competition Entry Header"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   15.12.09  VIGNESH  OnInsert()                 Code added to enter the User id,academic Year & No. Series
    // 02   15.12.09  VIGNESH  No. - OnValidate()         Code added tfor generatring No. Series
    // 03   15.12.09  VIGNESH  Assistedit()               Function called for generating No. Series

    Caption = 'Competition Entry Header';
    DrillDownPageID = 71093;
    LookupPageID = 71093;

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
                    CoCurricularSetup.TestField("Competition Entry No.");
                    NoSeriesMgt.TestManual(CoCurricularSetup."Competition Entry No.");
                    "No.Series" := '';
                end;
                // Stop 02.VIGNESH
            end;
        }
        field(2; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
        }
        field(3; "Competition Type"; Code[20])
        {
            Caption = 'Competition Type';
            TableRelation = "Competition Type";
        }
        field(4; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(5; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
        }
        field(6; "Event Type"; Option)
        {
            Caption = 'Event Type';
            OptionCaption = ' ,Individual,Team,Relay';
            OptionMembers = " ",Individual,Team,Relay;
        }
        field(7; "Competition Date"; Date)
        {
            Caption = 'Competition Date';
        }
        field(8; "Competition Status"; Option)
        {
            Caption = 'Competition Status';
            OptionCaption = ' ,Up Coming,On Going,Completed';
            OptionMembers = " ","Up Coming","On Going",Completed;

            trigger OnValidate()
            begin
                //IF xRec."Competition Status" = xRec."Competition Status"::Completed THEN

                // ERROR(Text000);
                //CompetitionEntryLine.RESET;
                //CompetitionEntryLine.SETRANGE("Document No.","No.");
                //IF CompetitionEntryLine.FINDSET THEN
                //REPEAT
                //ParticipantEntryHeader.RESET;
                //ParticipantEntryHeader.SETCURRENTKEY("Competition Entry No.","Student Division");
                //ParticipantEntryHeader.SETRANGE("Competition Entry No.","No.");
                //ParticipantEntryHeader.SETRANGE("Student Division",CompetitionEntryLine."Student Division");
                //ParticipantEntryHeader.MODIFYALL("Competition Status","Competition Status");
                //UNTIL CompetitionEntryLine.NEXT = 0;
            end;
        }
        field(9; "Event Code"; Code[20])
        {
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
        field(70123; "Participant Entry From"; Date)
        {
        }
        field(70124; "Participant Entry Till"; Date)
        {
        }
        field(70125; ChampionShip; Code[30])
        {
        }
        field(70126; ParticipantEntryUsers; Text[100])
        {
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
        // Start 01.VIGNESH
        CoCurricularSetup.Get;
        if "No.Series" = '' then begin
            CoCurricularSetup.TestField("Competition Entry No.");
            NoSeriesMgt.InitSeries(CoCurricularSetup."Competition Entry No.", xRec."No.Series", 0D, "No.", "No.Series");
        end;

        "User ID" := UserId;
        EducationSetup.Get;
        EducationSetup.TestField("Academic Year");
        "Academic Year" := EducationSetup."Academic Year";
        // Stop 01.VIGNESH
    end;

    var
        EducationSetup: Record "Education Setup";
        CoCurricularSetup: Record "Co-Curricular Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RecEntry: Record "Competition Entry Header";
        CompetitionEntryHeader: Record "Competition Entry Header";
        CompetitionEntryLine: Record "Competition Entry Line";
        ParticipantEntryHeader: Record "Participant Entry Header";
        Text000: Label 'Once Completed it cannot be change';

    [Scope('Internal')]
    procedure Assistedit(OldEntry: Record "Competition Entry Header"): Boolean
    begin
        // Start 03.VIGNESH
        with RecEntry do begin
            RecEntry := Rec;
            CoCurricularSetup.Get;
            CoCurricularSetup.TestField("Competition Entry No.");
            if NoSeriesMgt.SelectSeries(CoCurricularSetup."Competition Entry No.", OldEntry."No.Series", "No.Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := RecEntry;
                exit(true);
            end;
        end;
        // Stop 03.VIGNESH
    end;
}

