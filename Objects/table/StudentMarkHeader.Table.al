table 71055 "Student Mark Header"
{
    // 
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.
    //   02  23/11/09   VIGNESH  Class - OnValidate()                Code added to get the Class Section & Curriculum
    //   03  23/11/09   VIGNESH  Class - OnLookup()                  Code added to get the Class Section & Curriculum
    //   04  23/11/09   VIGNESH  Curriculum - OnValidate()           Code added to get the Class Section & Curriculum
    //   05  23/11/09   VIGNESH  Curriculum - OnLookup()             Code added to get the Class Section & Curriculum
    //   06  23/11/09   VIGNESH  Section - OnValidate()              Code added to get the Class Section & Curriculum
    //   07  23/11/09   VIGNESH  Section - OnLookup()                Code added to get the Class Section & Curriculum
    //   08  13/1/10    KAVITHA                                      Added 2 new fields GPA Points and GPA Grade.

    Caption = 'Student Mark Header';
    LookupPageID = 71067;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = false;
            TableRelation = Student;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(3; Class; Code[20])
        {
            Caption = 'Class';
            Editable = false;
        }
        field(4; Section; Code[20])
        {
            Caption = 'Section';
            Editable = false;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Editable = false;
        }
        field(6; "Exam Type"; Code[20])
        {
            Caption = 'Exam Type';
            Editable = false;
            TableRelation = "Exam Code";
        }
        field(7; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            Editable = true;
        }
        field(8; "Total Marks"; Decimal)
        {
            BlankZero = true;
            Caption = 'Total Marks';
            Editable = true;
        }
        field(9; "Average"; Decimal)
        {
            BlankZero = true;
            Caption = 'Average';
            Editable = true;
        }
        field(10; Rank; Integer)
        {
            BlankZero = true;
            Caption = 'Rank';
            Editable = true;
        }
        field(11; Grade; Code[10])
        {
            Caption = 'Grade';
            Editable = false;
        }
        field(12; "Total No of Subject Failed"; Integer)
        {
            Caption = 'Total No of Subject Failed';
            Editable = false;
        }
        field(13; Failed; Boolean)
        {
            Caption = 'Failed';
            Editable = false;
        }
        field(14; Remarks; Text[200])
        {
            Caption = 'Remarks';
        }
        field(15; Height; Decimal)
        {
            BlankZero = true;
            Caption = 'Height';
        }
        field(16; Weight; Decimal)
        {
            BlankZero = true;
            Caption = 'Weight';
        }
        field(17; "GPA Grade"; Code[10])
        {
            Caption = 'GPA Grade';
        }
        field(18; "GPA Points"; Decimal)
        {
            Caption = 'GPA Points';
        }
        field(19; "Percentage Scored"; Decimal)
        {
            Caption = 'Percentage Scored';
            Editable = false;
        }
        field(20; "Total Marks Conducted"; Decimal)
        {
            Caption = 'Total Marks Conducted';
        }
        field(21; "Average Attendance Percent"; Decimal)
        {
            BlankZero = true;
            Caption = 'Average Attendance Percent';
        }
        field(22; "Class Code"; Code[20])
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
        field(23; "Total No of Subject Absent"; Integer)
        {
        }
        field(50000; "Principal Comment2"; Text[250])
        {
        }
        field(50001; "Class Teacher Comment2"; Text[250])
        {
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
        field(70122; Regularity; Option)
        {
            OptionCaption = ' ,Very Good,Good,Average,Poor';
            OptionMembers = " ","Very Good",Good,"Average",Poor;
        }
        field(70123; Effort; Option)
        {
            OptionCaption = ' ,Very Good,Good,Average,Poor';
            OptionMembers = " ","Very Good",Good,"Average",Poor;
        }
        field(70124; Discipline; Option)
        {
            OptionCaption = ' ,Very Good,Good,Average,Poor';
            OptionMembers = " ","Very Good",Good,"Average",Poor;
        }
        field(70125; "Etiquette Manners"; Option)
        {
            OptionCaption = ' ,Very Good,Good,Average,Poor';
            OptionMembers = " ","Very Good",Good,"Average",Poor;
        }
        field(70126; "Principal Comment"; Text[200])
        {
        }
        field(70127; "Extra Curr Excellence"; Option)
        {
            OptionCaption = ' ,School Level,District Level,State Level';
            OptionMembers = " ","School Level","District Level","State Level";
        }
        field(70128; "Personal Traits"; Option)
        {
            OptionCaption = ' ,Pleasant,Systematic,Smart,A Bit Moody,Temperamental,Sensitive';
            OptionMembers = " ",Pleasant,Systematic,Smart,"A Bit Moody",Temperamental,Sensitive;
        }
        field(70129; "Social Movement"; Option)
        {
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
        }
        field(70130; Hospitability; Option)
        {
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
        }
        field(70131; Leadership; Option)
        {
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
        }
        field(70132; "Class Teacher Comment"; Text[200])
        {
        }
        field(70133; Description; Text[200])
        {
        }
        field(70134; Published; Boolean)
        {
            Description = 'Coding added by kathir on 2nd aug 11 for web portal';
        }
        field(70135; "Maximum Working Days"; Decimal)
        {
            BlankZero = true;
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

    trigger OnInsert()
    begin
        // Start 01. VANDHANA
        "User ID" := UserId;
        // Stop 01. VANDHANA
    end;

    var
        ClassSectionLook: Record "Class Section";
        ClassSection: Record "Class Section";
}

