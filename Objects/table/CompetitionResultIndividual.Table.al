table 71085 "Competition Result Individual"
{

    Caption = 'Competition Result Individual';
    DataClassification = CustomerContent;
    LookupPageId = "Competition Result Ind List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique number for the individual competition result.';

            trigger OnValidate()
            begin
                // Start 02.VIGNESH
                if "No." <> xRec."No." then begin
                    CoCurricularSetup.Get();
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
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the competition entry number linked to this individual result.';
            TableRelation = "Competition Entry Header" WHERE("Academic Year" = FIELD("Academic Year"),
                                                              "Event Type" = FILTER(Individual));

            trigger OnValidate()
            begin
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
            end;
        }
        field(3; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Shows the name of the competition.';
        }
        field(4; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the student division participating in the competition.';
            TableRelation = "Competition Entry Line"."Student Division" WHERE("Document No." = FIELD("Competition Entry No."));
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
            ToolTip = 'Specifies the number series used to assign the document number.';
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
            ToolTip = 'Specifies the date on which the competition was conducted.';
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
            ToolTip = 'Specifies whether the competition is an individual or team event.';
            OptionCaption = ' ,Individual,Team';
            OptionMembers = " ",Individual,Team;
        }

        field(12; "Update Results"; Boolean)
        {
            Caption = 'Update Results';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the competition result has been finalized and updated.';
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier for integration or tracking purposes.';
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
            CoCurricularSetup.TestField("Result Individual Entry No.");
            "No.Series" := CoCurricularSetup."Result Individual Entry No.";
            "No." := NoSeriesMgt.GetNextNo("No.Series");
        end;

        EducationSetup.Get();
        EducationSetup.TestField("Academic Year");
        "Academic Year" := EducationSetup."Academic Year";
    end;

    var
        EducationSetup: Record "Education Setup";
        CoCurricularSetup: Record "Co-Curricular Setup";
        RecResult: Record "Competition Result Individual";
        CompetitionEntryHeader: Record "Competition Entry Header";
        NoSeriesMgt: Codeunit "No. Series";



    procedure Assistedit(OldResult: Record "Competition Result Individual"): Boolean
    begin
        RecResult := Rec;
        CoCurricularSetup.Get();
        CoCurricularSetup.TestField("Result Individual Entry No.");
        if NoSeriesMgt.LookupRelatedNoSeries(CoCurricularSetup."Result Individual Entry No.", OldResult."No.Series", "No.Series") then begin
            RecResult."No." := NoSeriesMgt.GetNextNo(RecResult."No.Series");
            Rec := RecResult;
            exit(true);
        end;
    end;
}

