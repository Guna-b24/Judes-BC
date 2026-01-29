table 71052 "Marks Header"
{
    //   No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    //   01  30/09/09   KATHIR   OnInsert()                  Code added to generate Number Series
    //   02  30/09/09   KATHIR   OnInsert()                  Code added to get Current Acadmemic Year
    //   03  30/09/09   KATHIR   No. - OnValidate()          Code added to generate Number Series
    //   04  30/09/09   KATHIR   Subject - OnValidate()      Code added to check Current Combination of class & Section already entered
    //   05  30/09/09   KATHIR   Pass Mark - OnValidate()    Code added to restrict pass mark with Max mark
    //   06  30/09/09   KATHIR   Subject - OnValidate()      Code added to get Subject Description
    //   07  30/09/09   KATHIR   AssistEdit()                Code added to generate Number Series
    //   08  01/10/09   KATHIR   OnInsert()                  Code added to Insert Current UserID
    //   09  01/10/09   KATHIR   Subject - OnValidate()      Code added to get Max mark and pass mark from class subjects
    //   10  01/10/09   KATHIR   Exam Type - OnValidate()    Code added to get exam type's description
    //   11  11/10/09   KATHIR   Teacher - OnValidate()      Code added to get teacher Name
    //   12  23/11/09   VIGNESH  Class - OnValidate()        Code added to get the Class Section & Curriculum
    //   13  23/11/09   VIGNESH  Class - OnLookup()          Code added to get the Class Section & Curriculum
    //   14  23/11/09   VIGNESH  Curriculum - OnValidate()   Code added to get the Class Section & Curriculum
    //   15  23/11/09   VIGNESH  Curriculum - OnLookup()     Code added to get the Class Section & Curriculum
    //   16  23/11/09   VIGNESH  Section - OnValidate()      Code added to get the Class Section & Curriculum
    //   17  23/11/09   VIGNESH  Section - OnLookup()        Code added to get the Class Section & Curriculum
    //   18  25/11/09   VIGNESH  Subject - OnValidate()      SetCurrent key Modified based on section

    Caption = 'Marks Header';
    LookupPageID = 71055;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                // Start 03.KATHIR
                if "No." <> xRec."No." then begin
                    AcademicsSetup.Get;
                    NoSeriesMgt.TestManual(AcademicsSetup."Marks No.");
                    "No. Series" := '';
                end;
                // Stop 03.KATHIR
            end;
        }
        field(2; Class; Code[20])
        {
            Caption = 'Class';
            Editable = true;
        }
        field(3; Section; Code[20])
        {
            Caption = 'Section';
            Editable = true;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Editable = true;
        }
        field(5; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            Editable = true;
        }
        field(7; "Max Mark"; Integer)
        {
            BlankZero = true;
            Caption = 'Max Mark';
            Editable = true;
        }
        field(8; "Pass Mark"; Integer)
        {
            BlankZero = true;
            Caption = 'Pass Mark';
            Editable = true;

            trigger OnValidate()
            begin
                // Start 05.KATHIR
                if "Pass Mark" >= "Max Mark" then
                    Error(Text001);
                // Stop 05.KATHIR
            end;
        }
        field(10; Subject; Code[20])
        {
            Caption = 'Subject';

            trigger OnLookup()
            begin
                FacultySubject.Reset;
                //Faculty Code,Class,Curriculum,Section Code,Subject Code,Academic Year
                FacultySubject.SetCurrentKey("Faculty Code", Class, "Academic Year");
                FacultySubject.SetRange(FacultySubject."Faculty Code", Teacher);
                FacultySubject.SetRange(FacultySubject.Class, Class);
                FacultySubject.SetRange(FacultySubject."Academic Year", "Academic Year");
                if PAGE.RunModal(0, FacultySubject) = ACTION::LookupOK then begin
                    Subject := FacultySubject."Subject Code";
                end;
            end;

            trigger OnValidate()
            begin
                // Start 06.KATHIR
                TestField(Class);
                TestField(Section);
                TestField("Academic Year");
                TestField(Curriculum);
                TestField("Exam Type");

                if RecSubject.Get(Subject) then
                    "Subject Description" := RecSubject.Description
                else
                    "Subject Description" := '';
                // Stop 06.KATHIR

                // Start 09.KATHIR
                ClassSubjects.Reset;
                // Start 18.VIGNESH
                //ClassSubjects.SETCURRENTKEY("Class Code",Section,Curriculum,"Academic Year",Subject);
                ClassSubjects.SetCurrentKey(Class, Curriculum, "Academic Year", Subject);
                // Stop 18.VIGNESH
                ClassSubjects.SetRange(Class, Class);
                ClassSubjects.SetRange(Curriculum, Curriculum);
                ClassSubjects.SetRange("Academic Year", "Academic Year");
                ClassSubjects.SetRange(Subject, Subject);
                if ClassSubjects.FindFirst then begin
                    "Max Mark" := ClassSubjects."Maximum Mark";
                    "Pass Mark" := ClassSubjects."Pass Mark";
                end else begin
                    "Max Mark" := 0;
                    "Pass Mark" := 0;
                end;
                // Stop 09.KATHIR
                //Start 04.KATHIR
                MarksHeader.Reset;
                MarksHeader.SetCurrentKey(Class, Section, Curriculum, "Academic Year", "Exam Type", Subject);
                MarksHeader.SetRange(Class, Class);
                MarksHeader.SetRange(Section, Section);
                MarksHeader.SetRange(Curriculum, Curriculum);
                MarksHeader.SetRange("Academic Year", "Academic Year");
                MarksHeader.SetRange("Exam Type", "Exam Type");
                MarksHeader.SetRange(Subject, Subject);
                if MarksHeader.FindFirst then
                    Error(TEXT002);
                //Stop 04.KATHIR
            end;
        }
        field(11; "Subject Description"; Text[50])
        {
            Caption = 'Subject Description';
            Editable = false;
        }
        field(12; "Teacher Name"; Text[50])
        {
            Caption = 'Teacher Name';
        }
        field(13; "Exam Type"; Code[10])
        {
            Caption = 'Exam Type';
            TableRelation = "Exam Code";

            trigger OnValidate()
            begin
                // Start 10.KATHIR
                if ExamCode.Get("Exam Type") then
                    "Exam Description" := ExamCode.Description;
                // Stop 10.KATHIR
            end;
        }
        field(14; "Exam Description"; Text[50])
        {
            Caption = 'Exam Description';
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(16; Teacher; Code[20])
        {
            Caption = 'Teacher';
            TableRelation = "Employee Alll";

            trigger OnValidate()
            begin
                // Start 11.KATHIR
                if Employee.Get(Teacher) then
                    "Teacher Name" := Employee."First Name";
                // Stop 11.KATHIR
            end;
        }
        field(17; "Entry Completed"; Boolean)
        {
            Caption = 'Entry Completed';
        }
        field(18; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";

            trigger OnValidate()
            begin
                if ClassSection.Get("Class Code") then begin
                    Class := ClassSection.Class;
                    Section := ClassSection.Section;
                    Curriculum := ClassSection.Curriculum;
                    "Academic Year" := ClassSection."Academic Year";
                end;
            end;
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Editable = false;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
        field(70122; "Created Date"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Class, Curriculum, "Academic Year", Subject)
        {
        }
        key(Key3; Class, Section, Curriculum, "Academic Year", Subject)
        {
        }
        key(Key4; Class, Section, Curriculum, "Academic Year", "Exam Type", Subject)
        {
        }
        key(Key5; Section)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.KATHIR
        AcademicsSetup.Get;
        if "No. Series" = '' then begin
            AcademicsSetup.TestField("Marks No.");
            NoSeriesMgt.InitSeries(AcademicsSetup."Marks No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        // Stop 01.KATHIR

        // Start 02.KATHIR
        "Academic Year" := Educationvertical.GetAcademicYear;
        // Stop 02.KATHIR

        // Start 08.KATHIR
        "User ID" := UserId;
        // Stop 08.KATHIR
    end;

    var
        Text001: Label 'Pass Mark Cannot be greater than Max Mark';
        RecSubject: Record Subject;
        Educationvertical: Codeunit "Education Vertical";
        AcademicsSetup: Record "Academics Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MarksHeader: Record "Marks Header";
        TEXT002: Label 'Marks Header already Generated for this Class and for this subject';
        ClassSubjects: Record "Class Subjects";
        ExamCode: Record "Exam Code";
        Employee: Record Employee;
        ClassSectionLook: Record "Class Section";
        ClassSection: Record "Class Section";
        FacultySubject: Record "Faculty Subject";

    [Scope('Internal')]
    procedure Assistedit(OldMarks: Record "Marks Header"): Boolean
    begin
        // Start 07.KATHIR
        with OldMarks do begin
            OldMarks := Rec;
            AcademicsSetup.Get;
            AcademicsSetup.TestField("Marks No.");
            if NoSeriesMgt.SelectSeries(AcademicsSetup."Marks No.", OldMarks."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := OldMarks;
                exit(true);
            end;
        end;
        // Stop 07.KATHIR
    end;
}

