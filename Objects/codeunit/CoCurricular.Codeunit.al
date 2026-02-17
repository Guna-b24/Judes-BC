codeunit 71045 "Co-Curricular"
{
    var
        Text000: Label 'Already This Entry has updated';
        Text001: Label 'Please select the Student(s)';
        Text002: Label 'Total Student required in Participant Type Main is %1';
        Text003: Label 'Total Student required in Participant Type Substitute is %1';
        Text004: Label 'Update Completed';
        Text005: Label 'Already Points has updated';
        Text006: Label 'You cannot Update the Updated already generated';
        Text007: Label 'Lines are not updated';
        Text008: Label 'Update Points Completed';
        Text009: Label 'Do you want to Update this Entry ?';
        Text010: Label 'Do you want to get the Students ?';
        Text011: Label 'Do you want to update the Students ?';
        Text012: Label 'Do you want to update Points to the Students ? ';
        Text013: Label 'Do you want to update Points to the Students ?';
        Student: Record Student;
        "Class Section": Record "Class Section";
        Text014: Label 'Student %1 already Participate %2 Events';


    procedure UpdateEntry("GetDocNo.": Code[20])
    var
        ParticipantEntryHeader: Record "Participant Entry Header";
        ParticipantEntryLine: Record "Participant Entry Line";
        ParticipantEntryMulti: Record "Participant Entry Line";
        EducationSetup: Record "Education Setup";
        EventParticipantEntry: Record "Participant Entry Line";
        Text0045: Label 'Student %1 already Participate in %2  event';
        Iscount: Integer;
        iSCOUNT1: Integer;
    begin
        ParticipantEntryHeader.Get("GetDocNo.");
        if ParticipantEntryHeader."Update Entry" then
            Error(Text000);

        EducationSetup.Get();

        ParticipantEntryLine.Reset();
        ParticipantEntryLine.SetRange("Document No.", "GetDocNo.");
        if ParticipantEntryLine.IsEmpty then
            Error(Text001);


        ParticipantEntryLine.Reset();
        ParticipantEntryLine.SetRange("Document No.", "GetDocNo.");
        ParticipantEntryLine.SetRange("Participant Type", ParticipantEntryLine."Participant Type"::Main);
        if ParticipantEntryLine.FindFirst() then
            Iscount := ParticipantEntryLine.Count;
        if Iscount <> ParticipantEntryHeader."Team Size" then
            Error(Text002, ParticipantEntryHeader."Team Size");


        EventParticipantEntry.Reset();
        EventParticipantEntry.SetRange("Academic Year", EducationSetup."Academic Year");
        EventParticipantEntry.SetRange("Update Entry", true);
        EventParticipantEntry.SetRange("Competition Name", ParticipantEntryLine."Competition Name");
        EventParticipantEntry.SetRange("Student No.", ParticipantEntryLine."Student No.");
        if EventParticipantEntry.FindSet() then
            if EventParticipantEntry.Count >= 1 then
                Error(Text0045, EventParticipantEntry."Student Name", ParticipantEntryHeader."Competition Name");

        ParticipantEntryLine.Reset();
        ParticipantEntryLine.SetRange("Document No.", "GetDocNo.");
        if ParticipantEntryLine.FindFirst() then
            repeat
                if (ParticipantEntryLine."Event Type" = ParticipantEntryLine."Event Type"::Individual) then begin
                    Clear(iSCOUNT1);
                    ParticipantEntryMulti.Reset();
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Academic Year", EducationSetup."Academic Year");
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student Division", 'SUB JUNIORS');
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Update Entry", true);
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Event Type", ParticipantEntryMulti."Event Type"::Individual);
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student No.", ParticipantEntryLine."Student No.");
                    if ParticipantEntryMulti.FindFirst() then
                        iSCOUNT1 := ParticipantEntryMulti.Count;
                    if iSCOUNT1 >= (24 + 3) then
                        Error(Text014, ParticipantEntryMulti."Student Name", iSCOUNT1);
                end
                else
                    if (ParticipantEntryLine."Event Type" = ParticipantEntryLine."Event Type"::Team) then begin
                        Clear(iSCOUNT1);
                        ParticipantEntryMulti.Reset();
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Academic Year", EducationSetup."Academic Year");
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student Division", 'SUB JUNIORS');
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Update Entry", true);
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Event Type", ParticipantEntryMulti."Event Type"::Team);
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student No.", ParticipantEntryLine."Student No.");
                        if ParticipantEntryMulti.FindFirst() then
                            iSCOUNT1 := ParticipantEntryMulti.Count;
                        if iSCOUNT1 >= (21 + 3) then
                            Error(Text014, ParticipantEntryMulti."Student Name", iSCOUNT1);
                    end;
            until ParticipantEntryLine.Next() = 0;

        ParticipantEntryLine.Reset();
        ParticipantEntryLine.SetRange("Document No.", "GetDocNo.");
        if ParticipantEntryLine.FindFirst() then
            repeat
                if (ParticipantEntryLine."Event Type" = ParticipantEntryLine."Event Type"::Individual) then begin
                    Clear(iSCOUNT1);
                    ParticipantEntryMulti.Reset();
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Academic Year", EducationSetup."Academic Year");
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student Division", 'JUNIORS');
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Update Entry", true);
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Event Type", ParticipantEntryMulti."Event Type"::Individual);
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student No.", ParticipantEntryLine."Student No.");
                    if ParticipantEntryMulti.FindFirst() then
                        iSCOUNT1 := ParticipantEntryMulti.Count;
                    if iSCOUNT1 >= (24 + 3) then
                        Error(Text014, ParticipantEntryMulti."Student Name", iSCOUNT1);
                end
                else
                    if (ParticipantEntryLine."Event Type" = ParticipantEntryLine."Event Type"::Team) then begin
                        Clear(iSCOUNT1);
                        ParticipantEntryMulti.Reset();
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Academic Year", EducationSetup."Academic Year");
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student Division", 'JUNIORS');
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Update Entry", true);
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Event Type", ParticipantEntryMulti."Event Type"::Team);
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student No.", ParticipantEntryLine."Student No.");
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti.Gender, ParticipantEntryMulti.Gender::Male);
                        if ParticipantEntryMulti.FindFirst() then begin
                            iSCOUNT1 := ParticipantEntryMulti.Count;
                            if iSCOUNT1 >= (22 + 3) then
                                Error(Text014, ParticipantEntryMulti."Student Name", iSCOUNT1);
                        end;
                        Clear(iSCOUNT1);
                        ParticipantEntryMulti.Reset();
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Academic Year", EducationSetup."Academic Year");
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student Division", 'JUNIORS');
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Update Entry", true);
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Event Type", ParticipantEntryMulti."Event Type"::Team);
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student No.", ParticipantEntryLine."Student No.");
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti.Gender, ParticipantEntryMulti.Gender::Female);
                        if ParticipantEntryMulti.FindFirst() then
                            iSCOUNT1 := ParticipantEntryMulti.Count;
                        if iSCOUNT1 >= (21 + 3) then
                            Error(Text014, ParticipantEntryMulti."Student Name", iSCOUNT1);

                    end;
            until ParticipantEntryLine.Next() = 0;

        ParticipantEntryLine.Reset();
        ParticipantEntryLine.SetRange("Document No.", "GetDocNo.");
        if ParticipantEntryLine.FindFirst() then
            repeat
                if (ParticipantEntryLine."Event Type" = ParticipantEntryLine."Event Type"::Individual) then begin
                    Clear(iSCOUNT1);
                    ParticipantEntryMulti.Reset();
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Academic Year", EducationSetup."Academic Year");
                    ParticipantEntryMulti.SetFilter(ParticipantEntryMulti."Student Division", '%1 |%2 | %3', 'INTERS', 'SENIORS', 'SUPER SENIORS');
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Update Entry", true);
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Event Type", ParticipantEntryMulti."Event Type"::Individual);
                    ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student No.", ParticipantEntryLine."Student No.");
                    if ParticipantEntryMulti.FindFirst() then
                        iSCOUNT1 := ParticipantEntryMulti.Count;
                    if iSCOUNT1 >= (25 + 3) then
                        Error(Text014, ParticipantEntryMulti."Student Name", iSCOUNT1);
                end
                else
                    if (ParticipantEntryLine."Event Type" = ParticipantEntryLine."Event Type"::Team) then begin
                        Clear(iSCOUNT1);
                        ParticipantEntryMulti.Reset();
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Academic Year", EducationSetup."Academic Year");
                        ParticipantEntryMulti.SetFilter(ParticipantEntryMulti."Student Division", '%1 |%2 | %3', 'INTERS', 'SENIORS', 'SUPER SENIORS');
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Update Entry", true);
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Event Type", ParticipantEntryMulti."Event Type"::Team);
                        ParticipantEntryMulti.SetRange(ParticipantEntryMulti."Student No.", ParticipantEntryLine."Student No.");
                        if ParticipantEntryMulti.FindFirst() then
                            iSCOUNT1 := ParticipantEntryMulti.Count;
                        if iSCOUNT1 >= (22 + 3) then
                            Error(Text014, ParticipantEntryMulti."Student Name", iSCOUNT1);
                    end;
            until ParticipantEntryLine.Next() = 0;




        ParticipantEntryHeader."Update Entry" := true;
        ParticipantEntryHeader.Modify();
        Message(Text004);

        ParticipantEntryLine.Reset();
        ParticipantEntryLine.SetRange("Document No.", ParticipantEntryHeader."No.");
        if ParticipantEntryLine.FindFirst() then
            repeat
                ParticipantEntryLine."Update Entry" := true;
                ParticipantEntryLine.Modify();
            until ParticipantEntryLine.Next() = 0;

    end;


    procedure GetStudentsIndividual("GetDocNo.": Code[20])
    var
        CompetitionResultIndividual: Record "Competition Result Individual";
        ParticipantEntryLine: Record "Participant Entry Line";
        CompetitionResIndvuLine: Record "Competition Res Indvu Line";
        ParticipantEntryHeader: Record "Participant Entry Header";
    begin

        CompetitionResultIndividual.Get("GetDocNo.");

        if CompetitionResultIndividual."Update Results" then
            Error(Text005);

        CompetitionResultIndividual.TestField("Competition Entry No.");
        CompetitionResultIndividual.TestField("Student Division");

        CompetitionResIndvuLine.Reset();
        CompetitionResIndvuLine.SetRange("Document No.", "GetDocNo.");
        if CompetitionResIndvuLine.FindFirst() then
            CompetitionResIndvuLine.DeleteAll();

        ParticipantEntryHeader.Reset();
        ParticipantEntryHeader.SetCurrentKey("Competition Entry No.", "Student Division");
        ParticipantEntryHeader.SetRange("Competition Entry No.", CompetitionResultIndividual."Competition Entry No.");
        ParticipantEntryHeader.SetRange("Student Division", CompetitionResultIndividual."Student Division");

        ParticipantEntryHeader.SetRange("Update Results", false);
        if ParticipantEntryHeader.FindSet() then
            repeat
                ParticipantEntryLine.Reset();
                ParticipantEntryLine.SetRange("Document No.", ParticipantEntryHeader."No.");

                if ParticipantEntryLine.FindSet() then
                    repeat
                        CompetitionResIndvuLine.Init();
                        CompetitionResIndvuLine.TransferFields(ParticipantEntryLine);
                        CompetitionResIndvuLine."Document No." := CompetitionResultIndividual."No.";
                        CompetitionResIndvuLine."Competition Type" := CompetitionResultIndividual."Competition Type";
                        CompetitionResIndvuLine."Competition Name" := CompetitionResultIndividual."Competition Name";
                        CompetitionResIndvuLine.Class := ParticipantEntryLine.Class;
                        CompetitionResIndvuLine.Section := ParticipantEntryLine.Section;

                        CompetitionResIndvuLine.Insert();
                    until ParticipantEntryLine.Next() = 0;
            until ParticipantEntryHeader.Next() = 0;

    end;


    procedure GetStudentsTeam("GetDocNo.": Code[20])
    var
        CompetitionResultTeam: Record "Competition Result Team";
        CompetitionResTeamLine: Record "Competition Res Team Line";
        ParticipantEntryHeader: Record "Participant Entry Header";
    begin

        CompetitionResultTeam.Get("GetDocNo.");
        if CompetitionResultTeam."Update Results" then
            Error(Text005);
        CompetitionResultTeam.TestField("Competition Entry No.");
        CompetitionResultTeam.TestField("Student Division");

        CompetitionResTeamLine.Reset();
        CompetitionResTeamLine.SetRange("Document No.", "GetDocNo.");
        if CompetitionResTeamLine.FindFirst() then
            CompetitionResTeamLine.DeleteAll();

        ParticipantEntryHeader.Reset();
        ParticipantEntryHeader.SetCurrentKey("Competition Entry No.", "Student Division");
        ParticipantEntryHeader.SetRange("Competition Entry No.", CompetitionResultTeam."Competition Entry No.");
        ParticipantEntryHeader.SetRange("Student Division", CompetitionResultTeam."Student Division");
        ParticipantEntryHeader.SetRange("Event Type", ParticipantEntryHeader."Event Type"::Team);

        ParticipantEntryHeader.SetRange("Update Results", false);
        if ParticipantEntryHeader.FindFirst() then
            repeat
                CompetitionResTeamLine.Init();
                CompetitionResTeamLine."Document No." := CompetitionResultTeam."No.";
                CompetitionResTeamLine."Team No." := ParticipantEntryHeader."Team No.";
                CompetitionResTeamLine.House := ParticipantEntryHeader.House;
                CompetitionResTeamLine."Competition Type" := ParticipantEntryHeader."Competition Type";
                CompetitionResTeamLine."Competition Name" := ParticipantEntryHeader."Competition Name";
                CompetitionResTeamLine."Student Division" := ParticipantEntryHeader."Student Division";
                CompetitionResTeamLine."Academic Year" := CompetitionResultTeam."Academic Year";
                CompetitionResTeamLine."Competition Entry No." := CompetitionResultTeam."Competition Entry No.";
                CompetitionResTeamLine.Insert();
            until ParticipantEntryHeader.Next() = 0;

    end;


    procedure UpdatePointsIndividual("getDocNo.": Code[20]; IsForceUpdate: Boolean)
    var
        ParticipantEntryLine: Record "Participant Entry Line";
        CompetitionResIndvuLine: Record "Competition Res Indvu Line";
        CompetitionResultIndividual: Record "Competition Result Individual";
        ParticipantEntryHeader: Record "Participant Entry Header";
        CompetitionEntryHeader: Record "Competition Entry Header";
        CompetitionResIndvuLine1: Record "Competition Res Indvu Line";
        CoCurricularPointsSetup: Record "Co-Curricular Points Setup";
    begin

        CompetitionResIndvuLine1.Reset();
        CompetitionResIndvuLine1.SetRange("Document No.", "getDocNo.");
        CompetitionResIndvuLine1.SetRange(Position, CompetitionResIndvuLine1.Position::"1st Place");
        if CompetitionResIndvuLine1.FindSet() then
            repeat
                if CoCurricularPointsSetup.Get(CompetitionResIndvuLine1."Competition Type") then;
                if CompetitionResIndvuLine1.Count > 1 then
                    CompetitionResIndvuLine1.Points := (CoCurricularPointsSetup."1st Place" + CoCurricularPointsSetup."2nd Place") / 2;
                CompetitionResIndvuLine1.Modify();
            until CompetitionResIndvuLine1.Next() = 0;


        CompetitionResultIndividual.Get("getDocNo.");
        if CompetitionResultIndividual."Update Results" and not IsForceUpdate then
            Error(Text006);

        CompetitionResIndvuLine.Reset();
        CompetitionResIndvuLine.SetRange("Document No.", "getDocNo.");
        if CompetitionResIndvuLine.IsEmpty then
            Error(Text007)
        else
            if CompetitionResIndvuLine.FindSet() then
                repeat
                    ParticipantEntryLine.Reset();
                    ParticipantEntryLine.SetCurrentKey("Competition Entry No.", "Student Division", "Student No.");
                    ParticipantEntryLine.SetRange("Competition Entry No.", CompetitionResIndvuLine."Competition Entry No.");
                    ParticipantEntryLine.SetRange("Student Division", CompetitionResIndvuLine."Student Division");
                    ParticipantEntryLine.SetRange("Student No.", CompetitionResIndvuLine."Student No.");
                    if ParticipantEntryLine.FindFirst() then begin
                        ParticipantEntryLine.Position := CompetitionResIndvuLine.Position;

                        if CompetitionResIndvuLine.Position = CompetitionResIndvuLine.Position::"1st Place" then
                            ParticipantEntryLine.Points := CompetitionResIndvuLine1.Points
                        else
                            ParticipantEntryLine.Points := CompetitionResIndvuLine.Points;


                        ParticipantEntryLine."Details NUM" := CompetitionResIndvuLine."Details NUM";
                        ParticipantEntryLine."Details TXT" := CompetitionResIndvuLine."Details TXT";
                        ParticipantEntryLine."Update Results" := true;
                        ParticipantEntryLine.Modify();
                    end;
                until CompetitionResIndvuLine.Next() = 0;

        ParticipantEntryHeader.Reset();
        ParticipantEntryHeader.SetCurrentKey("Competition Entry No.", "Student Division");
        ParticipantEntryHeader.SetRange("Competition Entry No.", CompetitionResultIndividual."Competition Entry No.");
        ParticipantEntryHeader.SetRange("Student Division", CompetitionResultIndividual."Student Division");
        ParticipantEntryHeader.ModifyAll("Update Results", true);
        ParticipantEntryHeader.ModifyAll("Update Entry", true);
        ParticipantEntryHeader.ModifyAll("Competition Status", ParticipantEntryHeader."Competition Status"::Completed);

        CompetitionResultIndividual."Update Results" := true;
        CompetitionResultIndividual."Competition Status" := CompetitionResultIndividual."Competition Status"::Completed;

        CompetitionEntryHeader.Get(CompetitionResultIndividual."Competition Entry No.");

        CompetitionEntryHeader.Modify();
        if CompetitionResultIndividual.Modify() then
            Message(Text008);

        Commit();
    end;


    procedure UpdatePointTeam("getDocNo.": Code[20])
    var
        ParticipantEntryLine: Record "Participant Entry Line";
        CompetitionResultTeam: Record "Competition Result Team";
        CompetitionResTeamLine: Record "Competition Res Team Line";
        ParticipantEntryHeader: Record "Participant Entry Header";
    begin


        CompetitionResultTeam.Get("getDocNo.");
        if CompetitionResultTeam."Update Results" then
            Error(Text006);

        CompetitionResTeamLine.Reset();
        CompetitionResTeamLine.SetRange("Document No.", "getDocNo.");
        if CompetitionResTeamLine.IsEmpty then
            Error(Text007)
        else
            if CompetitionResTeamLine.FindFirst() then
                repeat
                    ParticipantEntryLine.Reset();
                    ParticipantEntryLine.SetCurrentKey("Competition Entry No.", "Student Division", "Team No.");
                    ParticipantEntryLine.SetRange("Competition Entry No.", CompetitionResTeamLine."Competition Entry No.");
                    ParticipantEntryLine.SetRange("Student Division", CompetitionResTeamLine."Student Division");
                    ParticipantEntryLine.SetRange("Team No.", CompetitionResTeamLine."Team No.");
                    ParticipantEntryLine.SetRange(ParticipantEntryLine."Participant Type"); //DS01 Added on 260712
                    if ParticipantEntryLine.FindFirst() then begin
                        ParticipantEntryLine.ModifyAll(Position, CompetitionResTeamLine.Position);
                        ParticipantEntryLine.ModifyAll(Points, CompetitionResTeamLine.Points);
                        ParticipantEntryLine."Details NUM" := CompetitionResTeamLine."Details NUM";
                        ParticipantEntryLine."Details TXT" := CompetitionResTeamLine."Details TXT";

                        ParticipantEntryLine.ModifyAll("Update Results", true);
                    end;
                until CompetitionResTeamLine.Next() = 0;

        ParticipantEntryHeader.Reset();
        ParticipantEntryHeader.SetCurrentKey("Competition Entry No.", "Student Division");
        ParticipantEntryHeader.SetRange("Competition Entry No.", CompetitionResTeamLine."Competition Entry No.");
        ParticipantEntryHeader.SetRange("Student Division", CompetitionResTeamLine."Student Division");
        ParticipantEntryHeader.ModifyAll("Update Results", true);
        ParticipantEntryHeader.ModifyAll("Update Entry", true);
        CompetitionResultTeam."Update Results" := true;
        if CompetitionResultTeam.Modify() then
            Message(Text008);

    end;


    procedure GetStudents("GetDocNo.": Code[20])
    var
        ParticipantEntryHeader: Record "Participant Entry Header";
        ParticipantEntryLine: Record "Participant Entry Line";
        CompetitionEntryLine: Record "Competition Entry Line";
        LocalAge1: Integer;
        TempAge1: Integer;
        Age3: Integer;
        Months2: Integer;
        Age: Integer;
        Months: Integer;
    begin
        if ParticipantEntryHeader.Get("GetDocNo.") then begin
            Student.Reset();
            Student.SetRange(Student.House, ParticipantEntryHeader.House);
            Student.SetRange(Student.Gender, ParticipantEntryHeader.Gender);
            Student.SetRange(Student."Academic Year", ParticipantEntryHeader."Academic Year");
            Student.SetRange(Student."Student Status", Student."Student Status"::Student);


            if Student.FindSet() then
                repeat
                    CompetitionEntryLine.SetRange(CompetitionEntryLine."Document No.", ParticipantEntryHeader."Competition Entry No.");
                    if CompetitionEntryLine.FindFirst() then begin

                        CompetitionEntryLine.TestField("Cut Off Date");
                        CompetitionEntryLine."Temp Cut off Date" := Today;
                        if Student."Date Of Birth" <> 0D then begin
                            LocalAge1 := CompetitionEntryLine."Temp Cut off Date" - Student."Date Of Birth";
                            TempAge1 := Round(LocalAge1 / 365, 1, '<');
                            Age3 := LocalAge1 mod 365;
                            Months2 := Round(Age3 / 30, 1, '=');
                            Age := TempAge1;
                            Months := Months2;
                            Student.TestField(House);

                        end;
                    end;

                    if CompetitionEntryLine."Cut Off Date" <= Student."Date Of Birth" then begin
                        //IF (Age >= CompetitionEntryLine."Min Age") OR (Age <= CompetitionEntryLine."Max Age") THEN BEGIN
                        ParticipantEntryLine.Init();
                        ParticipantEntryLine."Document No." := ParticipantEntryHeader."No.";
                        ParticipantEntryLine."Student No." := Student."No.";
                        ParticipantEntryLine.Class := Student.Class;
                        ParticipantEntryLine."Student Name" := Student.Name;
                        ParticipantEntryLine.House := Student.House;
                        ParticipantEntryLine.Gender := Student.Gender;
                        ParticipantEntryLine."Competition Entry No." := ParticipantEntryHeader."Competition Entry No.";
                        ParticipantEntryLine."Competition Type" := ParticipantEntryHeader."Competition Type";
                        ParticipantEntryLine."Competition Name" := ParticipantEntryHeader."Competition Name";
                        ParticipantEntryLine."Student Division" := ParticipantEntryHeader."Student Division";
                        ParticipantEntryLine."Event Code" := ParticipantEntryHeader."Event Code";
                        ParticipantEntryLine."Event Type" := ParticipantEntryHeader."Event Type";
                        ParticipantEntryLine."Academic Year" := ParticipantEntryHeader."Academic Year";

                        ParticipantEntryLine.Age := Age;
                        ParticipantEntryLine.Months := Months;


                        if "Class Section".Get(Student."Class Code") then
                            if "Class Section"."Academic Year" = ParticipantEntryHeader."Academic Year" then
                                ParticipantEntryLine.Insert(true);
                    end;
                until Student.Next() = 0;
        end;
    end;


    procedure CheckPositions("getDocNo.": Code[20]) Ret: Text[30]
    var
        CompetitionResIndvuLine: Record "Competition Res Indvu Line";
        CompetitionRes: Record "Competition Res Indvu Line";
    begin

        CompetitionResIndvuLine.Reset();
        CompetitionResIndvuLine.SetRange(CompetitionResIndvuLine."Document No.", "getDocNo.");
        CompetitionResIndvuLine.SetFilter(CompetitionResIndvuLine.Position, '<>%1 & <>%2', 0, CompetitionResIndvuLine.Position::Participation
        );
        if CompetitionResIndvuLine.FindSet() then
            repeat
                CompetitionRes.Reset();
                CompetitionRes.SetRange(CompetitionRes."Document No.", "getDocNo.");
                CompetitionRes.SetFilter(CompetitionRes.Position, '<>%1 & <>%2', 0,
                                         CompetitionRes.Position::Participation);
                CompetitionRes.SetRange(CompetitionRes.Position, CompetitionResIndvuLine.Position);
                if CompetitionRes.FindFirst() then begin
                    if CompetitionRes.Count > 1 then begin
                        CompetitionRes.SetFilter(CompetitionRes.Position, '%1..%2',
                                                 CompetitionRes.Position + 1, CompetitionRes.Position + CompetitionRes.Count - 1);
                        if CompetitionRes.FindFirst() then
                            Error(Format(CompetitionRes.Position));
                    end;
                    ;
                end;
            until CompetitionResIndvuLine.Next() = 0;
    end;


    procedure "----Cetas1-----"()
    begin
    end;


    procedure UpdatePointTeam1("getDocNo.": Code[20]; IsForceUpdate: Boolean)
    var
        ParticipantEntryLine: Record "Participant Entry Line";
        CompetitionResultTeam: Record "Competition Result Team";
        CompetitionResTeamLine: Record "Competition Res Team Line";
        ParticipantEntryHeader: Record "Participant Entry Header";
    begin

        CompetitionResultTeam.Get("getDocNo.");
        if CompetitionResultTeam."Update Results" and not IsForceUpdate then
            Error(Text006);

        CompetitionResTeamLine.Reset();
        CompetitionResTeamLine.SetRange("Document No.", "getDocNo.");
        if CompetitionResTeamLine.IsEmpty then
            Error(Text007)
        else
            if CompetitionResTeamLine.FindFirst() then
                repeat
                    ParticipantEntryLine.Reset();
                    ParticipantEntryLine.SetCurrentKey("Competition Entry No.", "Student Division", "Team No.");
                    ParticipantEntryLine.SetRange("Competition Entry No.", CompetitionResTeamLine."Competition Entry No.");
                    ParticipantEntryLine.SetRange("Student Division", CompetitionResTeamLine."Student Division");
                    ParticipantEntryLine.SetRange("Team No.", CompetitionResTeamLine."Team No.");
                    ParticipantEntryLine.SetRange(ParticipantEntryLine."Participant Type",
                    ParticipantEntryLine."Participant Type"::Main);
                    if ParticipantEntryLine.FindFirst() then begin
                        ParticipantEntryLine.ModifyAll(Position, CompetitionResTeamLine.Position);
                        ParticipantEntryLine.ModifyAll(Points, CompetitionResTeamLine.Points);
                        ParticipantEntryLine."Details NUM" := CompetitionResTeamLine."Details NUM";
                        ParticipantEntryLine."Details TXT" := CompetitionResTeamLine."Details TXT";

                        ParticipantEntryLine.ModifyAll("Update Results", true);
                    end;
                until CompetitionResTeamLine.Next() = 0;

        ParticipantEntryHeader.Reset();
        ParticipantEntryHeader.SetCurrentKey("Competition Entry No.", "Student Division");
        ParticipantEntryHeader.SetRange("Competition Entry No.", CompetitionResTeamLine."Competition Entry No.");
        ParticipantEntryHeader.SetRange("Student Division", CompetitionResTeamLine."Student Division");
        ParticipantEntryHeader.ModifyAll("Update Results", true);
        ParticipantEntryHeader.ModifyAll("Update Entry", true);
        CompetitionResultTeam."Update Results" := true;
        if CompetitionResultTeam.Modify() then
            Message(Text008);

        Commit();

    end;
}

