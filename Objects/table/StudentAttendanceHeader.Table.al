table 71056 "Student Attendance Header"
{
    //   No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    //   01  05/10/09   KATHIR   OnInsert()                  Code added to generate Number Series and Insert Current Academic year
    //   02  05/10/09   KATHIR   No. - OnValidate()          Code added to generate Number Series
    //   03  05/10/09   KATHIR   Subject Code - OnValidate() Code added to look up the subjects for that particular,class,section and Year
    //   04  05/10/09   KATHIR   Assistedit()                Code added to generate Number Series
    //   05  11/10/09   KATHIR   Staff Code - OnValidate()   Code added to get Staff Name
    //   06  15/10/09   KATHIR   Hour - OnValidate()         Code added to check duplication entries
    //   07  19/10/09   VANDHANA OnInsert                    Code to assign User ID.
    //   08  23/11/09   VIGNESH  Class - OnValidate()        Code added to get the Class Section & Curriculum
    //   09  23/11/09   VIGNESH  Class - OnLookup()          Code added to get the Class Section & Curriculum
    //   10  23/11/09   VIGNESH  Curriculum - OnValidate()   Code added to get the Class Section & Curriculum
    //   11  23/11/09   VIGNESH  Curriculum - OnLookup()     Code added to get the Class Section & Curriculum
    //   12  23/11/09   VIGNESH  Section - OnValidate()      Code added to get the Class Section & Curriculum
    //   13  23/11/09   VIGNESH  Section - OnLookup()        Code added to get the Class Section & Curriculum
    //   14  25/11/09   VIGNESH  Subject Code - OnLookup()   Code commente for the section filter
    // 
    // SJ6.01 21/01/18 GB
    //   Enabled Edit property for class, section and curriculum

    Caption = 'Student Attendance Header';
    LookupPageID = 71066;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                // Start 02.KATHIR
                if "No." <> xRec."No." then begin
                    AcademicsSetup.Get;
                    NoSeriesMgt.TestManual(AcademicsSetup."Attendance No.");
                    "No.Series" := '';
                end;
                // Stop 02.KATHIR
            end;
        }
        field(2; Class; Code[20])
        {
            Caption = 'Class';
        }
        field(3; Section; Code[20])
        {
            Caption = 'Section';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; Hour; Integer)
        {
            BlankZero = true;
            Caption = 'Hour';

            trigger OnValidate()
            begin

                // Start 06.KATHIR
                StudentAttendanceHeader.Reset;
                StudentAttendanceHeader.SetCurrentKey(Class, Section, Curriculum, "Academic Year", "Subject Code", Date, Hour);
                StudentAttendanceHeader.SetRange(Class, Class);
                StudentAttendanceHeader.SetRange(Section, Section);
                StudentAttendanceHeader.SetRange(Curriculum, Curriculum);
                StudentAttendanceHeader.SetRange("Academic Year", "Academic Year");
                StudentAttendanceHeader.SetRange(Date, Date);
                StudentAttendanceHeader.SetRange(Hour, Hour);
                if StudentAttendanceHeader.FindFirst then
                    Error(Text002);
                // Start 06.KATHIR
            end;
        }
        field(6; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                // Start 05.KATHIR
                if Employee.Get("Staff Code") then
                    "Staff Name" := Employee."First Name"
                else
                    "Staff Name" := '';
                // Stop 05.KATHIR
            end;
        }
        field(7; "Present All"; Boolean)
        {
            Caption = 'Present All';
        }
        field(8; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = false;
        }
        field(9; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
        }
        field(10; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
        }
        field(11; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;

            trigger OnLookup()
            begin
                // Start 03.KATHIR
                ClassSubjects.Reset;
                ClassSubjects.SetRange(Class, Class);
                ClassSubjects.SetRange(Curriculum, Curriculum);
                ClassSubjects.SetRange("Academic Year", "Academic Year");
                if PAGE.RunModal(0, ClassSubjects) = ACTION::LookupOK then
                    "Subject Code" := ClassSubjects.Subject
                // Stop 03.KATHIR
            end;
        }
        field(13; "Staff Name"; Text[50])
        {
            Caption = 'Staff Name';
            Editable = false;
        }
        field(14; "Class Code"; Code[20])
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
        field(20; "FN/AN"; Option)
        {
            OptionCaption = ' ,FN,AN';
            OptionMembers = " ",FN,AN;

            trigger OnValidate()
            begin
                /*
                IF "FN/AN" = 0 THEN
                  ERROR(Text001);
                
                // Start 10.KATHIR
                StudentAttendanceHeader.RESET;
                StudentAttendanceHeader.SETCURRENTKEY(Class,Section,Curriculum,"Academic Year",Date,"FN/AN");
                StudentAttendanceHeader.SETRANGE(Class,Class);
                StudentAttendanceHeader.SETRANGE(Section,Section);
                StudentAttendanceHeader.SETRANGE(Curriculum,Curriculum);
                StudentAttendanceHeader.SETRANGE("Academic Year","Academic Year");
                StudentAttendanceHeader.SETRANGE(Date,Date);
                StudentAttendanceHeader.SETRANGE("FN/AN","FN/AN");
                IF StudentAttendanceHeader.FINDFIRST THEN
                  ERROR(Text002);
                // Start 10.KATHIR
                  */

            end;
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Class, Section, Curriculum, "Academic Year", "Subject Code", Date, Hour)
        {
        }
        key(Key3; "Class Code", "Subject Code", Date, Hour)
        {
        }
        key(Key4; Class, Section, Curriculum, "Academic Year", Date, "FN/AN")
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
        if "No.Series" = '' then begin
            AcademicsSetup.TestField("Attendance No.");
            NoSeriesMgt.InitSeries(AcademicsSetup."Attendance No.", xRec."No.Series", 0D, "No.", "No.Series");
        end;
        "Academic Year" := EduVertical.GetAcademicYear;
        // Stop 01.KATHIR
        // Start 07. VANDHANA
        "User ID" := UserId;
        // Stop 07. VANDHANA
    end;

    var
        AcademicsSetup: Record "Academics Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EduVertical: Codeunit "Education Vertical";
        StudentAttendanceHeader: Record "Student Attendance Header";
        ClassSubjects: Record "Class Subjects";
        Employee: Record Employee;
        ClassSection: Record "Class Section";
        Text000: Label 'Attendence is created for this subject and hour.';
        Text001: Label 'FN/AN is Mandatory';
        Text002: Label 'Attendence is already created for this Class';

    [Scope('Internal')]
    procedure Assistedit(OldAttendance: Record "Student Attendance Header"): Boolean
    begin
        // Start 04.KATHIR
        with OldAttendance do begin
            OldAttendance := Rec;
            AcademicsSetup.Get;
            AcademicsSetup.TestField("Attendance No.");
            if NoSeriesMgt.SelectSeries(AcademicsSetup."Attendance No.", OldAttendance."No.Series", "No.Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := OldAttendance;
                exit(true);
            end;
        end;
        // Stop 04.KATHIR
    end;
}

