table 71089 "Student Leave Application"
{
    // 
    //    No    Date        Sign          Trigger                      Description
    // -----------------------------------------------------------------------------------------------
    //   01     28.06.10    ANKESH        OnInsert()             To Use No Series.
    //   02     28.06.10    ANKESH    No. - OnValidate()         To Use No Series.
    //   03     28.06.10    ANKESH  Student No. - OnLookup()     To Look Up the Student list
    //   04     28.06.10    ANKESH   From Date - OnValidate()    To Update From Date
    //   05     28.06.10    ANKESH   To Date - OnValidate()      To Update To Date
    //   06     28.06.10    ANKESH ApplicationSanctionOrCancel() To Change the status when the user click
    //   07     28.06.10    ANKESH        AssistEdit             To Use No Series.

    Caption = 'Student Leave Application';
    DrillDownPageID = 71104;
    LookupPageID = 71104;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                // Start 02. Ankesh
                if "No." <> xRec."No." then begin
                    LeaveSetup.Get;
                    NoSeriesMgt.TestManual(LeaveSetup."Student Leave Application No.");
                    "No. Series" := '';
                end;
                // Stop 02. Ankesh
            end;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Student;

            trigger OnLookup()
            begin
                // Start 03.Ankesh
                if EduSetup.Get then;
                StudentRec.SetRange("Academic Year", EduSetup."Academic Year");
                if StudentRec.FindSet then
                    if PAGE.RunModal(0, StudentRec) = ACTION::LookupOK then begin
                        "Student No." := StudentRec."No.";
                        "Student Name" := StudentRec.Name;
                        Class := StudentRec.Class;
                        Curriculum := StudentRec.Curriculum;
                        Section := StudentRec.Section;
                    end;
                // Stop 03. Ankesh
            end;
        }
        field(3; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
        }
        field(4; Class; Code[20])
        {
            Caption = 'Class';
            TableRelation = Class;
        }
        field(5; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
        }
        field(6; Section; Code[20])
        {
            Caption = 'Section';
        }
        field(7; "From Date"; Date)
        {
            Caption = 'From Date';

            trigger OnValidate()
            begin
                // Start 04.Ankesh
                if "To Date" <> 0D then
                    "No. Of Days" := "To Date" - "From Date" + 1;
                // Stop 04. Ankesh
            end;
        }
        field(8; "To Date"; Date)
        {
            Caption = 'To Date';

            trigger OnValidate()
            begin
                // Start 05.Ankesh
                if "From Date" <> 0D then
                    "No. Of Days" := "To Date" - "From Date" + 1;
                // Stop 05. Ankesh
            end;
        }
        field(9; Reason; Text[250])
        {
            Caption = 'Reason';
        }
        field(10; "No. Of Days"; Decimal)
        {
            Caption = 'No. Of Days';
            Editable = false;
        }
        field(11; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(13; "Leave Status"; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = ' ,Requested,Sanctioned,Cancelled';
            OptionMembers = " ",Requested,Sanctioned,Cancelled;
        }
        field(14; "Applicant Type"; Option)
        {
            Caption = 'Applicant Type';
            OptionCaption = ' ,Student,Parent,Guardian';
            OptionMembers = " ",Student,Parent,Guardian;
        }
        field(15; "Leave Taken"; Decimal)
        {
            CalcFormula = Sum ("Student Leave Application"."No. Of Days" WHERE ("Student No." = FIELD ("Student No."),
                                                                               "Leave Status" = FILTER (Sanctioned),
                                                                               "Academic Year" = FIELD ("Academic Year")));
            Caption = 'Leave Taken';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Applicant E-Mail ID"; Text[100])
        {
            Caption = 'Applicant E-Mail ID';
        }
        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
        field(70122; "Class Code"; Code[30])
        {
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
        // Start 01. Ankesh
        if "No." = '' then begin
            LeaveSetup.Get;
            LeaveSetup.TestField("Student Leave Application No.");
            NoSeriesMgt.InitSeries(LeaveSetup."Student Leave Application No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "User ID" := UserId;
        // Stop 01. Ankesh
    end;

    var
        StudentRec: Record Student;
        EduSetup: Record "Education Setup";
        LeaveSetup: Record "Academics Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    [Scope('Internal')]
    procedure Assistedit(OldRec: Record "Student Leave Application"): Boolean
    begin
        // Start 07.Ankesh
        with OldRec do begin
            OldRec := Rec;
            LeaveSetup.Get;
            LeaveSetup.TestField("Student Leave Application No.");
            if NoSeriesMgt.SelectSeries(LeaveSetup."Student Leave Application No.", OldRec."No. Series", OldRec."No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := OldRec;
                exit(true);
            end;
        end;
        // stop 07.Ankesh
    end;
}

