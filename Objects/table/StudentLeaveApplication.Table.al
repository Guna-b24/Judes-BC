table 71089 "Student Leave Application"
{
    Caption = 'Student Leave Application';
    DataClassification = CustomerContent;
    DrillDownPageID = "Student Leave Application List";
    LookupPageID = "Student Leave Application List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the unique number of the leave application.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    LeaveSetup.Get();
                    NoSeriesMgt.TestManual(LeaveSetup."Student Leave Application No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Student;
            ToolTip = 'Specifies the student for whom leave is requested.';
            DataClassification = EndUserIdentifiableInformation;

            trigger OnLookup()
            begin
                if EduSetup.Get() then;
                StudentRec.SetRange("Academic Year", EduSetup."Academic Year");
                if StudentRec.FindSet() then
                    if PAGE.RunModal(0, StudentRec) = ACTION::LookupOK then begin
                        "Student No." := StudentRec."No.";
                        "Student Name" := StudentRec.Name;
                        Class := StudentRec.Class;
                        Curriculum := StudentRec.Curriculum;
                        Section := StudentRec.Section;
                    end;
            end;
        }
        field(3; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            ToolTip = 'Specifies the name of the student.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(4; Class; Code[20])
        {
            Caption = 'Class';
            TableRelation = Class;
            ToolTip = 'Specifies the class of the student.';
            DataClassification = CustomerContent;
        }

        field(5; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
            ToolTip = 'Specifies the curriculum of the student.';
            DataClassification = CustomerContent;
        }

        field(6; Section; Code[20])
        {
            Caption = 'Section';
            ToolTip = 'Specifies the section of the student.';
            DataClassification = CustomerContent;
        }

        field(7; "From Date"; Date)
        {
            Caption = 'From Date';
            ToolTip = 'Specifies the start date of the leave.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "To Date" <> 0D then
                    "No. Of Days" := "To Date" - "From Date" + 1;
            end;
        }
        field(8; "To Date"; Date)
        {
            Caption = 'To Date';
            ToolTip = 'Specifies the end date of the leave.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                if "From Date" <> 0D then
                    "No. Of Days" := "To Date" - "From Date" + 1;

            end;
        }
        field(9; Reason; Text[250])
        {
            Caption = 'Reason';
            ToolTip = 'Specifies the reason for the leave request.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(10; "No. Of Days"; Decimal)
        {
            Caption = 'No. Of Days';
            Editable = false;
            ToolTip = 'Specifies the total number of leave days.';
            DataClassification = CustomerContent;
        }

        field(11; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            ToolTip = 'Specifies the academic year.';
            DataClassification = CustomerContent;
        }
        field(13; "Leave Status"; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = ' ,Requested,Sanctioned,Cancelled';
            OptionMembers = " ",Requested,Sanctioned,Cancelled;
            ToolTip = 'Specifies the current status of the leave application.';
            DataClassification = CustomerContent;
        }
        field(14; "Applicant Type"; Option)
        {
            Caption = 'Applicant Type';
            OptionCaption = ' ,Student,Parent,Guardian';
            OptionMembers = " ",Student,Parent,Guardian;
            ToolTip = 'Specifies who applied for the leave.';
            DataClassification = CustomerContent;
        }
        field(15; "Leave Taken"; Decimal)
        {
            CalcFormula = Sum("Student Leave Application"."No. Of Days" WHERE("Student No." = FIELD("Student No."),
                                                                               "Leave Status" = FILTER(Sanctioned),
                                                                               "Academic Year" = FIELD("Academic Year")));
            Caption = 'Leave Taken';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies the total sanctioned leave taken by the student in the academic year.';
        }
        field(16; "Applicant E-Mail ID"; Text[100])
        {
            Caption = 'Applicant E-Mail ID';
            ToolTip = 'Specifies the email ID of the applicant.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            ToolTip = 'Specifies the number series used for leave applications.';
            DataClassification = SystemMetadata;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal identifier for integration.';
            DataClassification = SystemMetadata;
        }

        field(70122; "Class Code"; Code[30])
        {
            Caption = 'Class Code';
            ToolTip = 'Specifies the class section code of the student.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Academic Year", "Leave Status", "Student No.")
        {
            SumIndexFields = "No. Of Days";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            LeaveSetup.Get();
            LeaveSetup.TestField("Student Leave Application No.");
            "No. Series" := LeaveSetup."Student Leave Application No.";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        end;

    end;

    var
        StudentRec: Record Student;
        EduSetup: Record "Education Setup";
        LeaveSetup: Record "Academics Setup";
        NoSeriesMgt: Codeunit "No. Series";

    procedure Assistedit(OldRec: Record "Student Leave Application"): Boolean
    begin

        OldRec := Rec;
        LeaveSetup.Get();
        LeaveSetup.TestField("Student Leave Application No.");
        if NoSeriesMgt.LookupRelatedNoSeries(LeaveSetup."Student Leave Application No.", OldRec."No. Series", OldRec."No. Series") then begin
            OldRec."No." := NoSeriesMgt.GetNextNo(OldRec."No. Series");
            Rec := OldRec;
            exit(true);
        end;
    end;
}

