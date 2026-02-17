codeunit 71883 "Common List"
{

    trigger OnRun()
    begin
    end;

    var
        EduSetup: Record "Education Setup";

    procedure GetClass() Ret: array[100] of Text[100]
    var
        Class: Record Class;
        i: Integer;
    begin
        i := 1;
        Class.SETCURRENTKEY(Sequence);
        IF Class.FINDSET() THEN
            REPEAT
                Ret[i] := Class.Code;
                Ret[i] += ',' + Class.Description;
                i := i + 1;
            UNTIL Class.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetCurriculum() Ret: array[10] of Text[100]
    var
        Curriculum: Record Curriculum;
        i: Integer;
    begin
        i := 1;
        IF Curriculum.FINDSET() THEN
            REPEAT
                Ret[i] := Curriculum.Code;
                Ret[i] += ',' + Curriculum.Description;
                i := i + 1;
            UNTIL Curriculum.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetCitizenship() Ret: array[50] of Text[100]
    var
        Citizenship: Record Citizenship;
        i: Integer;
    begin
        i := 1;
        IF Citizenship.FINDSET() THEN
            REPEAT
                Ret[i] := Citizenship.Code;
                Ret[i] += ',' + Citizenship.Description;
                i := i + 1;
            UNTIL Citizenship.NEXT() = 0;
        Ret[i] := '#EOF';
    end;

    procedure GetMedium() Ret: array[25] of Text[100]
    var
        Medium: Record "Medium of Instruction";
        i: Integer;
    begin
        i := 1;
        IF Medium.FINDSET() THEN
            REPEAT
                Ret[i] := Medium.Code;
                Ret[i] += ',' + Medium.Description;
                i := i + 1;
            UNTIL Medium.NEXT() = 0;
        Ret[i] := '#EOF';
    end;

    procedure GetEnquirySource() Ret: array[25] of Text[100]
    var
        EnquirySource: Record "Enquiry Source";
        i: Integer;
    begin

        i := 1;
        IF EnquirySource.FINDSET() THEN
            REPEAT
                Ret[i] := EnquirySource.Code;
                Ret[i] += ',' + EnquirySource.Description;
                i := i + 1;
            UNTIL EnquirySource.NEXT() = 0;
        Ret[i] := '#EOF';
    end;

    procedure GetPostcode() Ret: array[100] of Text[100]
    var
        Postcode: Record "Post Code";
        i: Integer;
    begin
        i := 1;
        IF Postcode.FINDSET() THEN
            REPEAT
                Ret[i] := Postcode.Code;
                Ret[i] += ',' + Postcode.City;
                i := i + 1;
            UNTIL Postcode.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    // procedure GetState() Ret: array [100] of Text[100]
    // var
    //     i: Integer;
    //     State: Record Table13762;
    // begin       
    //     i := 1;
    //     IF State.FINDSET THEN
    //       REPEAT
    //         Ret[i] := State.Code;
    //         Ret[i] += ',' + State.Description;
    //         i := i + 1;
    //       UNTIL State.NEXT = 0;
    //     Ret[i] := '#EOF';        
    // end;


    procedure GetCountry() Ret: array[100] of Text[100]
    var
        Country: Record "Country/Region";
        i: Integer;
    begin
        i := 1;
        IF Country.FINDSET() THEN
            REPEAT
                Ret[i] := Country.Code;
                Ret[i] += ',' + Country.Name;
                i := i + 1;
            UNTIL Country.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetEnquiryType() Ret: array[25] of Text[100]
    var
        EnquiryType: Record "Enquiry Type";
        i: Integer;
    begin
        i := 1;
        IF EnquiryType.FINDSET() THEN
            REPEAT
                Ret[i] := EnquiryType.Code;
                Ret[i] += ',' + EnquiryType.Description;
                i := i + 1;
            UNTIL EnquiryType.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetRelatives() Ret: array[15] of Text[100]
    var
        Relative: Record Relative;
        i: Integer;
    begin
        i := 1;
        IF Relative.FINDSET() THEN
            REPEAT
                Ret[i] := Relative.Code;
                Ret[i] += ',' + Relative.Description;
                i := i + 1;
            UNTIL Relative.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetPaymentMethod() Ret: array[25] of Text[100]
    var
        PaymentMethod: Record "Payment Method";
        i: Integer;
    begin
        i := 1;
        IF PaymentMethod.FINDSET() THEN
            REPEAT
                Ret[i] := PaymentMethod.Code;
                Ret[i] += ',' + PaymentMethod.Description;
                i := i + 1;
            UNTIL PaymentMethod.NEXT() = 0;
        Ret[i] := '#EOF';
    end;

    procedure GetAcademicYear() Ret: array[25] of Text[100]
    var
        AcademicYear: Record "Academic Year";
        i: Integer;
    begin
        i := 1;
        IF AcademicYear.FINDSET() THEN
            REPEAT
                Ret[i] := AcademicYear.Code;
                Ret[i] += ',' + AcademicYear.Description;
                i := i + 1;
            UNTIL AcademicYear.NEXT() = 0;
        Ret[i] := '#EOF';
    end;

    procedure GetExamCode() Ret: array[25] of Text[100]
    var
        ExamCode: Record "Exam Code";
        i: Integer;
    begin
        i := 1;
        ExamCode.SETCURRENTKEY("Exam Order");
        IF ExamCode.FINDSET() THEN
            REPEAT
                Ret[i] := ExamCode.Code;
                Ret[i] += ',' + ExamCode.Description;
                i := i + 1;
            UNTIL ExamCode.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetEvaluationMethod() Ret: array[15] of Text[100]
    var
        EvaluationMethod: Record "Evaluation Method";
        i: Integer;
    begin
        i := 1;
        IF EvaluationMethod.FINDSET() THEN
            REPEAT
                Ret[i] := EvaluationMethod.Code;
                Ret[i] += ',' + EvaluationMethod.Description;
                i := i + 1;
            UNTIL EvaluationMethod.NEXT() = 0;
        Ret[i] := '#EOF';
    end;

    procedure GetCommunity() Ret: array[10] of Text[100]
    var
        Community: Record Community;
        i: Integer;
    begin
        i := 1;
        IF Community.FINDSET() THEN
            REPEAT
                Ret[i] := Community.Code;
                Ret[i] += ',' + Community.Description;
                i := i + 1;
            UNTIL Community.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetMotherTongue() Ret: array[50] of Text[100]
    var
        MotherTongue: Record "Mother Tongue";
        i: Integer;
    begin
        i := 1;
        IF MotherTongue.FINDSET() THEN
            REPEAT
                Ret[i] := MotherTongue.Code;
                Ret[i] += ',' + MotherTongue.Description;
                i := i + 1;
            UNTIL MotherTongue.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetQuota() Ret: array[10] of Text[100]
    var
        Quota: Record Quota;
        i: Integer;
    begin
        i := 1;
        IF Quota.FINDSET() THEN
            REPEAT
                Ret[i] := Quota.Code;
                Ret[i] += ',' + Quota.Description;
                i := i + 1;
            UNTIL Quota.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetFeeClassification() Ret: array[25] of Text[100]
    var
        FeeClassification: Record "Fee Classification";
        i: Integer;
    begin
        i := 1;
        IF FeeClassification.FINDSET() THEN
            REPEAT
                Ret[i] := FeeClassification.Code;
                Ret[i] += ',' + FeeClassification.Description;
                i := i + 1;
            UNTIL FeeClassification.NEXT() = 0;
        Ret[i] := '#EOF';
    end;

    // procedure GetBookCategory() Ret: array [50] of Text[100]
    // var
    //     i: Integer;
    //     BookCategory: Record Table71634;
    // begin
    //     // Start 19.GUNA
    //     i := 1;
    //     IF BookCategory.FINDSET THEN
    //       REPEAT
    //         Ret[i] := BookCategory.Code;
    //         Ret[i] += ',' + BookCategory.Description;
    //         i := i + 1;
    //       UNTIL BookCategory.NEXT = 0;
    //     Ret[i] := '#EOF';
    //     // Stop 19.GUNA
    // end;

    procedure GetLanguage() Ret: array[100] of Text[100]
    var
        Language: Record Language;
        i: Integer;
    begin
        i := 1;
        IF Language.FINDSET() THEN
            REPEAT
                Ret[i] := Language.Code;
                Ret[i] += ',' + Language.Name;
                i := i + 1;
            UNTIL Language.NEXT() = 0;
        Ret[i] := '#EOF';
    end;

    procedure GetSection() Ret: array[10] of Text[100]
    var
        Section: Record Section;
        i: Integer;
    begin
        i := 1;
        IF Section.FINDSET() THEN
            REPEAT
                Ret[i] := Section.Code;
                Ret[i] += ',' + Section.Description;
                i := i + 1;
            UNTIL Section.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetGrade() Ret: array[10] of Text[100]
    var
        Grade: Record Grade;
        i: Integer;
    begin
        i := 1;
        IF Grade.FINDSET() THEN
            REPEAT
                Ret[i] := Grade.Code;
                Ret[i] += ',' + Grade.Description;
                i := i + 1;
            UNTIL Grade.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetLocation() Ret: array[50] of Text[100]
    var
        Location: Record Location;
        i: Integer;
    begin
        i := 1;
        IF Location.FINDSET() THEN
            REPEAT
                Ret[i] := Location.Code;
                Ret[i] += ',' + Location.Name;
                i := i + 1;
            UNTIL Location.NEXT() = 0;
        Ret[i] := '#EOF';
    end;

    procedure GetFeeComponent() Ret: array[20] of Text[100]
    var
        FeeComponents: Record "Fee Components";
        i: Integer;
    begin
        i := 1;
        IF FeeComponents.FINDSET() THEN
            REPEAT
                Ret[i] := FeeComponents.Code;
                Ret[i] += ',' + FeeComponents.Description;
                i := i + 1;
            UNTIL FeeComponents.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetClassGroup() Ret: array[20] of Text[100]
    var
        ClassGroup: Record "Class Group";
        i: Integer;
    begin

        i := 1;
        IF ClassGroup.FINDSET() THEN
            REPEAT
                Ret[i] := ClassGroup.Code;
                Ret[i] += ',' + ClassGroup.Description;
                i := i + 1;
            UNTIL ClassGroup.NEXT() = 0;
        Ret[i] := '#EOF';

    end;


    // procedure GetFeeType() Ret: array [25] of Text[100]
    // var      
    //     FeeType: Record "Fee Type";
    //       i: Integer;
    // begin

    //     i := 1;
    //     IF FeeType.FINDSET THEN
    //       REPEAT
    //         Ret[i] := FeeType.Code;
    //         Ret[i] += ',' + FeeType.Description;
    //         i := i + 1;
    //       UNTIL FeeType.NEXT = 0;
    //     Ret[i] := '#EOF';

    // end;


    procedure GetClassSection() Ret: array[100] of Text[100]
    var
        ClassSection: Record "Class Section";
        i: Integer;
    begin

        i := 1;
        IF ClassSection.FINDSET() THEN
            REPEAT
                Ret[i] := ClassSection.Class;
                Ret[i] += ',' + ClassSection.Section;
                Ret[i] += ClassSection.Curriculum;
                i := i + 1;
            UNTIL ClassSection.NEXT() = 0;
        Ret[i] := '#EOF';

    end;


    procedure GetKeyStages() Ret: array[100] of Text[100]
    var
        KeyStages: Record KeyStages;
        i: Integer;
    begin

        i := 1;
        IF KeyStages.FINDSET() THEN
            REPEAT
                Ret[i] := KeyStages."Divison Code";
                Ret[i] += ',' + KeyStages.Code;
                i := i + 1;
            UNTIL KeyStages.NEXT() = 0;
        Ret[i] := '#EOF';

    end;


    procedure GetSubject() Ret: array[100] of Text[100]
    var
        Subject: Record Subject;
        i: Integer;
    begin

        i := 1;
        IF Subject.FINDSET() THEN
            REPEAT
                Ret[i] := Subject.Code;
                Ret[i] += ',' + Subject.Description;
                i := i + 1;
            UNTIL Subject.NEXT() = 0;
        Ret[i] := '#EOF';

    end;


    procedure GetChapter() Ret: array[100] of Text[100]
    var
        ChapterMaster: Record "Chapter Master";
        i: Integer;
    begin

        i := 1;
        IF ChapterMaster.FINDSET() THEN
            REPEAT
                Ret[i] := ChapterMaster.Code;
                Ret[i] += ',' + ChapterMaster.Description;
                i := i + 1;
            UNTIL ChapterMaster.NEXT() = 0;
        Ret[i] := '#EOF';

    end;


    procedure GetCurrentYear() Ret: Text[50]
    var
        EducationSetup: Record "Education Setup";
    begin

        EducationSetup.GET();
        Ret := EducationSetup."Academic Year";
        Ret += ';' + FORMAT(EducationSetup."Start Date") + ';' + FORMAT(EducationSetup."End Date");

    end;


    // procedure GetCourse() Ret: array [50] of Text[100]
    // var
    //     Course: Record Table71351;
    //     i: Integer;
    // begin
    //     // Start 32.GUNA
    //     i := 1;
    //     IF Course.FINDSET THEN
    //       REPEAT
    //         Ret[i] := Course.Code;
    //         Ret[i] += ',' + Course.Description;
    //         i := i + 1;
    //       UNTIL Course.NEXT = 0;
    //     Ret[i] := '#EOF';
    //     // Stop 32.GUNA
    // end;


    // procedure GetUniversity() Ret: array [20] of Text[100]
    // var
    //     University: Record Table71280;
    //     i: Integer;
    // begin
    //     // Start 33.GUNA
    //     i := 1;
    //     IF University.FINDSET THEN
    //       REPEAT
    //         Ret[i] := University.Code;
    //         Ret[i] += ',' + University.Description;
    //         i := i + 1;
    //       UNTIL University.NEXT = 0;
    //     Ret[i] := '#EOF';
    //     // Stop 33.GUNA
    // end;


    // procedure GetPrequalification() Ret: array [50] of Text[100]
    // var
    //     Prequalification: Record Table71276;
    //     i: Integer;
    // begin
    //     // Start 34.GUNA
    //     i := 1;
    //     IF Prequalification.FINDSET THEN
    //       REPEAT
    //         Ret[i] := Prequalification.Code;
    //         Ret[i] += ',' + Prequalification.Description;
    //         i := i + 1;
    //       UNTIL Prequalification.NEXT = 0;
    //     Ret[i] := '#EOF';
    //     // Stop 34.GUNA
    // end;


    // procedure GetSemester() Ret: array [10] of Text[100]
    // var
    //     Semester: Record Table71354;
    //     i: Integer;
    // begin
    //     // Start 35.GUNA
    //     i := 1;
    //     IF Semester.FINDSET THEN
    //       REPEAT
    //         Ret[i] := Semester.Code;
    //         Ret[i] += ',' + Semester.Description;
    //         i := i + 1;
    //       UNTIL Semester.NEXT = 0;
    //     Ret[i] := '#EOF';
    //     // Stop 35.GUNA
    // end;


    procedure GetReligion() Ret: array[20] of Text[100]
    var
        Religion: Record Religion;
        i: Integer;
    begin

        i := 1;
        IF Religion.FINDSET() THEN
            REPEAT
                Ret[i] := Religion.Code;
                Ret[i] += ',' + Religion.Description;
                i := i + 1;
            UNTIL Religion.NEXT() = 0;
        Ret[i] := '#EOF';

    end;


    // procedure GetCaste() Ret: array [100] of Text[100]
    // var
    //     Caste: Record Caste;
    //     i: Integer;
    // begin
    //     // Start 37.GUNA
    //     i := 1;
    //     IF Caste.FINDSET THEN
    //       REPEAT
    //         Ret[i] := Caste.Code;
    //         Ret[i] += ',' + Caste.Description;
    //         i := i + 1;
    //       UNTIL Caste.NEXT = 0;
    //     Ret[i] := '#EOF';
    //     // Stop 37.GUNA
    // end;

    //    procedure GetSubjectType() Ret: array [10] of Text[100]
    // var
    //     SubjectType: Record Table71360;
    //     i: Integer;
    // begin
    //     // Start 38.GUNA
    //     i := 1;
    //     IF SubjectType.FINDSET THEN
    //       REPEAT
    //         Ret[i] := SubjectType.Code;
    //         Ret[i] += ',' + SubjectType.Description;
    //         i := i + 1;
    //       UNTIL SubjectType.NEXT = 0;
    //     Ret[i] := '#EOF';
    //     // Stop 38.GUNA
    // end;


    procedure GetExam() Ret: array[50] of Text[100]
    var
        ExamMethods: Record "Exam Code";
        i: Integer;
    begin

        i := 1;
        IF ExamMethods.FINDSET() THEN
            REPEAT
                Ret[i] := ExamMethods.Code;
                Ret[i] += ',' + ExamMethods.Description;
                i := i + 1;
            UNTIL ExamMethods.NEXT() = 0;
        Ret[i] := '#EOF';

    end;


    procedure CheckPostcode(Postcode: Code[10]; City: Text[30]) Ret: Boolean
    var
        PostCode1: Record "Post Code";
    begin

        IF NOT PostCode1.GET(Postcode, City) THEN BEGIN
            PostCode1.Code := Postcode;
            PostCode1.City := City;
            PostCode1.INSERT();
            Ret := TRUE;
        END;

    end;


    procedure UpdateTimeTable(EntryNo: Integer; AttendanceNo: Code[20]) Ret: Boolean
    var
        // TimeTableLedger: Record Table71517;
        "TimeTable-School": Record "Time Table Ledger";
    begin
        EduSetup.GET();
        // IF EduSetup.Company = EduSetup.Company::College THEN BEGIN
        //   IF TimeTableLedger.GET(EntryNo) THEN BEGIN
        //     TimeTableLedger.VALIDATE(TimeTableLedger."Attendance Code",AttendanceNo);
        //     IF TimeTableLedger.MODIFY THEN
        //       EXIT(TRUE);
        //   END;
        // END ELSE
        IF EduSetup.Company = EduSetup.Company::School THEN
            IF "TimeTable-School".GET(EntryNo) THEN BEGIN
                "TimeTable-School".VALIDATE("TimeTable-School"."Attendance Code", AttendanceNo);
                IF "TimeTable-School".MODIFY() THEN
                    EXIT(TRUE);
            END;

    end;

    //    procedure UpdateTimeTableMark(EntryNo: Integer;MarkNo: Code[20]) Ret: Boolean
    // var
    //     TimeTableLedger: Record Table71517;
    // begin
    //             IF TimeTableLedger.GET(EntryNo) THEN BEGIN
    //       TimeTableLedger."Internal Exam Code" := MarkNo;
    //       IF TimeTableLedger.MODIFY THEN
    //         EXIT(TRUE);
    //     END;      
    // end;


    // procedure GetBookAvail(UserID: Code[20];BookNo: Code[20]) Ret: array [3] of Boolean
    // var
    //     Book: Record Table71630;
    //     Accession: Record Table71631;
    //     Accession1: Record Table71631;
    // begin
    //            IF Book.GET(BookNo) THEN BEGIN
    //       Accession.RESET;
    //       Accession.SETRANGE("Book No.",BookNo);
    //       Accession.SETRANGE("Advance Booked",TRUE);
    //       Accession.SETRANGE("Booked By",UserID);
    //       IF NOT Accession.FINDFIRST THEN BEGIN
    //         Ret[1] := TRUE;
    //         Book.CALCFIELDS("Available Count");
    //         IF Book."Available Count" > 0 THEN
    //           Ret[2] := TRUE;
    //         Accession1.RESET;
    //         Accession1.SETRANGE("Book No.",BookNo);
    //         Accession1.SETRANGE("Advance Booked",FALSE);
    //         IF Accession1.FINDSET THEN
    //           Ret[3] := TRUE;
    //       END;
    //     END;        
    // end;


    // procedure GetInternalMax(Course: Code[20];Semester: Code[10];Section: Code[10];AcademicYear: Code[10];Subject: Code[20];ExamCode: Code[20]) Ret: Decimal
    // var
    //     CourseSubjExamMethod: Record Table71384;
    // begin       
    //     CourseSubjExamMethod.RESET;
    //     CourseSubjExamMethod.SETCURRENTKEY(Course,Semester,Section,"Academic year","Subject Code","Exam Method");
    //     CourseSubjExamMethod.SETRANGE(Course,Course);
    //     CourseSubjExamMethod.SETRANGE(Semester,Semester);
    //     CourseSubjExamMethod.SETRANGE(Section,Section);
    //     CourseSubjExamMethod.SETRANGE("Academic year",AcademicYear);
    //     CourseSubjExamMethod.SETRANGE("Subject Code",Subject);
    //     CourseSubjExamMethod.SETRANGE("Exam Method",ExamCode);
    //     IF CourseSubjExamMethod.FINDFIRST THEN
    //       Ret := CourseSubjExamMethod.Maximum;
    //         end;


    // procedure GetMyStudents(FacultyCode: Code[20]) Ret: Text[100]
    // var
    //     FacultySubjects: Record Table71515;
    //     Student: Record Table71355;
    //     StudentSubjects: Record Table71359;
    //     EduSetup1: Record "Education Setup";
    //     XMLFile: File;
    //     FLName: Text[250];
    //     StudentTemp: Record Table71355 temporary;
    //     Addtext: Text[250];
    //     TestStream: OutStream;
    //     StudentXML: XMLport XMLport51000;
    //                     CollStud: Record Table71355;
    // begin

    //     StudentTemp.RESET;
    //     StudentTemp.DELETEALL;

    //     EduSetup1.GET;
    //     EduSetup1.TESTFIELD("XML File Path");

    //     EduSetup1.GET;
    //     FacultySubjects.RESET;
    //     FacultySubjects.SETRANGE("Faculty Code",FacultyCode);
    //     IF FacultySubjects.FINDSET(FALSE,FALSE) THEN
    //       REPEAT
    //         StudentSubjects.RESET;
    //         StudentSubjects.SETRANGE(Course,FacultySubjects."Course Code");
    //         StudentSubjects.SETRANGE(Semester,FacultySubjects."Semester Code");
    //         StudentSubjects.SETRANGE(Section,FacultySubjects."Section Code");
    //         StudentSubjects.SETRANGE("Subject Code",FacultySubjects."Subject Code");
    //         IF StudentSubjects.FINDSET(FALSE,FALSE) THEN
    //           REPEAT
    //             IF Student.GET(StudentSubjects."Student No.") THEN
    //               Student.MARK(TRUE);
    //           UNTIL StudentSubjects.NEXT = 0;
    //       UNTIL FacultySubjects.NEXT = 0;

    //     Student.MARKEDONLY(TRUE);
    //     FLName := EduSetup1."XML File Path" + FacultyCode + '-MyStudents.xml';

    //     IF FILE.EXISTS(FLName) THEN
    //       FILE.ERASE(FLName);

    //     XMLFile.CREATE(FLName);
    //     XMLFile.CREATEOUTSTREAM(TestStream);
    //     IF Student.FINDSET THEN
    //       XMLPORT.EXPORT(51000,TestStream,Student)
    //     ELSE
    //       XMLPORT.EXPORT(51000,TestStream,Student);
    //     XMLFile.CLOSE;
    //     Ret := FacultyCode + '-MyStudents.xml';
    // end;


    procedure AddLinks(TableID: Integer; "Key": Text[100]; FileLink: Text[250]) Ret: Boolean
    var
        RecRef: RecordRef;
        RecId: RecordID;
    begin
        RecRef.OPEN(TableID);
        EVALUATE(RecId, FORMAT(TableID) + ': ' + FORMAT(Key));
        RecRef.GET(RecId);
        RecRef.ADDLINK(FileLink);
        RecRef.MODIFY();
    end;


    procedure GetLinks(TableID: Integer; "Key": Text[100]) Ret: array[50] of Text[1024]
    var
        ReordLink: Record "Record Link";
        RecId: RecordID;
        i: Integer;
    begin
        i := 1;
        EVALUATE(RecId, FORMAT(TableID) + ': ' + FORMAT(Key));
        ReordLink.RESET();
        ReordLink.SETRANGE("Record ID", RecId);
        IF ReordLink.FINDSET() THEN
            REPEAT
                Ret[i] := ReordLink.URL1;
                i += 1;
            UNTIL ReordLink.NEXT() = 0
        ELSE
            Ret[i] := '#EOF';
    end;


    procedure DelLinks(TableID: Integer; "Key": Text[100]; FileLink: Text[250]) Ret: Boolean
    var
        ReordLink: Record "Record Link";
        //RecRef: RecordRef;
        RecId: RecordID;
    begin
        EVALUATE(RecId, FORMAT(TableID) + ': ' + FORMAT(Key));
        ReordLink.RESET();
        ReordLink.SETRANGE("Record ID", RecId);
        ReordLink.SETRANGE(URL1, FileLink);
        IF ReordLink.FINDFIRST() THEN BEGIN
            ReordLink.DELETE();
            Ret := TRUE;
        END;
    end;


    // procedure GetFaculty(Course: Code[20];Semester: Code[10];Section: Code[10];Subject: Code[20];var FacultyName: Text[100]) Ret: Code[20]
    // var
    //     FacultySubject: Record Table71515;
    // begin
    //     EduSetup.GET;
    //     FacultySubject.RESET;
    //     FacultySubject.SETCURRENTKEY("Course Code","Semester Code","Section Code","Subject Code","Academic Year");
    //     FacultySubject.SETRANGE("Course Code",Course);
    //     FacultySubject.SETRANGE("Semester Code",Semester);
    //     FacultySubject.SETRANGE("Section Code",Section);
    //     FacultySubject.SETRANGE("Subject Code",Subject);
    //     FacultySubject.SETRANGE("Academic Year",EduSetup."Academic Year");
    //     IF FacultySubject.FINDFIRST THEN BEGIN
    //       Ret := FacultySubject."Faculty Code";
    //       FacultyName := FacultySubject."Faculty Name";
    //     END;
    // end;


    procedure GetSeverity() Ret: array[50] of Text[100]
    var
        SeverityRec: Record Severity;
        i: Integer;
    begin
        i := 1;
        IF SeverityRec.FINDSET() THEN
            REPEAT
                Ret[i] := SeverityRec.Code;
                Ret[i] += ',' + SeverityRec.Description;
                i := i + 1;
            UNTIL SeverityRec.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetAction() Ret: array[50] of Text[100]
    var
        ActionTaken: Record "Action Taken";
        i: Integer;
    begin

        i := 1;
        IF ActionTaken.FINDSET() THEN
            REPEAT
                Ret[i] := ActionTaken.Code;
                Ret[i] += ',' + ActionTaken.Description;
                i := i + 1;
            UNTIL ActionTaken.NEXT() = 0;
        Ret[i] := '#EOF';

    end;


    procedure GetYearList() Ret: array[6] of Code[10]
    var
        AcademicYear: Record "Academic Year";
        i: Integer;
    begin
        AcademicYear.ASCENDING(FALSE);
        i := 1;
        IF AcademicYear.FINDFIRST() THEN
            REPEAT
                Ret[i] := AcademicYear.Code;
                i := i + 1;
            UNTIL AcademicYear.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure GetMaxMark(Class: Code[20]; Curriculum: Code[20]; AcademicYear: Code[10]; Subject: Code[20]) Ret: Decimal
    var
        ClassSubjects: Record "Class Subjects";
    begin
        ClassSubjects.RESET();
        ClassSubjects.SETCURRENTKEY(Class, Curriculum, "Academic Year", Subject);
        ClassSubjects.SETRANGE(Class, Class);
        ClassSubjects.SETRANGE(Curriculum, Curriculum);
        ClassSubjects.SETRANGE("Academic Year", AcademicYear);
        ClassSubjects.SETRANGE(Subject, Subject);
        IF ClassSubjects.FINDFIRST() THEN
            EXIT(ClassSubjects."Maximum Mark");
    end;

    procedure GetStudDivision() Ret: array[100] of Code[70]
    var
        StudentDivision: Record "Student Division";
        i: Integer;
    begin

        i := 1;
        IF StudentDivision.FINDSET() THEN
            REPEAT
                Ret[i] := StudentDivision.Code;
                Ret[i] += ',' + StudentDivision.Description;
                i := i + 1;
            UNTIL StudentDivision.NEXT() = 0;
        Ret[i] := '#EOF';

    end;


    procedure CheckClassTeacher(EmpCode: Code[20]) Emp: Code[20]
    var
        ClassSec: Record "Class Section";
    begin
        CLEAR(Emp);
        EduSetup.GET();
        ClassSec.RESET();
        ClassSec.SETRANGE(ClassSec."Academic Year", EduSetup."Academic Year");
        ClassSec.SETRANGE(ClassSec."Class Teacher", EmpCode);
        IF ClassSec.FINDFIRST() THEN BEGIN
            Emp := ClassSec."Class Code";
            EXIT(Emp);
        END ELSE BEGIN
            Emp := '#EOF';
            EXIT(Emp);
        END
    end;


    procedure GetUnit() Ret: array[100] of Text[100]
    var
        "Unit Master": Record "Unit Master";
        i: Integer;
    begin

        i := 1;
        IF "Unit Master".FINDSET() THEN
            REPEAT
                Ret[i] := "Unit Master".Code;
                Ret[i] += ',' + "Unit Master".Description;
                i := i + 1;
            UNTIL "Unit Master".NEXT() = 0;
        Ret[i] := '#EOF';

    end;


    procedure ChangePassword(UserSession: Code[20]; OldPwd: Text[30]; NewPwd: Text[30]) Flag: Boolean
    var
        Portalrec: Record "Portal Users";
    begin
        Flag := FALSE;
        Portalrec.RESET();
        IF Portalrec.GET(UserSession) THEN BEGIN
            IF Portalrec.Password = OldPwd THEN BEGIN
                Portalrec.Password := NewPwd;
                IF Portalrec.MODIFY() THEN BEGIN
                    Flag := TRUE;
                    EXIT(Flag);
                END ELSE
                    EXIT(Flag);
            END ELSE
                EXIT(Flag);
        END ELSE
            EXIT(Flag);
    end;


    procedure SuperMark(SuperCode: Code[20]) Ret: Boolean
    var
        AcaSetup: Record "Academics Setup";
    begin
        AcaSetup.RESET();
        IF AcaSetup.GET() THEN BEGIN
            IF AcaSetup."Mark Super User" = SuperCode THEN BEGIN
                Ret := TRUE;
                EXIT(Ret)
            END ELSE
                EXIT(Ret);
        END ELSE
            EXIT(Ret);
    end;


    procedure GetClassCode() Ret: array[100] of Text[100]
    var
        ClassSection: Record "Class Section";
        i: Integer;
    begin

        i := 1;
        IF ClassSection.FINDSET() THEN
            REPEAT
                Ret[i] := ClassSection."Class Code";
                Ret[i] += ',' + ClassSection."Class Code";
                //  Ret[i] += ',' + ClassSection.Section;
                i := i + 1;
            UNTIL ClassSection.NEXT() = 0;
        Ret[i] := '#EOF';

    end;

    procedure GetClassSectionAscTT() Ret: array[100] of Text[100]
    var
        ClassSection: Record "Class Section";
        i: Integer;
    begin

        i := 1;
        EduSetup.GET();
        ClassSection.RESET();
        ClassSection.SETRANGE(ClassSection."Academic Year", EduSetup."Academic Year");
        IF ClassSection.FINDSET() THEN
            REPEAT
                Ret[i] := ClassSection."Class Code";
                Ret[i] += ',' + ClassSection.Class;
                Ret[i] += ',' + ClassSection.Section;
                i := i + 1;
            UNTIL ClassSection.NEXT() = 0;
        Ret[i] := '#EOF';


    end;


    procedure GetPassMark(Class: Code[20]; Curriculum: Code[20]; AcademicYear: Code[10]; Subject: Code[20]) Ret: Decimal
    var
        ClassSubjects: Record "Class Subjects";
    begin
        ClassSubjects.RESET();
        ClassSubjects.SETCURRENTKEY(Class, Curriculum, "Academic Year", Subject);
        ClassSubjects.SETRANGE(Class, Class);
        ClassSubjects.SETRANGE(Curriculum, Curriculum);
        ClassSubjects.SETRANGE("Academic Year", AcademicYear);
        ClassSubjects.SETRANGE(Subject, Subject);
        IF ClassSubjects.FINDFIRST() THEN
            EXIT(ClassSubjects."Pass Mark");
    end;


    procedure GetEmpAscTT() Ret: array[500] of Text[100]
    var
        Emp: Record "Employee Alll";
        i: Integer;
    begin

        i := 1;
        EduSetup.GET();
        Emp.RESET();
        //Emp.SETRANGE(Emp.Status,Emp.Status::Active);
        Emp.SETFILTER(Emp."Employee Category", '%1|%2',
                      Emp."Employee Category"::"Staff Permanent", Emp."Employee Category"::"Staff Temporary");
        IF Emp.FINDSET() THEN
            REPEAT
                Ret[i] := Emp."Employee No.";
                Ret[i] += ',' + Emp.Name;
                // Ret[i] += ',' +Emp."Last Name";
                i := i + 1;
            UNTIL Emp.NEXT() = 0;
        Ret[i] := '#EOF';

    end;


    procedure GetEvents() Ret: array[100] of Text[100]
    var
        EventMaster: Record "Event Master";
        i: Integer;
    begin
        i := 1;
        IF EventMaster.FINDSET() THEN
            REPEAT
                Ret[i] := EventMaster.Code;
                Ret[i] += ',' + EventMaster.Description;
                Ret[i] += ',' + FORMAT(EventMaster.IsSportsAndGames);
                i := i + 1;
            UNTIL EventMaster.NEXT() = 0;
        Ret[i] := '#EOF';
    end;


    procedure CheckStateName(StateName: Text[50]) StateCode: Text[10]
    begin
    end;


    procedure CreatePayment(StudentNo: Code[20]; Amt: Decimal; PayRef: Text[30]; Postingdate: Date) DocNo: Code[20]
    var
        GenJnlLine: Record "Gen. Journal Line";
        FeeSetup: Record "Fee Setup";
        GenJnlBatch: Record "Gen. Journal Batch";
        NoSeriesMgt: Codeunit "No. Series";
        LineNo: Integer;
    begin
        FeeSetup.GET();
        GenJnlLine.RESET();
        GenJnlLine.SETRANGE("Journal Template Name", FeeSetup."Fee Receipt Template");
        GenJnlLine.SETRANGE("Journal Batch Name", FeeSetup."Fee Receipt Batch");
        IF GenJnlLine.FINDLAST() THEN
            LineNo := GenJnlLine."Line No.";

        GenJnlBatch.GET(FeeSetup."Fee Receipt Template", FeeSetup."Fee Receipt Batch");

        GenJnlLine.INIT();
        GenJnlLine."Journal Template Name" := FeeSetup."Fee Receipt Template";
        GenJnlLine."Journal Batch Name" := FeeSetup."Fee Receipt Batch";
        GenJnlLine."Line No." := LineNo + 10000;
        GenJnlLine."Posting Date" := Postingdate;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", GenJnlLine."Posting Date", TRUE);
        GenJnlLine."Cheque No." := PayRef;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine.VALIDATE("Account No.", StudentNo);
        GenJnlLine.VALIDATE(Amount, -Amt);
        GenJnlLine."Bal. Account Type" := GenJnlBatch."Bal. Account Type";
        GenJnlLine.VALIDATE("Bal. Account No.", GenJnlBatch."Bal. Account No.");
        GenJnlLine.INSERT();
        EXIT(GenJnlLine."Document No.");
    end;


    procedure GetCoCurricularActivities() Ret: array[100] of Text[150]
    var
        CoCurricularActivities: Record "Co-Curricular Activities";
        i: Integer;
    begin
        // Co-curricular activities list by Sameer
        i := 1;
        IF CoCurricularActivities.FINDSET() THEN
            REPEAT
                Ret[i] := CoCurricularActivities.Code;
                Ret[i] += ',' + CoCurricularActivities.Description;
                i := i + 1;
            UNTIL CoCurricularActivities.NEXT() = 0;
        Ret[i] := '#EOF';
    end;
}

