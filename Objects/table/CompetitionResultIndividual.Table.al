table 71085 "Competition Result Individual"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   15.12.09  VIGNESH  OnInsert()                            Code added to enter the User id,academic Year & No. Series
    // 02   15.12.09  VIGNESH  No. - OnValidate()                    Code added tfor generatring No. Series
    // 03   15.12.09  VIGNESH  Assistedit()                          Function called for generating No. Series

    Caption = 'Competition Result Individual';

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
                    CoCurricularSetup.TestField("Result Individual Entry No.");
                    NoSeriesMgt.TestManual(CoCurricularSetup."Result Individual Entry No.");
                    "No.Series" := '';
                end;
                // Stop 02.VIGNESH
            end;
        }
        field(2; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            TableRelation = "Competition Entry Header" WHERE ("Academic Year" = FIELD ("Academic Year"),
                                                              "Event Type" = FILTER (Individual));

            trigger OnValidate()
            begin
                // Start 04.VIGNESH
                if CompetitionEntryHeader.Get("Competition Entry No.") then begin
                    "Competition Name" := CompetitionEntryHeader."Competition Name";
                    "Competition Type" := CompetitionEntryHeader."Competition Type";
                    "Event Type" := CompetitionEntryHeader."Event Type";
                    "Student Division" := '';
                    "Competition Date" := CompetitionEntryHeader."Competition Date";
                    "Competition Status" := CompetitionEntryHeader."Competition Status";
                end else begin
                    "Competition Name" := '';
                    "Competition Type" := '';
                    "Event Type" := 0;
                    "Student Division" := '';
                end;
                // Stop 04.VIGNESH
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
            Editable = false;
            TableRelation = "Competition Type";
        }
        field(9; "Competition Date"; Date)
        {
            Caption = 'Competition Date';
        }
        field(10; "Competition Status"; Option)
        {
            Caption = 'Competition Status';
            OptionCaption = ' ,Up Coming,On Going,Completed';
            OptionMembers = " ","Up Coming","On Going",Completed;
        }
        field(11; "Event Type"; Option)
        {
            Caption = 'Event Type';
            Editable = false;
            OptionCaption = ' ,Individual,Team';
            OptionMembers = " ",Individual,Team;
        }
        field(12; "Update Results"; Boolean)
        {
            Caption = 'Update Results';
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
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.VIGNESH
        CoCurricularSetup.Get;
        if "No.Series" = '' then begin
            CoCurricularSetup.TestField("Result Individual Entry No.");
            NoSeriesMgt.InitSeries(CoCurricularSetup."Result Individual Entry No.", xRec."No.Series", 0D, "No.", "No.Series");
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
        RecResult: Record "Competition Result Individual";
        CompetitionEntryHeader: Record "Competition Entry Header";

    [Scope('Internal')]
    procedure Assistedit(OldResult: Record "Competition Result Individual"): Boolean
    begin
        // Start 03.VIGNESH
        with RecResult do begin
            RecResult := Rec;
            CoCurricularSetup.Get;
            CoCurricularSetup.TestField("Result Individual Entry No.");
            if NoSeriesMgt.SelectSeries(CoCurricularSetup."Result Individual Entry No.", OldResult."No.Series", "No.Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := RecResult;
                exit(true);
            end;
        end;
        // Stop 03.VIGNESH
    end;
}

