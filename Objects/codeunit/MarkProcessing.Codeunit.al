codeunit 71041 "Mark Processing"
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  01/10/09   KATHIR   Get Students()              Code added to Get students for Mark Processing
    //   02  14/10/09   KATHIR   Marks Entry Completed()     Function added to Compelete the mark entry process
    //   03  09/12/09   VIGNESH  Get Students()              Code added to get the studant name
    //   04  07/07/10   Ankesh   Marks Entry Completed()     Code added to update Exam schedule line with the mark no.


    trigger OnRun()
    begin
    end;

    var
        ExamSchedLine: Record "Exam Schedule Line - SCH";
        StudMarksHeader: Record "Student Mark Header";

    [Scope('Internal')]
    procedure "Get Students"(MarkNo: Code[20])
    var
        MarksHeader: Record "Marks Header";
        StudentSubjects: Record "Student Subjects";
        MarksLine: Record "Marks Line";
        Student: Record Student;
        ExamCode: Record "Exam Code";
    begin
        // Start 01.KATHIR
        MarksHeader.Get(MarkNo);
        MarksHeader.TestField("Class Code");
        MarksHeader.TestField(Class);
        MarksHeader.TestField(Section);
        MarksHeader.TestField("Academic Year");
        MarksHeader.TestField(Curriculum);
        MarksHeader.TestField(Subject);
        MarksHeader.TestField("Max Mark");
        MarksHeader.TestField("Pass Mark");
        MarksHeader.TestField("Exam Type");
        ExamCode.Get(MarksHeader."Exam Type");
        StudentSubjects.Reset;
        StudentSubjects.SetRange(Subject, MarksHeader.Subject);
        StudentSubjects.SetRange("Class Code", MarksHeader."Class Code");
        if StudentSubjects.FindSet then
            repeat
                Student.Get(StudentSubjects."Student No.");
                if Student."Student Status" = Student."Student Status"::Student then begin
                    MarksLine."Document No." := MarkNo;
                    MarksLine.Validate("Document No.");
                    MarksLine."Student No." := StudentSubjects."Student No.";
                    // Start 03.VIGNESH
                    MarksLine."Student Name" := Student.Name;
                    // Stop 03.VIGNESH
                    MarksLine.Gender := Student.Gender;
                    MarksLine."Max Mark" := MarksHeader."Max Mark";
                    MarksLine.Class := MarksHeader.Class;
                    MarksLine.Section := MarksHeader.Section;
                    MarksLine."Academic Year" := MarksHeader."Academic Year";
                    MarksLine.Curriculum := MarksHeader.Curriculum;
                    MarksLine."Exam Type" := MarksHeader."Exam Type";
                    MarksLine."Pass Mark" := MarksHeader."Pass Mark";
                    MarksLine.ExamCount := ExamCode."Exam Order";
                    MarksLine.Subject := MarksHeader.Subject;
                    MarksLine."User ID" := MarksHeader."User ID";
                    MarksLine."Class Code" := MarksHeader."Class Code";
                    MarksLine.Insert;
                end;
            until StudentSubjects.Next = 0;
        // Stop 01.KATHIR
    end;

    [Scope('Internal')]
    procedure "Marks Entry Completed"(MarkNo: Code[20])
    var
        MarksHeader: Record "Marks Header";
    begin
        // Start 02.KATHIR
        MarksHeader.Get(MarkNo);
        MarksHeader."Entry Completed" := true;
        MarksHeader.Modify;
        // Stop 02.KATHIR
        // Start 04.Ankesh
        ExamSchedLine.Reset;
        //ExamSchedLine.SETRANGE("Academic Year",MarksHeader."Academic Year");
        //ExamSchedLine.SETRANGE("Exam Code",MarksHeader."Exam Type");
        //ExamSchedLine.SETRANGE("Subject Code",MarksHeader.Subject);
        ExamSchedLine.SetRange(ExamSchedLine."Class Code", MarksHeader."Class Code");
        ExamSchedLine.SetRange(ExamSchedLine."Exam Code", MarksHeader."Exam Type");
        ExamSchedLine.SetRange(ExamSchedLine."Subject Code", MarksHeader.Subject);
        if ExamSchedLine.FindFirst then begin
            ExamSchedLine."Mark Header Code" := MarkNo;
            ExamSchedLine.Modify;
        end;
        // Stop 04.Ankesh
    end;

    [Scope('Internal')]
    procedure GenerateRank(ClassCode: Code[20]; ExamCode: Code[20]) Ret: Boolean
    var
        Student: Record Student;
    begin
        Ret := false;
        if ValidateMarkEntry(ClassCode, ExamCode) then begin
            Student.SetRange(Student."Class Code", ClassCode);
            Student.SetRange(Student."Student Status", Student."Student Status"::Student);
            if Student.FindSet then begin
                repeat
                    CreateStudentMark(Student."No.", ExamCode, ClassCode);
                    UpdateRank(ClassCode, ExamCode);
                until Student.Next = 0;
                Ret := true;
            end;
        end else
            exit(Ret);
    end;

    [Scope('Internal')]
    procedure ValidateMarkEntry(ClassCode: Code[20]; ExamCode: Code[20]) Ret: Boolean
    var
        ClassSecSubjects: Record "Class Section Subjects";
        MarkHeader: Record "Marks Header";
    begin
        ClassSecSubjects.SetRange(ClassSecSubjects."Class Code", ClassCode);
        if ClassSecSubjects.FindSet then
            repeat
                MarkHeader.Reset;
                MarkHeader.SetRange(MarkHeader."Class Code", ClassCode);
                MarkHeader.SetRange(MarkHeader."Exam Type", ExamCode);
                MarkHeader.SetRange(MarkHeader.Subject, ClassSecSubjects.Subject);
                if MarkHeader.FindFirst then begin
                    if not MarkHeader."Entry Completed" then
                        exit(false);
                end
                else
                    exit(false);
            until ClassSecSubjects.Next = 0;
        exit(true);
    end;

    [Scope('Internal')]
    procedure CreateStudentMark(StudentNo: Code[20]; ExamCode: Code[20]; ClassCode: Code[20])
    var
        MarksLine: Record "Marks Line";
        StudMarkHead: Record "Student Mark Header";
        Student: Record Student;
        Total: Decimal;
        FailCnt: Integer;
        SubjCnt: Integer;
        AbsSubjCnt: Integer;
        TotalMarkconducted: Decimal;
    begin
        Clear(Total);
        Clear(FailCnt);
        Clear(SubjCnt);
        Clear(AbsSubjCnt);
        Student.Get(StudentNo);

        MarksLine.Reset;
        MarksLine.SetRange(MarksLine."Student No.", StudentNo);
        MarksLine.SetRange(MarksLine."Exam Type", ExamCode);
        MarksLine.SetRange(MarksLine."Class Code", ClassCode);
        if MarksLine.FindSet then
            repeat
                Total += MarksLine."Marks Obtained";
                TotalMarkconducted += MarksLine."Max Mark";   //DK-16.07.13
                if MarksLine.Result = MarksLine.Result::Fail then
                    FailCnt += 1;
                if MarksLine.Result = MarksLine.Result::Absent then begin
                    AbsSubjCnt += 1;
                    FailCnt += 1;
                end;
                SubjCnt += 1;
            until MarksLine.Next = 0;

        StudMarkHead.Reset;
        StudMarkHead.SetRange(StudMarkHead."Student No.", StudentNo);
        StudMarkHead.SetRange(StudMarkHead."Class Code", Student."Class Code");
        StudMarkHead.SetRange(StudMarkHead."Exam Type", ExamCode);
        if StudMarkHead.FindFirst then begin
            StudMarkHead."Total Marks" := Total;
            StudMarkHead."Total No of Subject Failed" := FailCnt;
            if FailCnt > 0 then begin
                StudMarkHead.Failed := true;
                StudMarkHead.Rank := 0;
            end
            else
                StudMarkHead.Failed := false;
            StudMarkHead."Total No of Subject Absent" := AbsSubjCnt;
            if StudMarkHead."Total Marks" > 0 then
                StudMarkHead.Average := StudMarkHead."Total Marks" / (SubjCnt - AbsSubjCnt);

            StudMarkHead.Modify;
        end
        else begin
            StudMarkHead."Student No." := StudentNo;
            StudMarkHead."Exam Type" := ExamCode;
            StudMarkHead.Name := Student.Name;
            StudMarkHead."Class Code" := Student."Class Code";
            StudMarkHead.Class := Student.Class;
            StudMarkHead.Section := Student.Section;
            StudMarkHead.Curriculum := Student.Curriculum;
            StudMarkHead."Academic Year" := Student."Academic Year";
            StudMarkHead.Height := Student.Height;
            StudMarkHead.Weight := Student.Weight;
            StudMarkHead."Total Marks Conducted" := SubjCnt;//DK 15-07-13

            StudMarkHead."Total Marks" := Total;
            StudMarkHead."Total No of Subject Failed" := FailCnt;
            if FailCnt > 0 then begin
                StudMarkHead.Failed := true;
                StudMarkHead.Rank := 0;
            end
            else
                StudMarkHead.Failed := false;
            StudMarkHead."Total No of Subject Absent" := AbsSubjCnt;
            if StudMarkHead."Total Marks" > 0 then begin
                StudMarkHead.Average := StudMarkHead."Total Marks" / (SubjCnt - AbsSubjCnt);
                StudMarksHeader."Percentage Scored" := (StudMarkHead."Total Marks" / TotalMarkconducted) * 100; //DK-16.07.13
                StudMarkHead.Insert;
            end;
        end;
    end;

    [Scope('Internal')]
    procedure UpdateRank(ClassCode: Code[20]; ExamCode: Code[20])
    var
        StudMarkHead: Record "Student Mark Header";
        varPrevTot: Decimal;
        varRank: Integer;
        varSame: Boolean;
        SetRank: Integer;
        StudMarkHead1: Record "Student Mark Header";
        CountSMH: Integer;
    begin
        /*
       StudMarkHead.RESET;
       StudMarkHead.SETCURRENTKEY(StudMarkHead."Class Code",StudMarkHead."Exam Type",StudMarkHead.Average);
       StudMarkHead.SETRANGE(StudMarkHead."Class Code",ClassCode);
       StudMarkHead.SETRANGE(StudMarkHead."Exam Type",ExamCode);
       StudMarkHead.SETRANGE(StudMarkHead.Failed,FALSE);
       IF StudMarkHead.ASCENDING(FALSE) THEN;
       IF StudMarkHead.FIND('-') THEN
       REPEAT
         IF varPrevTot= 0 THEN
         BEGIN
           varRank:= varRank + 1;
           varPrevTot:=StudMarkHead."Total Marks";
         END
         ELSE
         BEGIN
         IF varPrevTot = StudMarkHead."Total Marks" THEN
         BEGIN
           varRank:= varRank ;
           varPrevTot:=StudMarkHead."Total Marks";
           varSame:=TRUE;
         END
         ELSE
           IF varPrevTot <> StudMarkHead."Total Marks" THEN
           BEGIN
           IF varSame THEN
             varRank:= varRank + 2
           ELSE
             varRank:= varRank + 1;

           varPrevTot:=StudMarkHead."Total Marks";
           CLEAR(varSame);
         END
         END;
         StudMarkHead.Rank:=varRank;
         StudMarkHead.MODIFY;
       UNTIL StudMarkHead.NEXT=0
       ELSE BEGIN
         StudMarkHead.Rank:= 0;
         StudMarkHead.MODIFY;
       END;
       */
        Clear(StudMarkHead);
        StudMarkHead.SetRange(StudMarkHead."Class Code", ClassCode);
        StudMarkHead.SetRange(StudMarkHead."Exam Type", ExamCode);
        if StudMarkHead.FindSet(true, true) then
            StudMarkHead.ModifyAll(StudMarkHead.Rank, 0);

        SetRank := 1;
        Clear(StudMarkHead);
        StudMarkHead.SetCurrentKey(StudMarkHead."Class Code", StudMarkHead."Exam Type", StudMarkHead.Average);
        StudMarkHead.SetRange(StudMarkHead."Class Code", ClassCode);
        StudMarkHead.SetRange(StudMarkHead."Exam Type", ExamCode);
        StudMarkHead.SetRange(StudMarkHead.Failed, false);
        if StudMarkHead.Ascending(false) then;
        if StudMarkHead.Find('-') then
            repeat
                StudMarkHead1.Reset;
                StudMarkHead1.SetRange("Class Code", ClassCode);
                StudMarkHead1.SetRange("Exam Type", ExamCode);
                StudMarkHead1.SetRange(Failed, false);
                StudMarkHead1.SetRange(Rank, 0);
                StudMarkHead1.SetRange(Average, StudMarkHead.Average);
                if StudMarkHead1.FindSet(true, true) then;
                CountSMH := StudMarkHead1.Count;
                StudMarkHead1.ModifyAll(StudMarkHead1.Rank, SetRank);
                if CountSMH <> 0 then
                    SetRank := CountSMH + SetRank;
            until StudMarkHead.Next = 0;

        StudMarkHead.Reset;
        StudMarkHead.SetCurrentKey(StudMarkHead."Class Code", StudMarkHead."Exam Type", StudMarkHead.Average);
        StudMarkHead.SetRange(StudMarkHead."Class Code", ClassCode);
        StudMarkHead.SetRange(StudMarkHead."Exam Type", ExamCode);
        StudMarkHead.SetRange(StudMarkHead.Failed, true);
        if StudMarkHead.FindSet then begin
            StudMarkHead.ModifyAll(StudMarkHead.Rank, 0);
        end;

    end;

    [Scope('Internal')]
    procedure MarkEntryNotCompleted(ClassCode: Code[20]; ExamCode: Code[20]) Ret: array [50] of Text[50]
    var
        ClassSecSubjects: Record "Class Section Subjects";
        MarkHeader: Record "Marks Header";
        FacultySubject: Record "Faculty Subject";
        i: Integer;
    begin
        i:=1;
        ClassSecSubjects.SetRange(ClassSecSubjects."Class Code",ClassCode);
        if ClassSecSubjects.FindSet then
        repeat
          FacultySubject.Reset;
          FacultySubject.SetRange(FacultySubject."Class Code",ClassCode);
          FacultySubject.SetRange(FacultySubject."Subject Code",ClassSecSubjects.Subject);
          if FacultySubject.FindFirst then;
          MarkHeader.Reset;
          MarkHeader.SetRange(MarkHeader."Class Code",ClassCode);
          MarkHeader.SetRange(MarkHeader."Exam Type",ExamCode);
          MarkHeader.SetRange(MarkHeader.Subject,ClassSecSubjects.Subject);
          if MarkHeader.FindFirst then
          begin
            if MarkHeader."Entry Completed" then begin
              Ret[i] += ClassSecSubjects.Subject+','
                       +'TRUE'+','+FacultySubject."Faculty Code"+','+FacultySubject."Faculty Name";
            end else begin
              Ret[i] += ClassSecSubjects.Subject+','
                       +'FALSE'+','+FacultySubject."Faculty Code"+','+FacultySubject."Faculty Name";
            end;
          end else
            Ret[i] += ClassSecSubjects.Subject+','
                       +'FALSE'+','+FacultySubject."Faculty Code"+','+FacultySubject."Faculty Name";

        i+=1;
        until ClassSecSubjects.Next=0;
        Ret[i] := '#EOF';
    end;

    [Scope('Internal')]
    procedure StudentMarkHeaderPublish(ClassCode: Code[20];ExamCode: Code[20])
    var
        MarksLine: Record "Marks Line";
    begin
        // Start .KATHIR
        StudMarksHeader.Reset;
        StudMarksHeader.SetRange(StudMarksHeader."Class Code",ClassCode);
        StudMarksHeader.SetRange(StudMarksHeader."Exam Type",ExamCode);
        if StudMarksHeader.FindFirst then
        repeat
          if not StudMarksHeader.Failed then //SJ6.01
            UpdateAcademicPts(StudMarksHeader."Student No.",StudMarksHeader."Academic Year",StudMarksHeader."Exam Type");  //SJ6.01
          StudMarksHeader.Published := true;
          StudMarksHeader.Modify;
        until StudMarksHeader.Next = 0;

        MarksLine.Reset;
        MarksLine.SetRange(MarksLine."Exam Type",ExamCode);
        MarksLine.SetRange(MarksLine."Class Code",ClassCode);
        if MarksLine.FindSet then
        repeat
          MarksLine.Published := true;
          MarksLine.Modify;
        until MarksLine.Next=0;
        // Stop .KATHIR
    end;

    [Scope('Internal')]
    procedure UpdateNoofSubjectsFailed(StudentNo: Code[20];ExamCode: Code[20];ClassCode: Code[20])
    var
        MarksLine: Record "Marks Line";
        StudMarkHead: Record "Student Mark Header";
        Student: Record Student;
        Total: Decimal;
        FailCnt: Integer;
        SubjCnt: Integer;
        AbsSubjCnt: Integer;
    begin
        // Start .KATHIR
        Clear(FailCnt);
        Clear(SubjCnt);
        Clear(AbsSubjCnt);
        Student.Get(StudentNo);

        MarksLine.Reset;
        MarksLine.SetRange(MarksLine."Student No.",StudentNo);
        MarksLine.SetRange(MarksLine."Exam Type",ExamCode);
        MarksLine.SetRange(MarksLine."Class Code",ClassCode);
        if MarksLine.FindSet then
        repeat
          Total += MarksLine."Marks Obtained";
          if MarksLine.Result = MarksLine.Result::Fail then
            FailCnt+= 1;
          if MarksLine.Result = MarksLine.Result::Absent then
          begin
            AbsSubjCnt+=1;
            FailCnt+= 1;
          end;
          SubjCnt+=1;
        until MarksLine.Next=0;

        StudMarkHead.Reset;
        StudMarkHead.SetRange(StudMarkHead."Student No.",StudentNo);
        StudMarkHead.SetRange(StudMarkHead."Class Code",Student."Class Code");
        StudMarkHead.SetRange(StudMarkHead."Exam Type",ExamCode);
        if StudMarkHead.FindFirst then
        begin
          StudMarkHead."Total No of Subject Failed":= FailCnt;
          if FailCnt>0 then begin
            StudMarkHead.Failed:=true;
            StudMarkHead.Rank := 0;
          end
          else
            StudMarkHead.Failed:=false;
          StudMarkHead.Modify;
        end;
        // Stop .KATHIR
    end;

    [Scope('Internal')]
    procedure UpdateAcademicPts(StudNo: Code[20];AcademicYear: Code[20];ExamType: Code[20])
    var
        StuMarkHead: Record "Student Mark Header";
        AcadmicPts: Record "Academic Points";
        Grade: Record Grade;
    begin
        StuMarkHead.Get(StudNo,AcademicYear,ExamType);
        Grade.Reset;
        Grade.SetFilter("Min Percentage",'<=%1',StuMarkHead.Average);
        Grade.SetFilter("Max Percentage",'>=%1',StuMarkHead.Average);
        if Grade.FindLast then begin
          AcadmicPts.Init;
          AcadmicPts."Student No." := StuMarkHead."Student No.";
          AcadmicPts."Academic Year" := StuMarkHead."Academic Year";
          AcadmicPts."Exam Code" := StuMarkHead."Exam Type";
          AcadmicPts."Class Code" := StuMarkHead."Class Code";
          AcadmicPts.Points := Grade.Points;
          if not AcadmicPts.Insert then
            AcadmicPts.Modify;
        end;
    end;
}

