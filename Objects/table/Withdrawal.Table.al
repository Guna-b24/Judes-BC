table 71061 Withdrawal
{
    Caption = 'Withdrawal';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71069;
    LookupPageID = "Withdrawal List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the unique withdrawal document number.';
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Student WHERE("Student Status" = FILTER(Student));
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the student number for whom the withdrawal is processed.';

            trigger OnValidate()
            begin
                if Student.Get("Student No.") then begin
                    Class := Student.Class;
                    Section := Student.Section;
                    Curriculum := Student.Curriculum;
                end;

                Withdrawl.SetRange("Student No.", "Student No.");
                if Withdrawl.FindFirst() then
                    Error(Text000);

            end;
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
        field(7; "Withdrawal date"; Date)
        {
            Caption = 'Withdrawal date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date on which the student was withdrawn.';
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series used to generate the withdrawal number.';
        }
        field(9; "TC Issued"; Boolean)
        {
            Caption = 'TC Issued';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the transfer certificate has been issued for this withdrawal.';
        }
        field(10; "Class Code"; Code[20])
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
        field(26; "Reason for Leaving"; Code[20])
        {
            Caption = 'Reason for Leaving';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the reason for the student leaving the institution.';
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

        if "No." = '' then begin
            Academics.Get();
            Academics.TestField("Withdrawl No.");
            "No. Series" := Academics."Withdrawl No.";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        end;
        "Academic Year" := EduVert.GetAdmissionYear();
        "Withdrawal date" := WorkDate();
    end;

    var
        Academics: Record "Academics Setup";
        Student: Record Student;
        Withdrawl: Record Withdrawal;
        ClassSection: Record "Class Section";
        NoSeriesMgt: Codeunit "No. Series";
        EduVert: Codeunit "Education Vertical";
        Text000: Label 'Record already exists.';


    procedure Assistedit(OldWithdrawl: Record Withdrawal): Boolean
    begin
        OldWithdrawl := Rec;
        Academics.Get();
        Academics.TestField("Withdrawl No.");
        if NoSeriesMgt.LookupRelatedNoSeries(Academics."Withdrawl No.", OldWithdrawl."No. Series", "No. Series") then begin
            OldWithdrawl."No." := NoSeriesMgt.GetNextNo(OldWithdrawl."No. Series");
            Rec := OldWithdrawl;
            exit(true);
        end;
    end;

}

