table 71062 "Transfer Certificate"
{
    Caption = 'Transfer Certificate';
    DataClassification = CustomerContent;
    LookupPageID = "Transfer Certificate List";

    fields
    {
        field(1; "TC No."; Code[20])
        {
            Caption = 'TC No.';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the transfer certificate number.';
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Student;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the student number for whom the transfer certificate is issued.';
        }
        field(3; Class; Code[20])
        {
            Caption = 'Class';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Displays the class of the student.';
        }
        field(4; Section; Code[10])
        {
            Caption = 'Section';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Displays the section of the student.';
        }
        field(5; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Displays the curriculum followed by the student.';
        }
        field(6; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Displays the academic year of the student.';
        }
        field(7; "Withdrawl date"; Date)
        {
            Caption = 'Withdrawl date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date on which the student was withdrawn.';
        }
        field(9; "TC Issued"; Boolean)
        {
            Caption = 'TC Issued';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the transfer certificate has been issued.';
        }
        field(20; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the student''s date of birth.';

            trigger OnValidate()
            begin
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
            end;
        }
        field(21; Age; Integer)
        {
            BlankZero = true;
            Caption = 'Age';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Displays the age of the student calculated from the date of birth.';
        }
        field(22; "Date of Issue"; Date)
        {
            Caption = 'Date of Issue';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date on which the transfer certificate was issued.';
        }
        field(23; Conduct; Text[100])
        {
            Caption = 'Conduct';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies remarks regarding the student''s conduct.';
        }
        field(24; "Withdrawl No."; Code[20])
        {
            Caption = 'Withdrawl No.';
            TableRelation = Withdrawal WHERE("TC Issued" = FILTER(false));
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the withdrawal document number associated with the student.';

            trigger OnValidate()
            begin

                if Withdrawl.Get("Withdrawl No.") then begin
                    TransferFields(Withdrawl);
                    if Student.Get(Withdrawl."Student No.") then begin
                        "Date of Birth" := Student."Date Of Birth";
                        Validate("Date of Birth");
                    end;
                    "TC No." := xRec."TC No.";
                end;

                TransferCertificate.Reset();
                TransferCertificate.SetRange("Withdrawl No.", "Withdrawl No.");
                if TransferCertificate.FindFirst() then
                    Error(Text000);
            end;
        }
        field(25; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series used to generate the transfer certificate number.';
        }
        field(26; "Reason for Leaving"; Code[20])
        {
            Caption = 'Reason for Leaving';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the reason why the student is leaving the institution.';
        }
        field(27; Months; Integer)
        {
            BlankZero = true;
            Caption = 'Months';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Displays the additional months calculated for the student''s age.';
        }
        field(28; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class section code associated with the student.';


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
            ToolTip = 'Specifies the portal identifier associated with the record.';
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


        if "TC No." = '' then begin
            Academics.Get();
            Academics.TestField("TC No.");
            "No. Series" := Academics."TC No.";
            "TC No." := NoSeriesMgt.GetNextNo("No. Series");
        end;
    end;

    var
        Academics: Record "Academics Setup";
        Withdrawl: Record Withdrawal;
        TransferCertificate: Record "Transfer Certificate";
        Student: Record Student;
        ClassSection: Record "Class Section";
        NoSeriesMgt: Codeunit "No. Series";
        Age2: Decimal;
        TempAge: Decimal;
        Text000: Label 'Record already exists.';


    procedure Assistedit(OldTC: Record "Transfer Certificate"): Boolean
    begin

        OldTC := Rec;
        Academics.Get();
        Academics.TestField("TC No.");
        if NoSeriesMgt.LookupRelatedNoSeries(Academics."TC No.", OldTC."No. Series", "No. Series") then begin
            OldTC."TC No." := NoSeriesMgt.GetNextNo(OldTC."No. Series");
            Rec := OldTC;
            exit(true);
        end;
    end;
}

