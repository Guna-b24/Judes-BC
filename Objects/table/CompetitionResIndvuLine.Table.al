table 71086 "Competition Res Indvu Line"
{
    Caption = 'Competition Res Indvu Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }

        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = true;
            DataClassification = CustomerContent;
        }

        field(4; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(5; Age; Decimal)
        {
            Caption = 'Age';
            DecimalPlaces = 0 : 0;
            Editable = true;
            DataClassification = CustomerContent;
        }

        field(6; House; Code[20])
        {
            Caption = 'House';
            TableRelation = House;
            Editable = true;
            DataClassification = CustomerContent;
        }

        field(7; "Participant Type"; Option)
        {
            Caption = 'Participant Type';
            OptionMembers = " ",Main,Substitute;
            OptionCaption = ' ,Main,Substitute';
            DataClassification = CustomerContent;
        }
        field(8; "Competition Type"; Code[20])
        {
            Caption = 'Competition Type';
            TableRelation = "Competition Type";
            Editable = true;
            DataClassification = CustomerContent;
        }

        field(9; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            Editable = true;
            DataClassification = CustomerContent;
        }

        field(10; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            TableRelation = "Student Division";
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(11; Position; Option)
        {
            Caption = 'Position';
            OptionCaption = ',1st Place,2nd Place,3rd Place,4th place,5th place,6th place,Participation';
            OptionMembers = ,"1st Place","2nd Place","3rd Place","4th place","5th place","6th place",Participation;

            trigger OnValidate()
            begin
                if CompetitionResultIndividual.Get("Document No.") and CompetitionResultIndividual."Update Results" then
                    Error(Text000);
                if CoCurricularPointsSetup.Get("Competition Type") then begin
                    case Position of
                        Position::"1st Place":

                            if xRec.Position = Position::"1st Place" then
                                Points := (CoCurricularPointsSetup."1st Place" + CoCurricularPointsSetup."2nd Place") / 2
                            //  xRec.Points := Points
                            else
                                Points := CoCurricularPointsSetup."1st Place";

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
            end;
        }
        field(12; Points; Decimal)
        {
            Caption = 'Points';
            Editable = true;
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(14; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; Months; Decimal)
        {
            Caption = 'Months';
            DecimalPlaces = 0 : 0;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(17; "Event Type"; Option)
        {
            Caption = 'Event Type';
            Editable = true;
            OptionCaption = ' ,Individual,Team';
            OptionMembers = " ",Individual,Team;
            DataClassification = CustomerContent;
        }
        field(20; Class; Code[10])
        {
            Caption = 'Class';
            TableRelation = Class;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50000; "Details NUM"; Decimal)
        {
            Caption = 'Details NUM';
            BlankZero = true;
            Editable = false;
        }
        field(50001; "Details TXT"; Text[140])
        {
            Caption = 'Details TXT';
            Editable = false;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70123; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = Section;
            Editable = false;
            DataClassification = CustomerContent;
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

