table 71052 "Marks Header"
{
    Caption = 'Marks Header';
    DataClassification = CustomerContent;
    // LookupPageID = 71055;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique number for the marks header.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AcademicsSetup.Get();
                    NoSeriesMgt.TestManual(AcademicsSetup."Marks No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Class; Code[20])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            Editable = true;
            ToolTip = 'Specifies the class.';
        }
        field(3; Section; Code[20])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            Editable = true;
            ToolTip = 'Specifies the section.';
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = true;
            ToolTip = 'Specifies the academic year.';
        }
        field(5; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            DataClassification = CustomerContent;
            Editable = true;
            ToolTip = 'Specifies the curriculum.';
        }
        field(7; "Max Mark"; Integer)
        {
            Caption = 'Max Mark';
            DataClassification = CustomerContent;
            BlankZero = true;
            Editable = true;
            ToolTip = 'Specifies the maximum mark for the subject.';
        }
        field(8; "Pass Mark"; Integer)
        {
            Caption = 'Pass Mark';
            DataClassification = CustomerContent;
            BlankZero = true;
            Editable = true;
            ToolTip = 'Specifies the minimum mark required to pass.';

            trigger OnValidate()
            begin
                if "Pass Mark" >= "Max Mark" then
                    Error(Text001);

            end;
        }
        field(10; Subject; Code[20])
        {
            Caption = 'Subject';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the subject.';

            trigger OnLookup()
            begin
                FacultySubject.Reset();
                FacultySubject.SetCurrentKey("Faculty Code", Class, "Academic Year");
                FacultySubject.SetRange(FacultySubject."Faculty Code", Teacher);
                FacultySubject.SetRange(FacultySubject.Class, Class);
                FacultySubject.SetRange(FacultySubject."Academic Year", "Academic Year");
                if page.RunModal(72010, FacultySubject) = action::LookupOK then
                    Subject := FacultySubject."Subject Code";
            end;

            trigger OnValidate()
            begin
                TestField(Class);
                TestField(Section);
                TestField("Academic Year");
                TestField(Curriculum);
                TestField("Exam Type");

                if RecSubject.Get(Subject) then
                    "Subject Description" := RecSubject.Description
                else
                    "Subject Description" := '';

                ClassSubjects.Reset();
                ClassSubjects.SetCurrentKey(Class, Curriculum, "Academic Year", Subject);
                ClassSubjects.SetRange(Class, Class);
                ClassSubjects.SetRange(Curriculum, Curriculum);
                ClassSubjects.SetRange("Academic Year", "Academic Year");
                ClassSubjects.SetRange(Subject, Subject);
                if ClassSubjects.FindFirst() then begin
                    "Max Mark" := ClassSubjects."Maximum Mark";
                    "Pass Mark" := ClassSubjects."Pass Mark";
                end else begin
                    "Max Mark" := 0;
                    "Pass Mark" := 0;
                end;

                MarksHeader.Reset();
                MarksHeader.SetCurrentKey(Class, Section, Curriculum, "Academic Year", "Exam Type", Subject);
                MarksHeader.SetRange(Class, Class);
                MarksHeader.SetRange(Section, Section);
                MarksHeader.SetRange(Curriculum, Curriculum);
                MarksHeader.SetRange("Academic Year", "Academic Year");
                MarksHeader.SetRange("Exam Type", "Exam Type");
                MarksHeader.SetRange(Subject, Subject);
                if MarksHeader.FindFirst() then
                    Error(TEXT002);

            end;
        }
        field(11; "Subject Description"; Text[50])
        {
            Caption = 'Subject Description';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Shows the description of the subject.';
        }
        field(12; "Teacher Name"; Text[50])
        {
            Caption = 'Teacher Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the name of the teacher.';
        }
        field(13; "Exam Type"; Code[10])
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            TableRelation = "Exam Code";
            ToolTip = 'Specifies the exam type.';

            trigger OnValidate()
            begin

                if ExamCode.Get("Exam Type") then
                    "Exam Description" := ExamCode.Description;

            end;
        }
        field(14; "Exam Description"; Text[50])
        {
            Caption = 'Exam Description';
            DataClassification = CustomerContent;
            ToolTip = 'Shows the description of the exam type.';
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used to generate the document number.';
        }
        field(16; Teacher; Code[20])
        {
            Caption = 'Teacher';
            DataClassification = CustomerContent;
            TableRelation = "Employee Alll";
            ToolTip = 'Specifies the teacher code.';

            trigger OnValidate()
            begin

                if Employee.Get(Teacher) then
                    "Teacher Name" := Employee."First Name";

            end;
        }
        field(17; "Entry Completed"; Boolean)
        {
            Caption = 'Entry Completed';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the marks entry is completed.';
        }
        field(18; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            DataClassification = CustomerContent;
            TableRelation = "Class Section";
            ToolTip = 'Specifies the class section code.';

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
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier.';
        }
        field(70122; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date and time when the record was created.';
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

        if "No." = '' then begin
            AcademicsSetup.Get();
            AcademicsSetup.TestField("Marks No.");
            "No. Series" := AcademicsSetup."Marks No.";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        end;

        "Academic Year" := Educationvertical.GetAcademicYear();

    end;

    var

        RecSubject: Record Subject;
        AcademicsSetup: Record "Academics Setup";
        MarksHeader: Record "Marks Header";
        ClassSubjects: Record "Class Subjects";
        ExamCode: Record "Exam Code";
        Employee: Record Employee;
        ClassSection: Record "Class Section";
        FacultySubject: Record "Faculty Subject";
        Educationvertical: Codeunit "Education Vertical";
        NoSeriesMgt: Codeunit "No. Series";


        TEXT002: Label 'Marks Header already Generated for this Class and for this subject';
        Text001: Label 'Pass Mark Cannot be greater than Max Mark';


    procedure Assistedit(OldMarks: Record "Marks Header"): Boolean
    begin

        OldMarks := Rec;
        AcademicsSetup.Get();
        AcademicsSetup.TestField("Marks No.");
        if NoSeriesMgt.LookupRelatedNoSeries(AcademicsSetup."Marks No.", OldMarks."No. Series", "No. Series") then begin
            OldMarks."No." := NoSeriesMgt.GetNextNo(OldMarks."No. Series");
            Rec := OldMarks;
            exit(true);
        end;
    end;

}

