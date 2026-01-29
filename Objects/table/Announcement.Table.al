table 71911 Announcement
{
    //    No    Date        Sign         Trigger              Description
    // -----------------------------------------------------------------------------------------------
    //   01     07.01.10    ANKESH      OnInsert()            To Initialize The Series.
    //   02     07.01.10    ANKESH    Task No.-OnValidate()   To Run TestManual Function Of NoSeriesManagment Codeunit.
    //   03     07.01.10    ANKESH      AssistEdit()          The Code will Run when the AssistEdit Button Is activated on Form.

    Caption = 'Announcement';
    LookupPageID = 71917;

    fields
    {
        field(1; "Announcement No."; Code[20])
        {
            Caption = 'Announcement No.';

            trigger OnValidate()
            begin
                // Start 02. Ankesh
                if "Announcement No." <> xRec."Announcement No." then begin
                    AnnouncementSetup.Get;
                    NoSeriesMgt.TestManual(AnnouncementSetup."Announcement No.");
                    "No. Series" := '';
                end;
                // Stop 02. Ankesh
            end;
        }
        field(2; "Announcement Type"; Option)
        {
            Caption = 'Announcement Type';
            OptionCaption = ' ,Staff,Student,Everyone';
            OptionMembers = " ",Staff,Student,Everyone;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF ("Announcement Type" = CONST (Staff)) Employee
            ELSE
            IF ("Announcement Type" = CONST (Student)) "Student Subjects";
        }
        field(9; "Date Created"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;
        }
        field(11; Priority; Option)
        {
            Caption = 'Priority';
            InitValue = Normal;
            OptionCaption = 'Low,Normal,High';
            OptionMembers = Low,Normal,High;
        }
        field(12; "Description-1"; Text[250])
        {
            Caption = 'Description';
        }
        field(13; Closed; Boolean)
        {
            Caption = 'Closed';

            trigger OnValidate()
            begin
                if Closed then
                    "Date Closed" := Today;
            end;
        }
        field(14; "Date Closed"; Date)
        {
            Caption = 'Date Closed';
        }
        field(15; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(17; Canceled; Boolean)
        {
            Caption = 'Canceled';

            trigger OnValidate()
            begin
                if Canceled and not Closed then
                    Validate(Closed, true);

                if (not Canceled) and Closed then
                    Validate(Closed, false);
            end;
        }
        field(18; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(19; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(20; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Event,Announcement,Circular';
            OptionMembers = " ","Event",Announcement,Circular;
        }
        field(21; Subject; Text[250])
        {
            Caption = 'Subject';
        }
        field(22; "Description-2"; Text[250])
        {
        }
        field(23; "Description-3"; Text[250])
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
    }

    keys
    {
        key(Key1; "Announcement No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01. Ankesh
        if "Announcement No." = '' then begin
            AnnouncementSetup.Get;
            AnnouncementSetup.TestField("Announcement No.");
            NoSeriesMgt.InitSeries(AnnouncementSetup."Announcement No.", xRec."No. Series", 0D, "Announcement No.", "No. Series");
        end
        // Stop 01. Ankesh
    end;

    var
        Announcement: Record Announcement;
        AnnouncementSetup: Record "Education Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    [Scope('Internal')]
    procedure AssistEdit(OldAnnouncement: Record Announcement): Boolean
    begin
        // Start 03. Ankesh
        with Announcement do begin
            Announcement := Rec;
            AnnouncementSetup.Get;
            AnnouncementSetup.TestField("Announcement No.");
            if NoSeriesMgt.SelectSeries(AnnouncementSetup."Announcement No.", OldAnnouncement."No. Series", "No. Series") then begin
                AnnouncementSetup.Get;
                AnnouncementSetup.TestField("Announcement No.");
                NoSeriesMgt.SetSeries("Announcement No.");
                Rec := Announcement;
                exit(true);
            end;
        end;
        // Stop 03. Ankesh
    end;
}

