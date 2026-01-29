table 71088 "Competition Res Team Line"
{
    // DS01, Cetas1.0 Added in 260712 Begin for Point not needed for substitude
    //   1.Code Added
    //     -Position - OnValidate()
    // DS01, Cetas1.0 Added in 260712 End for Point not needed for substitude.

    Caption = 'Competition Res Team Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(6; House; Code[20])
        {
            Caption = 'House';
            Editable = false;
            TableRelation = House;
        }
        field(8; "Competition Type"; Code[20])
        {
            Caption = 'Competition Type';
            Editable = false;
            TableRelation = "Competition Type";
        }
        field(9; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            Editable = false;
        }
        field(10; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            Editable = false;
            TableRelation = "Student Division";
        }
        field(11; Position; Option)
        {
            Caption = 'Position';
            OptionCaption = ',1st Place,2nd Place,3rd Place,4th place,5th place,6th place,Participation';
            OptionMembers = ,"1st Place","2nd Place","3rd Place","4th place","5th place","6th place",Participation;

            trigger OnValidate()
            begin
                //DS01 Added on 260712 -Begin
                if CompetitionResultTeam1.Get("Document No.") then;

                if CompetitionResultTeam.Get("Document No.") and CompetitionResultTeam."Update Results" then
                    Error(Text000);
                if CompetitionResultTeam1."Event Type" = CompetitionResultTeam1."Event Type"::Relay then begin
                    if CoCurricularPointsSetup.Get("Competition Type") then begin
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
                    end;
                end;
                if CompetitionResultTeam1."Event Type" = CompetitionResultTeam1."Event Type"::Team then begin
                    if CoCurricularPointsSetup.Get("Competition Type") then begin
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
                    end;
                end;

                if Points = 0 then
                    Error(Text001, "Competition Type");


                //DS01 Added on 260712 -End
            end;
        }
        field(12; Points; Decimal)
        {
            Caption = 'Points';
            Editable = true;
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(14; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
        }
        field(18; "Team No."; Code[20])
        {
            Caption = 'Team No.';
            Editable = true;
            TableRelation = "Participant Entry Line" WHERE ("Team No." = FIELD ("Team No."));
        }
        field(19; "Team Total Points"; Decimal)
        {
            CalcFormula = Sum ("Participant Entry Line".Points WHERE ("Team No." = FIELD ("Team No."),
                                                                     "Participant Type" = FILTER (Main),
                                                                     "Competition Entry No." = FIELD ("Competition Entry No.")));
            Caption = 'Team Total Points';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; "Details NUM"; Decimal)
        {
        }
        field(50001; "Details TXT"; Text[30])
        {
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
        Text000: Label 'Result has been updated, you cannot modify it.';
        Text001: Label 'Please enter the point for competition  type, %1.';
        CompetitionResultTeam1: Record "Competition Result Team";
}

