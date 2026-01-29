codeunit 71040 Academics
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  29/09/09   KATHIR   Insert Student Subjects()     Function added to Insert student academic Subjects
    //   02  29/09/09   KATHIR   Check Student Opt Subjects()  Function added to Validate Optional subjects for the student
    //   03  30/09/09   KATHIR   Insert Stud Opt Subjects()    Function added to Insert Student optional Subjects
    //   04  01/10/09   KATHIR   Copy Grades()                 Function added to copy Grade Master to all Classes and Curriculum
    //   05  16/10/09   VIGNESH  Copy Grades()                 code modifiy to all the points field
    //   06  23/11/09   VIGNESH  Insert Student Subjects()     Section Feild is removed from Parmeters
    //   07  25/11/09   VIGNESH  Copy Subjects                  Code added to copy the subjects for all sections
    //   08  18/01/10   Ankesh   UpdateStudentCPGAGrade()      Code to update CPGA grade.
    //   09  29/06/10   Ankesh   ApplicationSanctionOrCancel() Code to change the status of the student leave application


    trigger OnRun()
    begin
    end;

    var
        Student: Record Student;
        FacultyClassPlanHeader: Record "Faculty Class Plan Header";
        Text001: Label 'Home Work Duration exceeded';
        Text002: Label 'Home Work Approved';
        Text000: Label 'Student Subject Updated';
        Text003: Label 'Students has not allocated for the Class %1';
        Text004: Label 'Subject Group need to be captured for the Student %1';
        Text005: Label 'Subject need to filled in for the Group %1';
        Text006: Label 'Grade Updated to all Classes';
        Text007: Label 'Subjects for this Class %1 and Curriculim %2 is not done''';
        Text008: Label 'Secticons are anot allocated for this class %1 and curriculum %2';
        Text009: Label 'Copy Subjects Completed';
        Text010: Label 'Already the Plan Has been Appoved';
        Text011: Label 'Already the Plan Has been Rejected';
        Text012: Label 'The Plan Has not been Applied';
        Text013: Label 'Please give the comments for the rejection';
        Text014: Label 'Optional Subjects needs to be captured for the Student %1';
        VarCnt: Integer;
        VarVal: Integer;
        VarCnt1: Integer;
        VarVal1: Integer;

    [Scope('Internal')]
    procedure "Insert Student Subjects"(ClassCode: Code[20])
    var
        StudentSubjects: Record "Student Subjects";
        ClassSubjects: Record "Class Subjects";
        StudentSubjects1: Record "Student Subjects";
        ClassSectionSubjects: Record "Class Section Subjects";
    begin
        // Start 01.VIGNESH
        Student.Reset;
        Student.SetRange("Class Code", ClassCode);
        if Student.FindSet then begin
            repeat
                StudentSubjects.Reset;
                StudentSubjects.SetRange("Student No.", Student."No.");
                StudentSubjects.SetRange("Class Code", ClassCode);
                StudentSubjects.DeleteAll;

                ClassSectionSubjects.Reset;
                ClassSectionSubjects.SetRange("Class Code", ClassCode);
                ClassSectionSubjects.SetRange("Subject Group", 'MAJOR');
                ClassSectionSubjects.SetRange(ClassSectionSubjects."Group Code", Student."Subject Group");
                if ClassSectionSubjects.FindSet then
                    repeat
                        if not StudentSubjects1.Get(Student."No.", Student."Academic Year", ClassSectionSubjects.Subject) then begin
                            StudentSubjects.Init;
                            StudentSubjects."Student No." := Student."No.";
                            StudentSubjects."Academic Year" := Student."Academic Year";
                            StudentSubjects.Subject := ClassSectionSubjects.Subject;
                            StudentSubjects."Subject Group" := ClassSectionSubjects."Subject Group";
                            StudentSubjects.Class := ClassSectionSubjects.Class;
                            StudentSubjects.Section := ClassSectionSubjects.Section;
                            StudentSubjects.Curriculum := ClassSectionSubjects.Curriculum;
                            StudentSubjects.Description := ClassSectionSubjects.Description;
                            StudentSubjects."Student Gender" := Student.Gender;
                            StudentSubjects."Class Code" := ClassCode;
                            StudentSubjects.Insert;
                        end;
                    until ClassSectionSubjects.Next = 0;

                //Coding Added by kathir - for II Language - Start

                ClassSectionSubjects.Reset;
                ClassSectionSubjects.SetRange("Class Code", ClassCode);
                ClassSectionSubjects.SetRange("Subject Group", 'SEC LANG');
                ClassSectionSubjects.SetRange(ClassSectionSubjects."II Lang Type", Student."Second Language");
                if ClassSectionSubjects.FindSet then
                    repeat
                        if not StudentSubjects1.Get(Student."No.", Student."Academic Year", ClassSectionSubjects.Subject) then begin
                            StudentSubjects.Init;
                            StudentSubjects."Student No." := Student."No.";
                            StudentSubjects."Academic Year" := Student."Academic Year";
                            StudentSubjects.Subject := ClassSectionSubjects.Subject;
                            StudentSubjects."Subject Group" := ClassSectionSubjects."Subject Group";
                            StudentSubjects.Class := ClassSectionSubjects.Class;
                            StudentSubjects.Section := ClassSectionSubjects.Section;
                            StudentSubjects.Curriculum := ClassSectionSubjects.Curriculum;
                            StudentSubjects.Description := ClassSectionSubjects.Description;
                            StudentSubjects."Student Gender" := Student.Gender;
                            StudentSubjects."Class Code" := ClassCode;
                            StudentSubjects.Insert;
                        end;
                    until ClassSectionSubjects.Next = 0;

                //Coding Added by kathir - for II Language - Stop
            until Student.Next = 0;
        end else
            Error(Text003, ClassCode);
        Message(Text000);
        // Stop 01.VIGNESH
    end;

    [Scope('Internal')]
    procedure "Copy Grades"()
    var
        Class: Record Class;
        Curriculum: Record Curriculum;
        Grade: Record Grade;
        EducationVertical: Codeunit "Education Vertical";
        AcadYr: Code[10];
        ClassGrade: Record "Class Grade";
    begin
        // Start 04.KATHIR
        AcadYr := EducationVertical.GetAcademicYear;
        if Class.FindSet then
            repeat
                if Curriculum.FindSet then
                    repeat
                        if Grade.FindSet then
                            repeat
                                if not ClassGrade.Get(Class.Code, Curriculum.Code, AcadYr, Grade.Code) then begin
                                    ClassGrade.Init;
                                    ClassGrade.Class := Class.Code;
                                    ClassGrade.Curriculum := Curriculum.Code;
                                    ClassGrade."Academic Year" := AcadYr;
                                    ClassGrade."Grade Code" := Grade.Code;
                                    ClassGrade.Description := Grade.Description;
                                    // Start 05.VIGNESH
                                    ClassGrade.Points := Grade.Points;
                                    // Stop 05.VIGNESH
                                    ClassGrade."Max Percentage" := Grade."Max Percentage";
                                    ClassGrade."Min Percentage" := Grade."Min Percentage";
                                    ClassGrade.Insert;
                                end;
                            until Grade.Next = 0;
                    until Curriculum.Next = 0;
            until Class.Next = 0;
        Message(Text006);
        // Stop 04.KATHIR
    end;

    [Scope('Internal')]
    procedure "Copy Subjects"(getClass: Code[20]; getCurriculum: Code[20]; getAcademicYear: Code[20])
    var
        ClassCard: Record "Class Card";
        ClassSubjects: Record "Class Subjects";
        ClassSection: Record "Class Section";
        ClassSectionSubjects: Record "Class Section Subjects";
        ClassSubjects1: Record "Class Subjects";
    begin
        // Start 07.VIGNESH
        ClassCard.Reset;
        ClassCard.SetRange(Class, getClass);
        ClassCard.SetRange(Curriculum, getCurriculum);
        ClassCard.SetRange("Academic Year", getAcademicYear);
        if ClassCard.FindFirst then begin
            ClassSubjects.Reset;
            ClassSubjects.SetRange(Class, getClass);
            ClassSubjects.SetRange(Curriculum, getCurriculum);
            ClassSubjects.SetRange("Academic Year", getAcademicYear);
            if ClassSubjects.IsEmpty then
                Error(Text007, getClass, getCurriculum)
            else
                if ClassSubjects.FindFirst then begin
                    ClassSection.Reset;
                    ClassSection.SetRange(Class, getClass);
                    ClassSection.SetRange(Curriculum, getCurriculum);
                    ClassSection.SetRange("Academic Year", getAcademicYear);
                    if ClassSection.IsEmpty then
                        Error(Text008, getClass, getCurriculum)
                    else
                        if ClassSection.FindSet then
                            repeat
                                ClassSubjects1.Reset;
                                ClassSubjects1.SetRange(Class, getClass);
                                ClassSubjects1.SetRange(Curriculum, getCurriculum);
                                ClassSubjects1.SetRange("Academic Year", getAcademicYear);
                                if ClassSubjects1.FindSet then
                                    repeat
                                        ClassSectionSubjects.TransferFields(ClassSubjects1);
                                        ClassSectionSubjects.Section := ClassSection.Section;
                                        ClassSectionSubjects."Class Code" :=
                                        ClassSubjects1.Class + '-' + ClassSection.Section + '-' + ClassSubjects1.Curriculum + '-' + ClassSubjects1.
                                          "Academic Year";
                                        ClassSectionSubjects.Insert;
                                    until ClassSubjects1.Next = 0;
                            until ClassSection.Next = 0;
                end;
            Message(Text009);
        end;
        // Stop 07.VIGNESH
    end;

    [Scope('Internal')]
    procedure UpdateStudentCPGAGrade(Student: Record Student)
    var
        ClassGrade: Record "Class Grade";
        Point: Decimal;
    begin
        // Start 08.Ankesh
        ClassGrade.Reset;
        ClassGrade.SetCurrentKey(Class, Points);
        ClassGrade.SetRange(Class, Student.Class);
        Student.CalcFields(CGPA);
        Point := Round(Student.CGPA, 1, '=');
        ClassGrade.SetRange(Points, Point);
        repeat
            if ClassGrade.Class <> '' then begin
                Student."CGPA Grade" := ClassGrade."Grade Code";
                Student.Modify;
            end;
        until ClassGrade.Next = 0;
        // Stop 08.Ankesh
    end;

    [Scope('Internal')]
    procedure GetStudents(HomeworkNo: Code[20])
    var
        HomeWork: Record Table71063;
        HomeworkLine: Record Table71064;
    begin
        // Start 01.KATHIR
        HomeWork.GET(HomeworkNo);
        HomeWork.TESTFIELD(Class);
        HomeWork.TESTFIELD(Section);
        HomeWork.TESTFIELD("Academic Year");
        HomeWork.TESTFIELD(Curriculum);
        HomeWork.TESTFIELD("Subject Code");
        HomeWork.TESTFIELD("Time Required");
        Student.Reset;
        Student.SetRange(Class, HomeWork.Class);
        Student.SetRange(Section, HomeWork.Section);
        Student.SetRange(Curriculum, HomeWork.Curriculum);
        Student.SetRange("Academic Year", HomeWork."Academic Year");
        if Student.FindSet then
            repeat
                HomeworkLine."Homework No." := HomeworkNo;
                HomeworkLine."Student No." := Student."No.";
                HomeworkLine."Student Name" := Student.Name;
                HomeworkLine.INSERT;
            until Student.Next = 0;
        // Stop 01.KATHIR
    end;

    [Scope('Internal')]
    procedure ApproveHomework(HomeworkNo: Code[20])
    var
        HomeWork: Record Table71063;
        HomeworkLine: Record Table71064;
        ClassSection: Record "Class Section";
        HomeworkRec: Record Table71063;
        TotalTime: Decimal;
    begin
        Clear(TotalTime);
        HomeWork.GET(HomeworkNo);
        HomeWork.TESTFIELD("Class Code");
        HomeWork.TESTFIELD("Subject Code");
        HomeWork.TESTFIELD("Time Required");
        HomeWork.TESTFIELD("Created Date");
        ClassSection.Get(HomeWork."Class Code");
        HomeworkRec.SETRANGE("Class Code", HomeWork."Class Code");
        HomeworkRec.SETRANGE("Created Date", HomeWork."Created Date");
        HomeworkRec.SETRANGE("Homework Status", HomeworkRec."Homework Status"::"1");
        if HomeworkRec.FINDSET then
            repeat
                TotalTime := HomeworkRec."Time Required" + TotalTime;
            until HomeworkRec.NEXT = 0;

        if (TotalTime + HomeWork."Time Required") > ClassSection."Home Work Duration" then
            Error(Text001)
        else begin
            HomeWork."Homework Status" := HomeWork."Homework Status"::"1";
            HomeWork.MODIFY;
        end;
    end;

    [Scope('Internal')]
    procedure ApplicationSanctionOrCancel(Check: Boolean; "No.": Code[10])
    var
        LeaveAppRec: Record "Student Leave Application";
    begin
        // Start 09.Ankesh
        LeaveAppRec.Reset;
        if LeaveAppRec.Get("No.") then
            if Check then begin
                LeaveAppRec."Leave Status" := LeaveAppRec."Leave Status"::Requested;
                LeaveAppRec.Modify;
            end else begin
                LeaveAppRec."Leave Status" := LeaveAppRec."Leave Status"::Sanctioned;
                LeaveAppRec.Modify;
            end;
        // Stop 09. Ankesh
    end;

    [Scope('Internal')]
    procedure "Insert Student Opt Subjects"("StudentNo.": Code[20]; ClassCode: Code[20])
    var
        StudOptionalSub: Record "Student Optional Subjects";
        StudentSubjects: Record "Student Subjects";
        ClassSection: Record "Class Section";
        StudentRec: Record Student;
        StudentSubjects1: Record "Student Subjects";
    begin
        // Function Added by kathir for St judes
        StudentRec.Get("StudentNo.");
        ClassSection.Reset;
        ClassSection.SetRange(ClassSection."Class Code", ClassCode);
        if ClassSection.FindFirst then;
        VarCnt := 0;
        VarVal := 0;
        VarVal1 := 0;
        VarCnt1 := 0;
        if (StudentRec.Class = '9') or (StudentRec.Class = '10') then begin
            StudOptionalSub.Reset;
            StudOptionalSub.SetCurrentKey(Group);
            StudOptionalSub.SetRange(StudOptionalSub."Student No", "StudentNo.");
            StudOptionalSub.SetRange(StudOptionalSub."Class Code", ClassCode);
            if StudOptionalSub.FindFirst then
                repeat
                    if StudOptionalSub."Class 9 10 Group Code" = StudOptionalSub."Class 9 10 Group Code"::"Group 2" then begin
                        if StudOptionalSub.Group <> 0 then begin
                            if VarVal <> StudOptionalSub.Group then
                                VarCnt += 1;
                            VarVal := StudOptionalSub.Group;
                        end
                        else
                            VarCnt += 1;
                    end;
                    if StudOptionalSub."Class 9 10 Group Code" = StudOptionalSub."Class 9 10 Group Code"::"Group 3" then begin
                        if StudOptionalSub.Group <> 0 then begin
                            if VarVal1 <> StudOptionalSub.Group then
                                VarCnt1 += 1;
                            VarVal1 := StudOptionalSub.Group;
                        end
                        else
                            VarCnt1 += 1;

                    end;
                    if VarCnt > ClassSection."Max Group 2 Count" then
                        Error('%1 Can choose only %2 Optional Subjects in Group 2', StudentRec.Name, ClassSection."Max Group 2 Count");
                    if VarCnt1 > ClassSection."Max Group 3 Count" then
                        Error('%1 Can choose only %2 Optional Subjects in Group 3', StudentRec.Name, ClassSection."Max Group 2 Count");

                    if not StudentSubjects1.Get(StudentRec."No.", StudentRec."Academic Year", StudOptionalSub.Subject) then begin
                        StudentSubjects.Init;
                        StudentSubjects."Student No." := StudentRec."No.";
                        StudentSubjects."Academic Year" := StudentRec."Academic Year";
                        StudentSubjects.Subject := StudOptionalSub.Subject;
                        StudentSubjects."Subject Group" := StudOptionalSub."Subject Group";
                        StudentSubjects.Class := ClassSection.Class;
                        StudentSubjects.Section := ClassSection.Section;
                        StudentSubjects.Curriculum := ClassSection.Curriculum;
                        StudentSubjects.Description := StudOptionalSub.Description;
                        StudentSubjects."Student Gender" := StudentRec.Gender;
                        StudentSubjects."Class Code" := ClassCode;
                        StudentSubjects.Insert;
                    end;
                until StudOptionalSub.Next = 0;
            Message('Optional Subjects Updated Successfully');
        end;



        //MESSAGE('%1   %2',VarCnt,VarCnt1);
    end;
}

