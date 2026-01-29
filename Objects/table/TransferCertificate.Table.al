table 71062 "Transfer Certificate"
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  12/10/09   KATHIR   OnInsert()                   Code added for number series
    //   02  12/10/09   KATHIR   Withdrawl No. - OnValidate() Code added to Transfer fields from Withdrawl to TC
    //                                                        Code added to Check whether same Withdrawl no exits in TC
    //   03  12/10/09   KATHIR   Assistedit()                 Code added for number series
    //   04  12/10/09   KATHIR   Date of Birth - OnValidate() Code added to Get Age
    //   05  19/10/09   VANDHANA  OnInsert                     Code to assign User ID.
    //   06  17/11/09   VIGNESH  Withdrawl No. - OnValidate() Code added to get the data of birth from the Student table and VALIDATE
    //   07  23/11/09   VIGNESH  Class - OnValidate()         Code added to get the Class Section & Curriculum
    //   08  23/11/09   VIGNESH  Class - OnLookup()           Code added to get the Class Section & Curriculum
    //   09  23/11/09   VIGNESH  Curriculum - OnValidate()    Code added to get the Class Section & Curriculum
    //   10  23/11/09   VIGNESH  Curriculum - OnLookup()      Code added to get the Class Section & Curriculum
    //   11  23/11/09   VIGNESH  Section - OnValidate()       Code added to get the Class Section & Curriculum
    //   12  23/11/09   VIGNESH  Section - OnLookup()         Code added to get the Class Section & Curriculum

    Caption = 'Transfer Certificate';
    LookupPageID = 71071;

    fields
    {
        field(1; "TC No."; Code[20])
        {
            Caption = 'TC No.';
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Student;
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
        field(7; "Withdrawl date"; Date)
        {
            Caption = 'Withdrawl date';
        }
        field(9; "TC Issued"; Boolean)
        {
            Caption = 'TC Issued';
        }
        field(20; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';

            trigger OnValidate()
            begin
                // Start 04.KATHIR
                if "Date of Birth" <> 0D then begin
                    Age := Today - "Date of Birth";
                    TempAge := Round(Age / 365, 1, '=');
                    Age2 := Age mod 365;
                    Months := Round(Age2 / 30, 1, '=');
                    Age := TempAge - 1;
                end else begin
                    Clear(Age);
                    Clear(Months);
                end;
                // Stop 04.KATHIR
            end;
        }
        field(21; Age; Integer)
        {
            BlankZero = true;
            Caption = 'Age';
        }
        field(22; "Date of Issue"; Date)
        {
            Caption = 'Date of Issue';
        }
        field(23; Conduct; Text[100])
        {
            Caption = 'Conduct';
        }
        field(24; "Withdrawl No."; Code[20])
        {
            Caption = 'Withdrawl No.';
            TableRelation = Withdrawal WHERE ("TC Issued" = FILTER (false));

            trigger OnValidate()
            begin
                // Start 02.KATHIR
                if Withdrawl.Get("Withdrawl No.") then begin
                    TransferFields(Withdrawl);
                    // Start 06.VIGNESH
                    if Student.Get(Withdrawl."Student No.") then begin
                        "Date of Birth" := Student."Date Of Birth";
                        Validate("Date of Birth");
                    end;
                    // Stop 06.VIGNESH
                    "TC No." := xRec."TC No.";
                end;

                TransferCertificate.Reset;
                TransferCertificate.SetRange("Withdrawl No.", "Withdrawl No.");
                if TransferCertificate.FindFirst then
                    Error(Text000);
                // Stop 02.KATHIR
            end;
        }
        field(25; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(26; "Reason for Leaving"; Code[20])
        {
            Caption = 'Reason for Leaving';
            TableRelation = "Reason Code";
        }
        field(27; Months; Integer)
        {
            BlankZero = true;
            Caption = 'Months';
        }
        field(28; "Class Code"; Code[20])
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
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
    }

    keys
    {
        key(Key1; "TC No.")
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
            Academics.TestField("TC No.");
            NoSeriesMgt.InitSeries(Academics."TC No.", xRec."No. Series", 0D, "TC No.", "No. Series");
        end;
        // Stop 01.KATHIR
        // Start 05. VANDHANA
        "User ID" := UserId;
        // Stop 05. VANDHANA
    end;

    var
        Academics: Record "Academics Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Withdrawl: Record Withdrawal;
        TransferCertificate: Record "Transfer Certificate";
        Age2: Decimal;
        TempAge: Decimal;
        Student: Record Student;
        ClassSection: Record "Class Section";
        Text000: Label 'Record already exists.';

    [Scope('Internal')]
    procedure Assistedit(OldTC: Record "Transfer Certificate"): Boolean
    begin
        // Start 03.KATHIR
        with OldTC do begin
            OldTC := Rec;
            Academics.Get;
            Academics.TestField("TC No.");
            if NoSeriesMgt.SelectSeries(Academics."TC No.", OldTC."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("TC No.");
                Rec := OldTC;
                exit(true);
            end;
        end;
        // Stop 03.KATHIR
    end;
}

