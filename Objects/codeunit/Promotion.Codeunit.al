codeunit 71042 Promotion
{
    //   No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    //   01  08/10/09  KATHIR   Class Promotion()          Code added for Class Promotion
    //   02  23/11/09  VIGNESH  Class Promotion()          Section Feild is removed in parameters
    //   03  23/11/09  VIGNESH  Class Promotion()          filter Section for class card is removed
    //   04  23/11/09  VIGNESH  Class Promotion()          Filed removed in Class Card Set current field
    //   05  23/11/09  VIGNESH  Class Promotion()          filter Section for Promotion suggestion is removed
    //   06  23/11/09  VIGNESH  Class Promotion()          Filed removed in Class Card Set current field
    //   07  23/11/09  VIGNESH  Class Promotion()          filter Section for class card is removed


    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'Please Set Next Academic Year';
        Text001: Label 'Promotion already done for this class';
        Text002: Label 'Please Generate Promotion Suggest';
        Text003: Label 'Promotion done';
        Text004: Label 'Students Marks Is not generated for Exam Code %1';
        Text005: Label 'Please Enter Promotion Percentage';
        Text006: Label 'Please select the Promotional Weightage for Class %1, Curriculum %2';
        Text007: Label 'Overal Promotional Weightage should be 100';
        Text008: Label 'No promoted Class is Found, do you want to Send this Student to Alumni';
        Text009: Label 'Do you want to update the Student Promotion';

    [Scope('Internal')]
    procedure "Class Promotion"(ClassCode: Code[20])
    var
        PromotionHistory: Record "Promotion History";
        PromotionSuggestion: Record "Promotion Suggestion";
        Student: Record Student;
        ClassCard: Record "Class Card";
        ClassSection: Record "Class Section";
        PromotedClass: Code[10];
        ClassCard1: Record "Class Card";
        AcademicYear1: Record "Academic Year";
        ClassSubjects: Record "Class Subjects";
        ClassSubjects1: Record "Class Subjects";
        ClassSectionSubjects: Record "Class Section Subjects";
        ClassSectionSubjects1: Record "Class Section Subjects";
        EduSetup: Record "Education Setup";
    begin
        // Start 08.VIGNESH
        //ClassSection.GET(ClassCode);

        ClassSection.Reset;
        ClassSection.SetRange(ClassSection."Class Code", ClassCode);
        if ClassSection.FindFirst then;


        if ClassSection.Promoted then
            Error(Text001);

        if EduSetup.Get then
            EduSetup.TestField("Academic Year");

        PromotedClass := '';
        ClassCard.Reset;
        ClassCard.SetCurrentKey(Sequence);
        ClassCard.SetRange(Class, ClassSection.Class);
        ClassCard.SetRange(Curriculum, ClassSection.Curriculum);
        ClassCard.SetRange("Academic Year", ClassSection."Academic Year");
        if ClassCard.FindSet then begin
            ClassCard1.Reset;
            ClassCard1.SetCurrentKey(Sequence);
            ClassCard1.SetRange(Sequence, ClassCard.Sequence + 1);
            //  ClassCard1.SETRANGE(Curriculum,ClassSection.Curriculum);
            if ClassCard1.FindFirst then
                PromotedClass := ClassCard1.Class
            else
                if not Confirm(Text008, false) then
                    exit;
        end;

        //MESSAGE(EduSetup."Academic Year");
        //MESSAGE(PromotedClass);

        PromotionSuggestion.Reset;
        PromotionSuggestion.SetRange("Class Code", ClassCode);
        //PromotionSuggestion.SETFILTER(PromotionSuggestion.Result,'<>%1',PromotionSuggestion.Result::Withheld);
        if PromotionSuggestion.FindSet then
            repeat
                Student.Get(PromotionSuggestion."Student No.");
                //   MESSAGE(Student."No.");
                //   MESSAGE('%1',PromotionSuggestion.Result);
                if PromotionSuggestion.Result = PromotionSuggestion.Result::Withheld then
                    Student."Academic Year" := EduSetup."Academic Year"
                else begin
                    PromotionHistory.Init;
                    PromotionHistory.TransferFields(PromotionSuggestion);
                    PromotionHistory."Promoted Academic Year" := EduSetup."Academic Year";
                    if PromotedClass <> '' then begin
                        if PromotionSuggestion.Result = PromotionSuggestion.Result::Promoted then
                            PromotionHistory."Promoted Class" := PromotedClass
                        else
                            if PromotionSuggestion.Result = PromotionSuggestion.Result::Detained then
                                PromotionHistory."Promoted Class" := PromotionSuggestion.Class;
                        PromotionHistory."Promoted Academic Year" := EduSetup."Academic Year";
                    end;
                    PromotionHistory.Insert;

                    if PromotedClass <> '' then begin
                        Student.Class := PromotionHistory."Promoted Class";
                        Student."Previous Class" := PromotionSuggestion.Class;
                        Student."Academic Year" := EduSetup."Academic Year";
                        Student."New Student" := false;
                    end else
                        Student."Student Status" := Student."Student Status"::Alumni;
                    Student."Class Code" :=
                      PromotionHistory."Promoted Class" + '-' + ClassSection.Section + '-' + ClassSection.Curriculum +
                      '-' + EduSetup."Academic Year";
                    //   MESSAGE(Student."Class Code");
                end;
                Student.Modify;

            until PromotionSuggestion.Next = 0;
        //ERROR('hi');
        ClassSection.Promoted := true;
        ClassSection.Modify;
        if PromotedClass <> '' then begin
            //IF NOT ClassSection.GET(PromotedClass + '-' + PromotionSuggestion.Section + '-' + PromotionSuggestion.Curriculum
            //    + '-' + EduSetup."Academic Year")
            if not ClassSection.Get(PromotedClass + '-' + PromotionSuggestion.Section + '-' + PromotionSuggestion.Curriculum
                + '-' + EduSetup."Academic Year", PromotedClass)
            then begin
                ClassSection.Init;
                ClassSection.Class := PromotedClass;
                ClassSection.Section := PromotionSuggestion.Section;
                ClassSection.Curriculum := PromotionSuggestion.Curriculum;
                ClassSection."Academic Year" := EduSetup."Academic Year";
                ClassSection."Class Code" := PromotedClass + '-' + PromotionSuggestion.Section + '-' + PromotionSuggestion.Curriculum
                   + '-' + EduSetup."Academic Year";

                if ClassSection.Insert then;
            end;
            ClassSubjects.Reset;
            ClassSubjects.SetRange(Class, PromotedClass);
            ClassSubjects.SetRange(Curriculum, PromotionSuggestion.Curriculum);
            ClassSubjects.SetRange("Academic Year", EduSetup."Academic Year");
            if ClassSubjects.IsEmpty then begin
                ClassSubjects.Reset;
                ClassSubjects.SetRange(Class, PromotedClass);
                ClassSubjects.SetRange(Curriculum, PromotionSuggestion.Curriculum);
                ClassSubjects.SetRange("Academic Year", PromotionSuggestion."Academic Year");
                if ClassSubjects.FindSet then
                    repeat
                        ClassSubjects1.Init;
                        ClassSubjects1.TransferFields(ClassSubjects);
                        ClassSubjects1."Academic Year" := EduSetup."Academic Year";
                        ClassSubjects1.Insert;
                    until ClassSubjects.Next = 0;
            end;

            ClassSectionSubjects.Reset;
            ClassSectionSubjects.SetRange("Class Code", ClassSection."Class Code");
            if ClassSectionSubjects.IsEmpty then begin
                ClassSectionSubjects.Reset;
                ClassSectionSubjects.SetRange(Class, PromotedClass);
                ClassSectionSubjects.SetRange(Section, PromotionSuggestion.Section);
                ClassSectionSubjects.SetRange(Curriculum, PromotionSuggestion.Curriculum);
                ClassSectionSubjects.SetRange("Academic Year", PromotionSuggestion."Academic Year");
                if ClassSectionSubjects.FindSet then
                    repeat
                        ClassSectionSubjects1.Init;
                        ClassSectionSubjects1.TransferFields(ClassSectionSubjects);
                        ClassSectionSubjects1."Academic Year" := EduSetup."Academic Year";
                        ClassSectionSubjects1."Class Code" := ClassSection."Class Code";
                        if ClassSectionSubjects1.Insert then;
                    until ClassSectionSubjects.Next = 0;
            end;
        end;
        Message(Text003);
        // Stop 08.VIGNESH
    end;

    [Scope('Internal')]
    procedure ClassPromotionSuggest(ClassCode: Code[20])
    var
        PromotionWeightage: Record "Promotion Weightage";
        MarksLine: Record "Marks Line";
        PromotionSuggestion: Record "Promotion Suggestion";
        Student: Record Student;
        ClassSection: Record "Class Section";
        TotalmaxMark: Decimal;
        TotalMarksObtained: Decimal;
        TotalPromotionalMarks: Decimal;
        StudentMarkHeader: Record "Student Mark Header";
    begin
        // Start 09.VIGNESH
        //ClassSection.GET(ClassCode);
        ClassSection.Reset;
        ClassSection.SetRange(ClassSection."Class Code", ClassCode);
        if ClassSection.FindFirst then;

        if ClassSection.Promoted then
            Error(Text001);

        PromotionSuggestion.Reset;
        PromotionSuggestion.SetRange("Class Code", ClassCode);
        if PromotionSuggestion.FindSet then
            if Confirm(Text009, false) then
                PromotionSuggestion.DeleteAll;

        if ClassSection."Promotion Percentage" = 0 then
            Error(Text005);

        PromotionWeightage.Reset;
        PromotionWeightage.SetCurrentKey("Class Code", "Curriculum Code", "Academic Year Code", "Exam Type Code");
        PromotionWeightage.SetRange("Class Code", ClassSection.Class);
        PromotionWeightage.SetRange("Curriculum Code", ClassSection.Curriculum);
        PromotionWeightage.SetRange("Academic Year Code", ClassSection."Academic Year");
        if PromotionWeightage.IsEmpty then
            Error(Text006, ClassSection.Class, ClassSection.Curriculum)
        else
            if PromotionWeightage.FindFirst then begin
                PromotionWeightage.CalcSums(Weightage);
                if PromotionWeightage.Weightage <> 100 then
                    Error(Text007);
            end;

        Student.Reset;
        Student.SetRange("Class Code", ClassCode);
        Student.SetRange("Student Status", Student."Student Status"::Student);
        if Student.FindSet then
            repeat
                TotalPromotionalMarks := 0;
                PromotionWeightage.Reset;
                PromotionWeightage.SetCurrentKey("Class Code", "Curriculum Code", "Academic Year Code", "Exam Type Code");
                PromotionWeightage.SetRange("Class Code", Student.Class);
                PromotionWeightage.SetRange("Curriculum Code", Student.Curriculum);
                PromotionWeightage.SetRange("Academic Year Code", Student."Academic Year");
                if PromotionWeightage.FindSet then
                    repeat
                        StudentMarkHeader.Reset;
                        StudentMarkHeader.SetRange("Class Code", ClassCode);
                        StudentMarkHeader.SetRange("Student No.", Student."No.");
                        StudentMarkHeader.SetRange("Exam Type", PromotionWeightage."Exam Type Code");
                        if StudentMarkHeader.FindFirst then
                            if StudentMarkHeader.Average <> 0 then
                                TotalPromotionalMarks += (StudentMarkHeader.Average * 100) / PromotionWeightage.Weightage;
                    until PromotionWeightage.Next = 0;

                PromotionSuggestion.Init;
                PromotionSuggestion."Student No." := Student."No.";
                PromotionSuggestion.Class := Student.Class;
                PromotionSuggestion.Section := Student.Section;
                PromotionSuggestion.Curriculum := Student.Curriculum;
                PromotionSuggestion."Pass %" := ClassSection."Promotion Percentage";
                PromotionSuggestion."Marks Obtained" := TotalPromotionalMarks;
                if TotalPromotionalMarks >= ClassSection."Promotion Percentage" then
                    PromotionSuggestion.Result := PromotionSuggestion.Result::Promoted
                else
                    PromotionSuggestion.Result := PromotionSuggestion.Result::Detained;
                PromotionSuggestion."Student Name" := Student.Name;
                PromotionSuggestion."Academic Year" := Student."Academic Year";
                PromotionSuggestion."Class Code" := PromotionSuggestion.Class + '-' + PromotionSuggestion.Section + '-' +
                  PromotionSuggestion.Curriculum + '-' + PromotionSuggestion."Academic Year";
                PromotionSuggestion.Insert;
            until Student.Next = 0;
        // Stop 09.VIGNESH
    end;
}

