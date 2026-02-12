table 71055 "Student Mark Header"
{
    Caption = 'Student Mark Header';
    DataClassification = CustomerContent;
    // LookupPageID = 71067;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = false;
            TableRelation = Student;
            ToolTip = 'Specifies the student number.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(2; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
            ToolTip = 'Specifies the name of the student.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(3; Class; Code[20])
        {
            Caption = 'Class';
            Editable = false;
            ToolTip = 'Specifies the class of the student.';
            DataClassification = CustomerContent;
        }

        field(4; Section; Code[20])
        {
            Caption = 'Section';
            Editable = false;
            ToolTip = 'Specifies the section of the student.';
            DataClassification = CustomerContent;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Editable = false;
            ToolTip = 'Specifies the academic year.';
            DataClassification = CustomerContent;
        }

        field(6; "Exam Type"; Code[20])
        {
            Caption = 'Exam Type';
            Editable = false;
            TableRelation = "Exam Code";
            ToolTip = 'Specifies the exam type.';
            DataClassification = CustomerContent;
        }

        field(7; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            ToolTip = 'Specifies the curriculum followed by the student.';
            DataClassification = CustomerContent;
        }

        field(8; "Total Marks"; Decimal)
        {
            Caption = 'Total Marks';
            BlankZero = true;
            ToolTip = 'Specifies the total marks obtained.';
            DataClassification = CustomerContent;
        }

        field(9; Average; Decimal)
        {
            Caption = 'Average';
            BlankZero = true;
            ToolTip = 'Specifies the average marks.';
            DataClassification = CustomerContent;
        }
        field(10; Rank; Integer)
        {
            Caption = 'Rank';
            BlankZero = true;
            ToolTip = 'Specifies the rank secured by the student.';
            DataClassification = CustomerContent;
        }

        field(11; Grade; Code[10])
        {
            Caption = 'Grade';
            Editable = false;
            ToolTip = 'Specifies the grade assigned to the student.';
            DataClassification = CustomerContent;
        }

        field(12; "Total No of Subject Failed"; Integer)
        {
            Caption = 'Total No. of Subjects Failed';
            Editable = false;
            ToolTip = 'Specifies the total number of subjects failed.';
            DataClassification = CustomerContent;
        }
        field(13; Failed; Boolean)
        {
            Caption = 'Failed';
            Editable = false;
            ToolTip = 'Specifies whether the student has failed.';
            DataClassification = CustomerContent;
        }

        field(14; Remarks; Text[200])
        {
            Caption = 'Remarks';
            ToolTip = 'Specifies general remarks about the student performance.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(15; Height; Decimal)
        {
            Caption = 'Height';
            BlankZero = true;
            ToolTip = 'Specifies the height of the student.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(16; Weight; Decimal)
        {
            Caption = 'Weight';
            BlankZero = true;
            ToolTip = 'Specifies the weight of the student.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(17; "GPA Grade"; Code[10])
        {
            Caption = 'GPA Grade';
            ToolTip = 'Specifies the GPA grade.';
            DataClassification = CustomerContent;
        }

        field(18; "GPA Points"; Decimal)
        {
            Caption = 'GPA Points';
            ToolTip = 'Specifies the GPA points.';
            DataClassification = CustomerContent;
        }

        field(19; "Percentage Scored"; Decimal)
        {
            Caption = 'Percentage Scored';
            Editable = false;
            ToolTip = 'Specifies the percentage scored by the student.';
            DataClassification = CustomerContent;
        }

        field(20; "Total Marks Conducted"; Decimal)
        {
            Caption = 'Total Marks Conducted';
            ToolTip = 'Specifies the total marks conducted.';
            DataClassification = CustomerContent;
        }
        field(21; "Average Attendance Percent"; Decimal)
        {
            Caption = 'Average Attendance Percent';
            BlankZero = true;
            ToolTip = 'Specifies the average attendance percentage.';
            DataClassification = CustomerContent;
        }

        field(22; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";
            ToolTip = 'Specifies the class section code.';
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
        field(23; "Total No of Subject Absent"; Integer)
        {
            Caption = 'Total No. of Subjects Absent';
            ToolTip = 'Specifies the total number of subjects absent.';
            DataClassification = CustomerContent;
        }

        field(50000; "Principal Comment2"; Text[250])
        {
            Caption = 'Principal Comment 2';
            ToolTip = 'Specifies additional comments from the principal.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(50001; "Class Teacher Comment2"; Text[250])
        {
            Caption = 'Class Teacher Comment 2';
            ToolTip = 'Specifies additional comments from the class teacher.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal identifier for integration.';
            DataClassification = SystemMetadata;
        }

        field(70122; Regularity; Option)
        {
            Caption = 'Regularity';
            OptionCaption = ' ,Very Good,Good,Average,Poor';
            OptionMembers = " ","Very Good",Good,"Average",Poor;
            ToolTip = 'Specifies the regularity assessment.';
            DataClassification = CustomerContent;
        }

        field(70123; Effort; Option)
        {
            Caption = 'Effort';
            OptionCaption = ' ,Very Good,Good,Average,Poor';
            OptionMembers = " ","Very Good",Good,"Average",Poor;
            ToolTip = 'Specifies the effort assessment.';
            DataClassification = CustomerContent;
        }
        field(70124; Discipline; Option)
        {
            Caption = 'Discipline';
            OptionCaption = ' ,Very Good,Good,Average,Poor';
            OptionMembers = " ","Very Good",Good,"Average",Poor;
            ToolTip = 'Specifies the discipline assessment.';
            DataClassification = CustomerContent;
        }

        field(70125; "Etiquette Manners"; Option)
        {
            Caption = 'Etiquette & Manners';
            OptionCaption = ' ,Very Good,Good,Average,Poor';
            OptionMembers = " ","Very Good",Good,"Average",Poor;
            ToolTip = 'Specifies the etiquette and manners assessment.';
            DataClassification = CustomerContent;
        }

        field(70126; "Principal Comment"; Text[200])
        {
            Caption = 'Principal Comment';
            ToolTip = 'Specifies the principal’s remarks.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(70127; "Extra Curr Excellence"; Option)
        {
            Caption = 'Extra Curricular Excellence';
            OptionCaption = ' ,School Level,District Level,State Level';
            OptionMembers = " ","School Level","District Level","State Level";
            ToolTip = 'Specifies the level of extra curricular excellence.';
            DataClassification = CustomerContent;
        }

        field(70128; "Personal Traits"; Option)
        {
            Caption = 'Personal Traits';
            OptionCaption = ' ,Pleasant,Systematic,Smart,A Bit Moody,Temperamental,Sensitive';
            OptionMembers = " ",Pleasant,Systematic,Smart,"A Bit Moody",Temperamental,Sensitive;
            ToolTip = 'Specifies the personal traits assessment.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(70129; "Social Movement"; Option)
        {
            Caption = 'Social Movement';
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
            ToolTip = 'Specifies the social movement grading.';
            DataClassification = CustomerContent;
        }
        field(70130; Hospitability; Option)
        {
            Caption = 'Hospitability';
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
            ToolTip = 'Specifies the hospitability grading.';
            DataClassification = CustomerContent;
        }

        field(70131; Leadership; Option)
        {
            Caption = 'Leadership';
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
            ToolTip = 'Specifies the leadership grading.';
            DataClassification = CustomerContent;
        }

        field(70132; "Class Teacher Comment"; Text[200])
        {
            Caption = 'Class Teacher Comment';
            ToolTip = 'Specifies remarks from the class teacher.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(70133; Description; Text[200])
        {
            Caption = 'Description';
            ToolTip = 'Specifies additional description.';
            DataClassification = CustomerContent;
        }

        field(70134; Published; Boolean)
        {
            Caption = 'Published';
            ToolTip = 'Specifies whether the marks are published to the portal.';
            DataClassification = SystemMetadata;
        }

        field(70135; "Maximum Working Days"; Decimal)
        {
            Caption = 'Maximum Working Days';
            BlankZero = true;
            ToolTip = 'Specifies the maximum working days considered.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Academic Year", "Exam Type")
        {
            Clustered = true;
            SumIndexFields = "GPA Points";
        }
        key(Key2; Class, Section, "Academic Year", Curriculum, "Exam Type", "Student No.")
        {
        }
        key(Key3; "Class Code", "Exam Type", "Average")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ClassSection: Record "Class Section";
}

