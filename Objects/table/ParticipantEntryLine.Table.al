table 71084 "Participant Entry Line"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   15.12.09  VIGNESH  OnInsert()                      Code added to enter the User id,Competition name,type & division
    // 02   15.12.09  VIGNESH  Student No. - OnLookup()        Code added to validate & look up the students based on age
    // 03   15.12.09  VIGNESH  Participant Type - OnValidate() Code added for validating Particioant type
    // 04   15.12.09  VIGNESH  Position - OnValidate()         Code added to get the points based on position
    // 05   15.12.09  VIGNESH  Update Results - OnValidate()   Code added for validating Update Results

    Caption = 'Participant Entry Line';
    DrillDownPageID = 71102;
    LookupPageID = 71102;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';

            trigger OnLookup()
            begin
                // Start 02.VIGNESH
                //TESTFIELD(House);
                //TESTFIELD("Academic Year");
                EducationSetup.Get;
                EducationSetup.TestField("Academic Year");
                Student.ClearMarks;
                if ParticipantEntryHeader.Get("Document No.") then;

                if CompType.Get(ParticipantEntryHeader."Competition Type") then begin
                    if CompType."Entire Class" = false then begin
                        CompetitionEntryLine.Reset;
                        CompetitionEntryLine.SetRange("Document No.", ParticipantEntryHeader."Competition Entry No.");
                        CompetitionEntryLine.SetRange("Student Division", ParticipantEntryHeader."Student Division");
                        if CompetitionEntryLine.FindFirst then begin
                            CompetitionEntryLine.TestField("Min Age");
                            CompetitionEntryLine.TestField("Max Age");
                            CompetitionEntryLine.TestField("Cut Off Date");
                            Student.ClearMarks;
                            Student.Reset;
                            Student.SetRange("Student Status", Student."Student Status"::Student);

                            //added by prakash
                            if ParticipantEntryHeader.Gender <> 3 then
                                Student.SetRange(Gender, ParticipantEntryHeader.Gender);

                            if ParticipantEntryHeader.House <> '' then
                                Student.SetRange(House, ParticipantEntryHeader.House);
                            Student.SetRange("Academic Year", EducationSetup."Academic Year");
                            if Student.FindSet then
                                repeat
                                    LocalAge := 0;
                                    TempAge := 0;
                                    Months1 := 0;
                                    if Student."Date Of Birth" <> 0D then begin
                                        LocalAge := CompetitionEntryLine."Cut Off Date" - Student."Date Of Birth";
                                        TempAge := Round(LocalAge / 365, 1, '<');
                                        Age2 := LocalAge mod 365;
                                        Months1 := Round(Age2 / 30, 1, '=');
                                        LocalAge := TempAge;
                                    end;
                                    if (LocalAge >= CompetitionEntryLine."Min Age") and (LocalAge <= CompetitionEntryLine."Max Age") then begin
                                        if (LocalAge = CompetitionEntryLine."Max Age") and (Months1 < 0) then
                                            Student.Mark(true)
                                        else
                                            if LocalAge < CompetitionEntryLine."Max Age" then
                                                Student.Mark(true);
                                    end;
                                until Student.Next = 0;
                            Student.MarkedOnly(true);
                            if PAGE.RunModal(0, Student) = ACTION::LookupOK then begin
                                "Student No." := Student."No.";
                                "Student Name" := Student.Name;
                                Student.TestField(House);
                                House := Student.House;
                                Gender := Student.Gender;
                                "Competition Entry No." := ParticipantEntryHeader."Competition Entry No.";
                                "Team No." := ParticipantEntryHeader."Team No.";
                                "Student Division" := ParticipantEntryHeader."Student Division";
                                "Event Type" := ParticipantEntryHeader."Event Type";
                                "Event Code" := ParticipantEntryHeader."Event Code";
                                Validate("Student No.");
                            end;
                        end;
                    end else begin
                        Student.Reset;
                        Student.SetRange(Student.Class, ParticipantEntryHeader.Class);
                        Student.SetRange(Student.Section, ParticipantEntryHeader.Section);
                        if PAGE.RunModal(0, Student) = ACTION::LookupOK then begin
                            "Student No." := Student."No.";
                            "Student Name" := Student.Name;
                            Student.TestField(House);
                            House := Student.House;
                            Gender := Student.Gender;
                        end;
                    end;

                end;
            end;

            trigger OnValidate()
            begin
                if ParticipantEntryHeader.Get("Document No.") then begin
                    if ParticipantEntryHeader."Update Entry" then
                        Error(Text001);
                    ParticipantEntryHeader.TestField("Competition Entry No.");
                    ParticipantEntryHeader.TestField("Student Division");
                    // IF ParticipantEntryHeader."Event Type" <> ParticipantEntryHeader."Event Type"::Team THEN BEGIN
                    //ParticipantEntryHeader.TESTFIELD(ParticipantEntryHeader.House);
                    // ParticipantEntryLine.RESET;
                    //ParticipantEntryLine.SETRANGE("Document No.","Document No.");
                    //IF ParticipantEntryLine.FINDFIRST THEN
                    //ERROR(Text000);
                    //END;

                    CompetitionEntryLine.Reset;
                    CompetitionEntryLine.SetRange("Document No.", ParticipantEntryHeader."Competition Entry No.");
                    CompetitionEntryLine.SetRange("Student Division", ParticipantEntryHeader."Student Division");

                    if CompetitionEntryLine.FindFirst then begin
                        CompetitionEntryLine.TestField("Min Age");
                        CompetitionEntryLine.TestField("Max Age");
                        CompetitionEntryLine.TestField("Cut Off Date");
                        Student.Reset;
                        if Student.Get("Student No.") then begin
                            if Student."Date Of Birth" <> 0D then begin
                                LocalAge1 := CompetitionEntryLine."Cut Off Date" - Student."Date Of Birth";
                                TempAge1 := Round(LocalAge1 / 365, 1, '<');
                                Age3 := LocalAge1 mod 365;
                                Months2 := Round(Age3 / 30, 1, '=');
                                Age := TempAge1;
                                Months := Months2;
                                Student.TestField(House);
                                // House :=Student.House;
                            end else begin
                                Age := 0;
                                Months := 0;
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(4; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
        }
        field(5; Age; Decimal)
        {
            Caption = 'Age';
            DecimalPlaces = 0 : 0;
        }
        field(6; House; Code[20])
        {
            Caption = 'House';
            TableRelation = House;
        }
        field(7; "Participant Type"; Option)
        {
            Caption = 'Participant Type';
            OptionCaption = ' ,Main,Substitute';
            OptionMembers = " ",Main,Substitute;

            trigger OnValidate()
            begin
                // Start 03.VIGNESH
                ParticipantEntryHeader.Get("Document No.");
                if ParticipantEntryHeader."Update Entry" then
                    Error(Text001);

                //IF ParticipantEntryHeader."Event Type" <> ParticipantEntryHeader."Event Type"::Team THEN
                //  ERROR(Text002);
                if ParticipantEntryHeader."Event Type" = ParticipantEntryHeader."Event Type"::Team then begin
                    if CompetitionEntryLine.Get(ParticipantEntryHeader."Competition Entry No.", ParticipantEntryHeader."Student Division") then begin
                        CompetitionEntryLine.TestField("Team Size");
                        ParticipantEntryLine.Reset;
                        ParticipantEntryLine.SetRange("Document No.", "Document No.");
                        if "Participant Type" = "Participant Type"::Main then begin
                            ParticipantEntryLine.SetRange("Participant Type", ParticipantEntryLine."Participant Type"::Main);
                            if CompetitionEntryLine."Team Size" <= ParticipantEntryLine.Count then
                                Error(Text003, CompetitionEntryLine."Team Size");
                        end else
                            if "Participant Type" = "Participant Type"::Substitute then begin
                                ParticipantEntryLine.SetRange("Participant Type", ParticipantEntryLine."Participant Type"::Substitute);
                                if CompetitionEntryLine.Substitute <= ParticipantEntryLine.Count then
                                    Error(Text004, CompetitionEntryLine.Substitute);
                            end;
                    end;
                end;
                // Stop 03.VIGNESH
                if "Participant Type" <> 0 then begin
                    if ParticipantEntryHeader.Get("Document No.") then;
                    "Team No." := ParticipantEntryHeader."Team No.";
                end
                else
                    "Team No." := '';
            end;
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
        }
        field(17; "Event Type"; Option)
        {
            Caption = 'Event Type';
            Editable = true;
            OptionCaption = ' ,Individual,Team';
            OptionMembers = " ",Individual,Team;
        }
        field(18; "Team No."; Code[20])
        {
            Caption = 'Team No.';
        }
        field(19; "Update Results"; Boolean)
        {
            Caption = 'Update Results';
        }
        field(20; Class; Code[10])
        {
            TableRelation = Class;
        }
        field(21; "Event Code"; Code[20])
        {
            TableRelation = "Event Master";
        }
        field(50000; "Details NUM"; Decimal)
        {
        }
        field(50001; "Details TXT"; Text[140])
        {
        }
        field(50002; "Update Entry"; Boolean)
        {
            Caption = 'Update Entry';
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
        key(Key1; "Document No.", "Student No.")
        {
            Clustered = true;
        }
        key(Key2; House, "Academic Year", "Update Results")
        {
            SumIndexFields = Points;
        }
        key(Key3; "Competition Entry No.", "Student Division", "Student No.")
        {
        }
        key(Key4; "Competition Entry No.", "Student Division", "Team No.")
        {
        }
        key(Key5; "Student No.", Points)
        {
        }
        key(Key6; "Team No.")
        {
            SumIndexFields = Points;
        }
        key(Key7; "Document No.", "Event Code", "Student Division", "Student No.")
        {
        }
        key(Key8; "Event Code", "Student Division", "Student No.")
        {
        }
        key(Key9; House, "Academic Year", "Event Code")
        {
            SumIndexFields = Points;
        }
        key(Key10; "Participant Type", "Team No.", "Competition Entry No.")
        {
            SumIndexFields = Points;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        // Start 01.VIGNESH
        IF "Student No." = '' THEN
          DELETE;
        "User ID" := USERID;
        EducationSetup.GET;
        EducationSetup.TESTFIELD("Academic Year");
        "Academic Year" := EducationSetup."Academic Year";
        IF ParticipantEntryHeader.GET("Document No.") THEN BEGIN
          ParticipantEntryHeader.TESTFIELD("No.");
          ParticipantEntryHeader.TESTFIELD("Competition Entry No.");
          ParticipantEntryHeader.TESTFIELD("Student Division");
          IF ParticipantEntryHeader."Event Type" <> ParticipantEntryHeader."Event Type"::Team THEN BEGIN
            ParticipantEntryHeader.TESTFIELD(House);
            ParticipantEntryLine.RESET;
            ParticipantEntryLine.SETRANGE("Document No.","Document No.");
            IF ParticipantEntryLine.FINDFIRST THEN
              ERROR(Text000);
          END;
          "Competition Type" := ParticipantEntryHeader."Competition Type";
          "Competition Name" := ParticipantEntryHeader."Competition Name";
          "Student Division" := ParticipantEntryHeader."Student Division";
          "Competition Entry No." := ParticipantEntryHeader."Competition Entry No.";
          "Event Type" := ParticipantEntryHeader."Event Type";
          "Team No." := ParticipantEntryHeader."Team No.";
        END;
        // Stop 01.VIGNESH
         */

    end;

    var
        EducationSetup: Record "Education Setup";
        ParticipantEntryHeader: Record "Participant Entry Header";
        Student: Record Student;
        ParticipantEntryLine: Record "Participant Entry Line";
        CompetitionEntryLine: Record "Competition Entry Line";
        LocalAge: Decimal;
        TempAge: Decimal;
        LocalAge1: Decimal;
        TempAge1: Decimal;
        Age2: Decimal;
        Months1: Decimal;
        Age3: Decimal;
        Months2: Decimal;
        CoCurricularPointsSetup: Record "Co-Curricular Points Setup";
        Text000: Label 'You can enter only one student for an individual.';
        Text001: Label 'You cannot modify the enttry, entry is updated.';
        Text002: Label 'Only for the Team Event, participant type is  required.';
        Text003: Label 'Only %1 students can be added in main list';
        Text004: Label 'Only %1 students can be added in substitute list.';
        CompType: Record "Competition Type";
}

