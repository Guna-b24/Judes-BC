table 71057 "Student Attendance Line"
{
    //   No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    //   01  05/10/09  KATHIR    OnInsert()                  code added to Insert details from Student attendance header
    //   02  05/10/09  KATHIR    Student No. - OnLookup()   Code added to get Student Nos for Particular class,acad yr,curriculum,section
    //   03  23/11/09   VIGNESH  Class - OnValidate()        Code added to get the Class Section & Curriculum
    //   04  23/11/09   VIGNESH  Class - OnLookup()          Code added to get the Class Section & Curriculum
    //   05  23/11/09   VIGNESH  Curriculum - OnValidate()   Code added to get the Class Section & Curriculum
    //   06  23/11/09   VIGNESH  Curriculum - OnLookup()     Code added to get the Class Section & Curriculum
    //   07  23/11/09   VIGNESH  Section - OnValidate()      Code added to get the Class Section & Curriculum
    //   08  23/11/09   VIGNESH  Section - OnLookup()        Code added to get the Class Section & Curriculum
    //   09  27/11/09   VIGNESH  Student No. - OnLookup()    Code added to validate the student if already there
    //   10  27/11/09   VIGNESH  OnInsert()                  Code added to Validate if Present all is marked
    //   11  27/11/09   VIGNESH  Student No. - OnLookup()    Code added to Validate if Present all is marked

    Caption = 'Student Attendance Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Class; Code[20])
        {
            CalcFormula = Lookup ("Student Attendance Header".Class WHERE ("No." = FIELD ("Document No.")));
            Caption = 'Class';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = Section;
        }
        field(5; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
        }
        field(6; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
        }
        field(8; Hour; Integer)
        {
            Caption = 'Hour';
        }
        field(9; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Student WHERE ("Student Status" = FILTER (Student));

            trigger OnLookup()
            begin
                Student.ClearMarks;
                Student.Reset;
                // Start 02.KATHIR
                if StudentAttendanceHeader.Get("Document No.") then begin
                    // Start 11.VIGNESH
                    if not StudentAttendanceHeader."Present All" then begin
                        // Stop 11.VIGNESH
                        StudentSubjects.Reset;
                        StudentSubjects.SetCurrentKey(Class, Section, Curriculum, "Academic Year");
                        StudentSubjects.SetRange("Class Code", StudentAttendanceHeader."Class Code");
                        StudentSubjects.SetRange(Subject, StudentAttendanceHeader."Subject Code");
                        if StudentSubjects.FindSet then
                            repeat
                                if Student.Get(StudentSubjects."Student No.") then
                                    if Student."Student Status" = Student."Student Status"::Student then
                                        Student.Mark(true);
                            until StudentSubjects.Next = 0;
                        Student.MarkedOnly(true);
                        if PAGE.RunModal(0, Student) = ACTION::LookupOK then begin
                            // Start 09.VIGNESH
                            StudentAttendanceLine.Reset;
                            StudentAttendanceLine.SetRange("Document No.", "Document No.");
                            StudentAttendanceLine.SetRange("Student No.", Student."No.");
                            if StudentAttendanceLine.IsEmpty then begin
                                // Stop 09.VIGNESH
                                "Student No." := Student."No.";
                                "Student Name" := Student.Name;
                                // Start 11.VIGNESH
                            end else begin
                                "Student No." := '';
                                "Student Name" := '';
                                Error(Text001);
                            end;
                            // Stop 11.VIGNESH
                            //END;
                        end;
                    end else
                        Error(Text000);
                end;
                // Stop 02.KATHIR
            end;

            trigger OnValidate()
            begin
                /*
                Student.CLEARMARKS;
                Student.RESET;
                // Start 02.KATHIR
                IF StudentAttendanceHeader.GET("Document No.") THEN BEGIN
                 // Start 11.VIGNESH
                  IF NOT StudentAttendanceHeader."Present All" THEN BEGIN
                 // Stop 11.VIGNESH
                    StudentSubjects.RESET;
                    StudentSubjects.SETCURRENTKEY(Class,Section,Curriculum,"Academic Year");
                    StudentSubjects.SETRANGE("Class Code",StudentAttendanceHeader."Class Code");
                    StudentSubjects.SETRANGE(Subject,StudentAttendanceHeader."Subject Code");
                    StudentSubjects.SETRANGE("Student No.","Student No.");
                    IF StudentSubjects.FINDFIRST THEN BEGIN
                      IF Student.GET(StudentSubjects."Student No.") AND (Student."Student Status" = Student."Student Status"::Student)
                      THEN BEGIN
                        StudentAttendanceLine.RESET;
                        StudentAttendanceLine.SETRANGE("Document No.","Document No.");
                        StudentAttendanceLine.SETRANGE("Student No.",Student."No.");
                        IF StudentAttendanceLine.COUNT = 0 THEN
                          "Student Name" := Student.Name
                        ELSE BEGIN
                          "Student No." := '';
                          "Student Name" := '';
                          ERROR(Text001);
                        END;
                      END ELSE BEGIN
                        "Student No." := '';
                        "Student Name" := '';
                      END;
                    END ELSE BEGIN
                      "Student No." := '';
                      "Student Name" := '';
                      ERROR(Text002,"Student No.",StudentAttendanceHeader.Class);
                    END;
                  END ELSE
                    ERROR(Text000);
                END;
                // Stop 02.KATHIR
                */

            end;
        }
        field(10; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
        }
        field(11; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            OptionCaption = ' ,Present,Absent,On Duty,Leave';
            OptionMembers = " ",Present,Absent,"On Duty",Leave;
        }
        field(12; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(13; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(14; "Class Code"; Code[20])
        {
            CalcFormula = Lookup ("Student Attendance Header"."Class Code" WHERE ("No." = FIELD ("Document No.")));
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
        // Start 01.KATHIR
        if StudentAttendanceHeader.Get("Document No.") then
            // Start 10.VIGNESH
            if not StudentAttendanceHeader."Present All" then begin
                // Stop 10.VIGNESH
                Class := StudentAttendanceHeader.Class;
                Section := StudentAttendanceHeader.Section;
                "Subject Code" := StudentAttendanceHeader."Subject Code";
                Date := StudentAttendanceHeader.Date;
                Hour := StudentAttendanceHeader.Hour;
                "Academic Year" := StudentAttendanceHeader."Academic Year";
                Curriculum := StudentAttendanceHeader.Curriculum;
                // Start 10.VIGNESH
            end else
                Error(Text000);
        // Stop 10.VIGNESH
        // Stop 01.KATHIR
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

