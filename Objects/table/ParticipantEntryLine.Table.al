table 71084 "Participant Entry Line"
{
    Caption = 'Participant Entry Line';
    DataClassification = ToBeClassified;
    LookupPageID = "Participant Entry Line List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            ToolTip = 'Reference to the participant entry header document.';
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = ToBeClassified;
            ToolTip = 'Student number for this entry.';

            trigger OnLookup()
            begin
                EducationSetup.Get();
                EducationSetup.TestField("Academic Year");
                Student.ClearMarks();
                if ParticipantEntryHeader.Get("Document No.") then;

                if CompType.Get(ParticipantEntryHeader."Competition Type") then
                    if CompType."Entire Class" = false then begin
                        CompetitionEntryLine.Reset();
                        CompetitionEntryLine.SetRange("Document No.", ParticipantEntryHeader."Competition Entry No.");
                        CompetitionEntryLine.SetRange("Student Division", ParticipantEntryHeader."Student Division");
                        if CompetitionEntryLine.FindFirst() then begin
                            CompetitionEntryLine.TestField("Min Age");
                            CompetitionEntryLine.TestField("Max Age");
                            CompetitionEntryLine.TestField("Cut Off Date");
                            Student.ClearMarks();
                            Student.Reset();
                            Student.SetRange("Student Status", Student."Student Status"::Student);


                            if ParticipantEntryHeader.Gender <> 3 then
                                Student.SetRange(Gender, ParticipantEntryHeader.Gender);

                            if ParticipantEntryHeader.House <> '' then
                                Student.SetRange(House, ParticipantEntryHeader.House);
                            Student.SetRange("Academic Year", EducationSetup."Academic Year");
                            if Student.FindSet() then
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
                                    if (LocalAge >= CompetitionEntryLine."Min Age") and (LocalAge <= CompetitionEntryLine."Max Age") then
                                        if (LocalAge = CompetitionEntryLine."Max Age") and (Months1 < 0) then
                                            Student.Mark(true)
                                        else
                                            if LocalAge < CompetitionEntryLine."Max Age" then
                                                Student.Mark(true);

                                until Student.Next() = 0;
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
                        Student.Reset();
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

            trigger OnValidate()
            begin
                if ParticipantEntryHeader.Get("Document No.") then begin
                    if ParticipantEntryHeader."Update Entry" then
                        Error(Text001);
                    ParticipantEntryHeader.TestField("Competition Entry No.");
                    ParticipantEntryHeader.TestField("Student Division");

                    CompetitionEntryLine.Reset();
                    CompetitionEntryLine.SetRange("Document No.", ParticipantEntryHeader."Competition Entry No.");
                    CompetitionEntryLine.SetRange("Student Division", ParticipantEntryHeader."Student Division");

                    if CompetitionEntryLine.FindFirst() then begin
                        CompetitionEntryLine.TestField("Min Age");
                        CompetitionEntryLine.TestField("Max Age");
                        CompetitionEntryLine.TestField("Cut Off Date");
                        Student.Reset();
                        if Student.Get("Student No.") then
                            if Student."Date Of Birth" <> 0D then begin
                                LocalAge1 := CompetitionEntryLine."Cut Off Date" - Student."Date Of Birth";
                                TempAge1 := Round(LocalAge1 / 365, 1, '<');
                                Age3 := LocalAge1 mod 365;
                                Months2 := Round(Age3 / 30, 1, '=');
                                Age := TempAge1;
                                Months := Months2;
                                Student.TestField(House);
                            end else begin
                                Age := 0;
                                Months := 0;
                            end;
                    end;
                end;
            end;

        }
        field(4; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            DataClassification = ToBeClassified;
            ToolTip = 'Name of the student.';
        }
        field(5; Age; Decimal)
        {
            Caption = 'Age';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            ToolTip = 'Age of the student at cutoff date.';
        }
        field(6; House; Code[20])
        {
            Caption = 'House';
            DataClassification = ToBeClassified;
            ToolTip = 'House of the student.';
            TableRelation = House;
        }
        field(7; "Participant Type"; Option)
        {
            Caption = 'Participant Type';
            DataClassification = ToBeClassified;
            ToolTip = 'Indicates main or substitute participant.';
            OptionCaption = ' ,Main,Substitute';
            OptionMembers = " ",Main,Substitute;

            trigger OnValidate()
            begin

                ParticipantEntryHeader.Get("Document No.");
                if ParticipantEntryHeader."Update Entry" then
                    Error(Text001);
                if ParticipantEntryHeader."Event Type" = ParticipantEntryHeader."Event Type"::Team then
                    if CompetitionEntryLine.Get(ParticipantEntryHeader."Competition Entry No.", ParticipantEntryHeader."Student Division") then begin
                        CompetitionEntryLine.TestField("Team Size");
                        ParticipantEntryLine.Reset();
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
            DataClassification = ToBeClassified;
            ToolTip = 'Type of competition.';
            Editable = true;
            TableRelation = "Competition Type";
        }
        field(9; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            DataClassification = ToBeClassified;
            ToolTip = 'Name of the competition.';
            Editable = true;
        }
        field(10; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            DataClassification = ToBeClassified;
            ToolTip = 'Student division of the participant.';
            Editable = true;
            TableRelation = "Student Division";
        }
        field(11; Position; Option)
        {
            Caption = 'Position';
            DataClassification = ToBeClassified;
            ToolTip = 'Final position in the competition.';
            OptionCaption = ',1st Place,2nd Place,3rd Place,4th place,5th place,6th place,Participation';
            OptionMembers = ,"1st Place","2nd Place","3rd Place","4th place","5th place","6th place",Participation;
        }
        field(12; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = ToBeClassified;
            ToolTip = 'Points awarded for this entry.';
            Editable = true;
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = ToBeClassified;
            ToolTip = 'Academic year of the competition.';
        }
        field(14; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            DataClassification = ToBeClassified;
            ToolTip = 'Reference to the competition entry.';
        }
        field(15; Months; Decimal)
        {
            Caption = 'Months';
            DataClassification = ToBeClassified;
            ToolTip = 'Additional months of age.';
            DecimalPlaces = 0 : 0;
        }
        field(17; "Event Type"; Option)
        {
            Caption = 'Event Type';
            DataClassification = ToBeClassified;
            ToolTip = 'Type of event (Individual or Team).';
            Editable = true;
            OptionCaption = ' ,Individual,Team';
            OptionMembers = " ",Individual,Team;
        }
        field(18; "Team No."; Code[20])
        {
            Caption = 'Team No.';
            DataClassification = ToBeClassified;
            ToolTip = 'Team number for the participant.';
        }
        field(19; "Update Results"; Boolean)
        {
            Caption = 'Update Results';
            DataClassification = ToBeClassified;
            ToolTip = 'Indicates whether results are updated.';
        }
        field(20; Class; Code[10])
        {
            Caption = 'Class';
            DataClassification = ToBeClassified;
            ToolTip = 'Class of the student.';
            TableRelation = Class;
        }
        field(21; "Event Code"; Code[20])
        {
            Caption = 'Event Code';
            DataClassification = ToBeClassified;
            ToolTip = 'Code of the event.';
            TableRelation = "Event Master";
        }
        field(50000; "Details NUM"; Decimal)
        {
            Caption = 'Details NUM';
            DataClassification = ToBeClassified;
        }
        field(50001; "Details TXT"; Text[140])
        {
            Caption = 'Details TXT';
            DataClassification = ToBeClassified;
        }
        field(50002; "Update Entry"; Boolean)
        {
            Caption = 'Update Entry';
            DataClassification = ToBeClassified;
            ToolTip = 'Indicates whether the entry can be updated.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = ToBeClassified;
            ToolTip = 'Portal reference ID for external systems.';
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
            ToolTip = 'Section of the student.';
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


    var
        EducationSetup: Record "Education Setup";
        ParticipantEntryHeader: Record "Participant Entry Header";
        Student: Record Student;
        ParticipantEntryLine: Record "Participant Entry Line";
        CompetitionEntryLine: Record "Competition Entry Line";
        CompType: Record "Competition Type";

        LocalAge: Decimal;
        TempAge: Decimal;
        LocalAge1: Decimal;
        TempAge1: Decimal;
        Age2: Decimal;
        Months1: Decimal;
        Age3: Decimal;
        Months2: Decimal;
        Text000: Label 'You can enter only one student for an individual.';
        Text001: Label 'You cannot modify the enttry, entry is updated.';
        Text002: Label 'Only for the Team Event, participant type is  required.';
        Text003: Label 'Only %1 students can be added in main list';
        Text004: Label 'Only %1 students can be added in substitute list.';


}