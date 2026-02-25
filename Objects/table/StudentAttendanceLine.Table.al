table 71057 "Student Attendance Line"
{
    Caption = 'Student Attendance Line';
    DataClassification = CustomerContent;
    LookupPageId = "Student Attendance Line List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the attendance document number.';
            DataClassification = CustomerContent;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the line number of the attendance entry.';
            DataClassification = SystemMetadata;
        }
        field(3; Class; Code[20])
        {
            CalcFormula = Lookup("Student Attendance Header".Class WHERE("No." = FIELD("Document No.")));
            Caption = 'Class';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; Section; Code[20])
        {
            Caption = 'Section';
            TableRelation = Section;
            ToolTip = 'Specifies the section of the class.';
            DataClassification = CustomerContent;
        }

        field(5; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
            ToolTip = 'Specifies the curriculum for the student.';
            DataClassification = CustomerContent;
        }

        field(6; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;
            ToolTip = 'Specifies the subject for which attendance is recorded.';
            DataClassification = CustomerContent;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the date of attendance.';
            DataClassification = CustomerContent;
        }

        field(8; Hour; Integer)
        {
            Caption = 'Hour';
            ToolTip = 'Specifies the hour for which attendance is recorded.';
            DataClassification = CustomerContent;
        }

        field(9; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            ToolTip = 'Specifies the unique number of the student.';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = Student WHERE("Student Status" = FILTER(Student));

            trigger OnLookup()
            begin
                Student.ClearMarks();
                Student.Reset();
                if StudentAttendanceHeader.Get("Document No.") then
                    if not StudentAttendanceHeader."Present All" then begin

                        StudentSubjects.Reset();
                        StudentSubjects.SetCurrentKey(Class, Section, Curriculum, "Academic Year");
                        StudentSubjects.SetRange("Class Code", StudentAttendanceHeader."Class Code");
                        StudentSubjects.SetRange(Subject, StudentAttendanceHeader."Subject Code");
                        if StudentSubjects.FindSet() then
                            repeat
                                if Student.Get(StudentSubjects."Student No.") then
                                    if Student."Student Status" = Student."Student Status"::Student then
                                        Student.Mark(true);
                            until StudentSubjects.Next() = 0;
                        Student.MarkedOnly(true);
                        if PAGE.RunModal(0, Student) = ACTION::LookupOK then begin
                            StudentAttendanceLine.Reset();
                            StudentAttendanceLine.SetRange("Document No.", "Document No.");
                            StudentAttendanceLine.SetRange("Student No.", Student."No.");
                            if StudentAttendanceLine.IsEmpty then begin

                                "Student No." := Student."No.";
                                "Student Name" := Student.Name;

                            end else begin
                                "Student No." := '';
                                "Student Name" := '';
                                Error(Text001);
                            end;

                        end;
                    end else
                        Error(Text000);
            end;

        }
        field(10; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            ToolTip = 'Specifies the name of the student.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(11; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            OptionCaption = ' ,Present,Absent,On Duty,Leave';
            OptionMembers = " ",Present,Absent,"On Duty",Leave;
            ToolTip = 'Specifies the attendance status of the student.';
            DataClassification = CustomerContent;
        }
        field(12; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            ToolTip = 'Specifies the academic year.';
            DataClassification = CustomerContent;
        }

        field(13; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies additional details or remarks for the attendance entry.';
            DataClassification = CustomerContent;
        }
        field(14; "Class Code"; Code[20])
        {
            CalcFormula = Lookup("Student Attendance Header"."Class Code" WHERE("No." = FIELD("Document No.")));
            Caption = 'Class Code';
            Editable = false;
            FieldClass = FlowField;
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
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if StudentAttendanceHeader.Get("Document No.") then
            if not StudentAttendanceHeader."Present All" then begin
                Class := StudentAttendanceHeader.Class;
                Section := StudentAttendanceHeader.Section;
                "Subject Code" := StudentAttendanceHeader."Subject Code";
                Date := StudentAttendanceHeader.Date;
                Hour := StudentAttendanceHeader.Hour;
                "Academic Year" := StudentAttendanceHeader."Academic Year";
                Curriculum := StudentAttendanceHeader.Curriculum;
            end else
                Error(Text000);
    end;

    var
        StudentAttendanceHeader: Record "Student Attendance Header";
        Student: Record Student;
        StudentSubjects: Record "Student Subjects";
        ClassSection: Record "Class Section";
        StudentAttendanceLine: Record "Student Attendance Line";
        Text000: Label 'All  is marked present.';
        Text001: Label 'The student is already selected.';
        Text002: Label 'Student %1 does not belong to class %2.';
}

