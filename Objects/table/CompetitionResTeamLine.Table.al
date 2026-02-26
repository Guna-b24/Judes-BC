table 71088 "Competition Res Team Line"
{

    Caption = 'Competition Res Team Line';
    LookupPageId = "Competition Res Team List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the competition result document number.';
            DataClassification = CustomerContent;
        }

        field(6; House; Code[20])
        {
            Caption = 'House';
            ToolTip = 'Specifies the house associated with the team.';
            Editable = false;
            TableRelation = House;
            DataClassification = CustomerContent;
        }

        field(8; "Competition Type"; Code[20])
        {
            Caption = 'Competition Type';
            ToolTip = 'Specifies the competition type.';
            Editable = false;
            TableRelation = "Competition Type";
            DataClassification = CustomerContent;
        }

        field(9; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            ToolTip = 'Specifies the name of the competition.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            ToolTip = 'Specifies the student division applicable for the competition.';
            Editable = false;
            TableRelation = "Student Division";
            DataClassification = CustomerContent;
        }

        field(11; Position; Option)
        {
            Caption = 'Position';
            ToolTip = 'Specifies the position secured by the team in the competition.';
            OptionCaption = ',1st Place,2nd Place,3rd Place,4th place,5th place,6th place,Participation';
            OptionMembers = ,"1st Place","2nd Place","3rd Place","4th place","5th place","6th place",Participation;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //DS01 Added on 260712 -Begin
                if CompetitionResultTeam1.Get("Document No.") then;

                if CompetitionResultTeam.Get("Document No.") and CompetitionResultTeam."Update Results" then
                    Error(Text000);
                if CompetitionResultTeam1."Event Type" = CompetitionResultTeam1."Event Type"::Relay then
                    if CoCurricularPointsSetup.Get("Competition Type") then
                        case Position of
                            Position::"1st Place":
                                //Points := CoCurricularPointsSetup."1st Place";
                                Points := (CoCurricularPointsSetup."1st Place" * 2.0) / CompetitionResultTeam1."Team Size";
                            Position::"2nd Place":
                                //Points := CoCurricularPointsSetup."2nd Place";
                                Points := (CoCurricularPointsSetup."2nd Place" * 2.0) / CompetitionResultTeam1."Team Size";
                            Position::"3rd Place":
                                //Points := CoCurricularPointsSetup."3rd Place";
                                Points := (CoCurricularPointsSetup."3rd Place" * 2.0) / CompetitionResultTeam1."Team Size";
                            Position::"4th place":
                                //Points := CoCurricularPointsSetup."4th Place";
                                Points := (CoCurricularPointsSetup."4th Place" * 2.0) / CompetitionResultTeam1."Team Size";
                            Position::"5th place":
                                //5th place and 6th place added by Sameer
                                //Points := CoCurricularPointsSetup."4th Place";
                                Points := (CoCurricularPointsSetup."5th Place" * 2.0) / CompetitionResultTeam1."Team Size";
                            Position::"6th place":
                                //Points := CoCurricularPointsSetup."4th Place";
                                Points := (CoCurricularPointsSetup."6th Place" * 2.0) / CompetitionResultTeam1."Team Size";

                            Position::Participation:
                                //Points := CoCurricularPointsSetup.Participation;
                                Points := (CoCurricularPointsSetup.Participation * 2.0) / CompetitionResultTeam1."Team Size";


                        end;
                if CompetitionResultTeam1."Event Type" = CompetitionResultTeam1."Event Type"::Team then
                    if CoCurricularPointsSetup.Get("Competition Type") then
                        case Position of
                            Position::"1st Place":
                                //Points := CoCurricularPointsSetup."1st Place";
                                Points := (CoCurricularPointsSetup."1st Place");
                            Position::"2nd Place":
                                //Points := CoCurricularPointsSetup."2nd Place";
                                Points := (CoCurricularPointsSetup."2nd Place");
                            Position::"3rd Place":
                                //Points := CoCurricularPointsSetup."3rd Place";
                                Points := (CoCurricularPointsSetup."3rd Place");
                            Position::"4th place":
                                //Points := CoCurricularPointsSetup."4th Place";
                                Points := (CoCurricularPointsSetup."4th Place");
                            Position::"5th place":
                                //5th place and 6th place added by Sameer
                                //Points := CoCurricularPointsSetup."4th Place";
                                Points := (CoCurricularPointsSetup."5th Place");
                            Position::"6th place":
                                //Points := CoCurricularPointsSetup."4th Place";
                                Points := (CoCurricularPointsSetup."6th Place");
                            Position::Participation:
                                //Points := CoCurricularPointsSetup.Participation;
                                Points := (CoCurricularPointsSetup.Participation);
                        end;



                if Points = 0 then
                    Error(Text001, "Competition Type");


                //DS01 Added on 260712 -End
            end;
        }
        field(12; Points; Decimal)
        {
            Caption = 'Points';
            ToolTip = 'Specifies the points awarded to the team.';
            Editable = true;
            DataClassification = CustomerContent;
        }

        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year.';
            DataClassification = CustomerContent;
        }

        field(14; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            ToolTip = 'Specifies the competition entry number.';
            DataClassification = CustomerContent;
        }

        field(18; "Team No."; Code[20])
        {
            Caption = 'Team No.';
            ToolTip = 'Specifies the team number.';
            Editable = true;
            TableRelation = "Participant Entry Line" WHERE("Team No." = FIELD("Team No."));
            DataClassification = CustomerContent;
        }

        field(19; "Team Total Points"; Decimal)
        {
            Caption = 'Team Total Points';
            ToolTip = 'Specifies the total points earned by the team.';
            CalcFormula = Sum("Participant Entry Line".Points WHERE(
                                "Team No." = FIELD("Team No."),
                                "Participant Type" = FILTER(Main),
                                "Competition Entry No." = FIELD("Competition Entry No.")));
            Editable = false;
            FieldClass = FlowField;

        }
        field(50000; "Details NUM"; Decimal)
        {
            ToolTip = 'Stores additional numeric details.';
            DataClassification = CustomerContent;
        }

        field(50001; "Details TXT"; Text[30])
        {
            ToolTip = 'Stores additional text details.';
            DataClassification = CustomerContent;
        }


        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal identifier.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Team No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CoCurricularPointsSetup: Record "Co-Curricular Points Setup";
        CompetitionResultTeam: Record "Competition Result Team";
        CompetitionResultTeam1: Record "Competition Result Team";
        Text000: Label 'Result has been updated, you cannot modify it.';
        Text001: Label 'Please enter the point for competition  type, %1.';

}

