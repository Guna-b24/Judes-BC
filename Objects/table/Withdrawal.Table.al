table 71061 Withdrawal
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //  01   12/10/09   KATHIR   OnInsert()                  Code added to generate Number series
    //  02   12/10/09   KATHIR   OnInsert()                  Code added to get current academic year and withdrawl date
    //  03   12/10/09   KATHIR   Student No. - OnValidate()  Code added to get student class,section and Curriculum
    //  04   12/10/09   KATHIR   Student No. - OnValidate()  Code added to check duplicate students
    //  05   12/10/09   KATHIR   Assistedit()                Code added to generate number series
    //  06   19/10/09   VANDHANA OnInsert                    Code to assign User ID.
    //  07  23/11/09   VIGNESH  Class - OnValidate()         Code added to get the Class Section & Curriculum
    //  08  23/11/09   VIGNESH  Class - OnLookup()           Code added to get the Class Section & Curriculum
    //  09  23/11/09   VIGNESH  Curriculum - OnValidate()    Code added to get the Class Section & Curriculum
    //  10  23/11/09   VIGNESH  Curriculum - OnLookup()      Code added to get the Class Section & Curriculum
    //  11  23/11/09   VIGNESH  Section - OnValidate()       Code added to get the Class Section & Curriculum
    //  12  23/11/09   VIGNESH  Section - OnLookup()         Code added to get the Class Section & Curriculum

    Caption = 'Withdrawal';
    DrillDownPageID = 71069;
    LookupPageID = 71069;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Student WHERE ("Student Status" = FILTER (Student));

            trigger OnValidate()
            begin
                // Start 03.KATHIR
                if Student.Get("Student No.") then begin
                    Class := Student.Class;
                    Section := Student.Section;
                    Curriculum := Student.Curriculum;
                end;
                // Stop 03.KATHIR

                // Start 04.KATHIR
                Withdrawl.SetRange("Student No.", "Student No.");
                if Withdrawl.FindFirst then
                    Error(Text000);
                // Stop 04.KATHIR
            end;
        }
        field(3; Class; Code[10])
        {
            Caption = 'Class';
            Editable = false;
        }
        field(4; Section; Code[10])
        {
            Caption = 'Section';
            Editable = false;
        }
        field(5; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            Editable = false;
        }
        field(6; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = false;
        }
        field(7; "Withdrawal date"; Date)
        {
            Caption = 'Withdrawal date';
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(9; "TC Issued"; Boolean)
        {
            Caption = 'TC Issued';
        }
        field(10; "Class Code"; Code[20])
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
        field(26; "Reason for Leaving"; Code[20])
        {
            Caption = 'Reason for Leaving';
            TableRelation = "Reason Code";
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
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.KATHIR
        Academics.Get;
        if "No. Series" = '' then begin
            Academics.TestField("Withdrawl No.");
            NoSeriesMgt.InitSeries(Academics."Withdrawl No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        // Stop 01.KATHIR
        // Start 02.KATHIR
        "Academic Year" := EduVert.GetAdmissionYear;
        "Withdrawal date" := WorkDate;
        // Stop 02.KATHIR
        // Start 06. VANDHANA
        "User ID" := UserId;
        // Stop 06. VANDHANA
    end;

    var
        Academics: Record "Academics Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EduVert: Codeunit "Education Vertical";
        Student: Record Student;
        Withdrawl: Record Withdrawal;
        ClassSection: Record "Class Section";
        Text000: Label 'Record already exists.';

    [Scope('Internal')]
    procedure Assistedit(OldWithdrawl: Record Withdrawal): Boolean
    begin
        // Start 05.KATHIR
        with OldWithdrawl do begin
            OldWithdrawl := Rec;
            Academics.Get;
            Academics.TestField("Withdrawl No.");
            if NoSeriesMgt.SelectSeries(Academics."Withdrawl No.", OldWithdrawl."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := OldWithdrawl;
                exit(true);
            end;
        end;
        // stop 05.KATHIR
    end;
}

