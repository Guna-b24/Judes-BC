table 71056 "Student Attendance Header"
{
    Caption = 'Student Attendance Header';
    DataClassification = CustomerContent;
    LookupPageID = "Student Attendance List";
    DrillDownPageId = "Student Attendance List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the unique number of the attendance document.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AcademicsSetup.Get();
                    NoSeriesMgt.TestManual(AcademicsSetup."Attendance No.");
                    "No.Series" := '';
                end;
            end;
        }
        field(2; Class; Code[20])
        {
            Caption = 'Class';
            ToolTip = 'Specifies the class for which attendance is recorded.';
            DataClassification = CustomerContent;
        }

        field(3; Section; Code[20])
        {
            Caption = 'Section';
            ToolTip = 'Specifies the section of the class.';
            DataClassification = CustomerContent;
        }

        field(4; Date; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the date on which attendance is taken.';
            DataClassification = CustomerContent;
        }
        field(5; Hour; Integer)
        {
            Caption = 'Hour';
            BlankZero = true;
            ToolTip = 'Specifies the hour for which attendance is recorded.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                StudentAttendanceHeader.Reset();
                StudentAttendanceHeader.SetCurrentKey(Class, Section, Curriculum, "Academic Year", "Subject Code", Date, Hour);
                StudentAttendanceHeader.SetRange(Class, Class);
                StudentAttendanceHeader.SetRange(Section, Section);
                StudentAttendanceHeader.SetRange(Curriculum, Curriculum);
                StudentAttendanceHeader.SetRange("Academic Year", "Academic Year");
                StudentAttendanceHeader.SetRange(Date, Date);
                StudentAttendanceHeader.SetRange(Hour, Hour);
                if StudentAttendanceHeader.FindFirst() then
                    Error(Text002);
            end;
        }
        field(6; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            TableRelation = Employee;
            ToolTip = 'Specifies the staff member who handled the class.';
            DataClassification = EndUserIdentifiableInformation;

            trigger OnValidate()
            begin
                if Employee.Get("Staff Code") then
                    "Staff Name" := Employee."First Name"
                else
                    "Staff Name" := '';
            end;
        }
        field(7; "Present All"; Boolean)
        {
            Caption = 'Present All';
            ToolTip = 'Specifies whether all students are marked present.';
            DataClassification = CustomerContent;
        }

        field(8; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = false;
            ToolTip = 'Specifies the academic year.';
            DataClassification = CustomerContent;
        }
        field(9; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            ToolTip = 'Specifies the curriculum associated with the class.';
            DataClassification = CustomerContent;
        }

        field(10; "No.Series"; Code[20])
        {
            Caption = 'No. Series';
            ToolTip = 'Specifies the number series used to assign document numbers.';
            DataClassification = SystemMetadata;
        }
        field(11; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;
            ToolTip = 'Specifies the subject for which attendance is taken.';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                ClassSubjects.Reset();
                ClassSubjects.SetRange(Class, Class);
                ClassSubjects.SetRange(Curriculum, Curriculum);
                ClassSubjects.SetRange("Academic Year", "Academic Year");
                if PAGE.RunModal(0, ClassSubjects) = ACTION::LookupOK then
                    "Subject Code" := ClassSubjects.Subject
            end;
        }
        field(13; "Staff Name"; Text[50])
        {
            Caption = 'Staff Name';
            Editable = false;
            ToolTip = 'Displays the name of the staff member.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(14; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";
            ToolTip = 'Specifies the class section combination.';
            DataClassification = CustomerContent;
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
            Caption = 'Session';
            OptionCaption = ' ,FN,AN';
            OptionMembers = " ",FN,AN;
            ToolTip = 'Specifies whether attendance is for Forenoon (FN) or Afternoon (AN).';
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal identifier for integration purposes.';
            DataClassification = SystemMetadata;
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

        if "No." = '' then begin
            AcademicsSetup.Get();
            AcademicsSetup.TestField("Attendance No.");
            "No.Series" := AcademicsSetup."Attendance No.";
            "No." := NoSeriesMgt.GetNextNo("No.Series");
        end;
        "Academic Year" := EduVertical.GetAcademicYear();
    end;

    var
        AcademicsSetup: Record "Academics Setup";
        StudentAttendanceHeader: Record "Student Attendance Header";
        ClassSubjects: Record "Class Subjects";
        Employee: Record Employee;
        ClassSection: Record "Class Section";
        NoSeriesMgt: Codeunit "No. Series";
        EduVertical: Codeunit "Education Vertical";
        Text000: Label 'Attendence is created for this subject and hour.';
        Text001: Label 'FN/AN is Mandatory';
        Text002: Label 'Attendence is already created for this Class';

    procedure Assistedit(OldAttendance: Record "Student Attendance Header"): Boolean
    begin


        OldAttendance := Rec;
        AcademicsSetup.Get();
        AcademicsSetup.TestField("Attendance No.");
        if NoSeriesMgt.LookupRelatedNoSeries(AcademicsSetup."Attendance No.", OldAttendance."No.Series", "No.Series") then begin
            OldAttendance."No." := NoSeriesMgt.GetNextNo(OldAttendance."No.Series");
            Rec := OldAttendance;
            exit(true);
        end;

    end;
}

