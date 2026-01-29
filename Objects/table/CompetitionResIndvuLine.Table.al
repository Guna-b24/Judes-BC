table 71086 "Competition Res Indvu Line"
{
    Caption = 'Competition Res Indvu Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = true;
        }
        field(4; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            Editable = true;
        }
        field(5; Age; Decimal)
        {
            Caption = 'Age';
            DecimalPlaces = 0 : 0;
            Editable = true;
        }
        field(6; House; Code[20])
        {
            Caption = 'House';
            Editable = true;
            TableRelation = House;
        }
        field(7; "Participant Type"; Option)
        {
            Caption = 'Participant Type';
            OptionCaption = ' ,Main,Substitute';
            OptionMembers = " ",Main,Substitute;
        }
        field(8; "Competition Type"; Code[20])
        {
            Caption = 'Competition Type';
            Editable = true;
            TableRelation = "Competition Type";
        }
        field(9; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            Editable = true;
        }
        field(10; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            Editable = true;
            TableRelation = "Student Division";
        }
        field(11; Position; Option)
        {
            Caption = 'Position';
            OptionCaption = ',1st Place,2nd Place,3rd Place,4th place,5th place,6th place,Participation';
            OptionMembers = ,"1st Place","2nd Place","3rd Place","4th place","5th place","6th place",Participation;

            trigger OnValidate()
            begin
                // Start 04.VIGNESH

                if CompetitionResultIndividual.Get("Document No.") and CompetitionResultIndividual."Update Results" then
                    Error(Text000);



                if CoCurricularPointsSetup.Get("Competition Type") then begin
                    case Position of
                        Position::"1st Place":
                            begin
                                if xRec.Position = Position::"1st Place" then begin
                                    Points := (CoCurricularPointsSetup."1st Place" + CoCurricularPointsSetup."2nd Place") / 2;
                                    xRec.Points := Points
                                end else
                                    Points := CoCurricularPointsSetup."1st Place";
                            end;
                        Position::"2nd Place":
                            Points := CoCurricularPointsSetup."2nd Place";
                        Position::"3rd Place":
                            Points := CoCurricularPointsSetup."3rd Place";
                        Position::"4th place":
                            Points := CoCurricularPointsSetup."4th Place";
                        Position::"5th place":
                            Points := CoCurricularPointsSetup."5th Place";
                        Position::"6th place":
                            Points := CoCurricularPointsSetup."6th Place";
                        Position::Participation:
                            Points := CoCurricularPointsSetup.Participation;
                    end;
                    if Points = 0 then
                        Error(Text001, "Competition Type");
                end;

                // Stop 04.VIGNESH
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
        field(15; Months; Decimal)
        {
            Caption = 'Months';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(17; "Event Type"; Option)
        {
            Caption = 'Event Type';
            Editable = true;
            OptionCaption = ' ,Individual,Team';
            OptionMembers = " ",Individual,Team;
        }
        field(20; Class; Code[10])
        {
        }
        field(50000; "Details NUM"; Decimal)
        {
        }
        field(50001; "Details TXT"; Text[140])
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
        field(70123; Section; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Student No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CoCurricularPointsSetup: Record "Co-Curricular Points Setup";
        CompetitionResultIndividual: Record "Competition Result Individual";
        Text000: Label 'Result has been updated, you cannot modify it.';
        Text001: Label 'Please enter the Point for Competition type %1.';
}

