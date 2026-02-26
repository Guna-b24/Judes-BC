table 71911 Announcement
{
    Caption = 'Announcement';
    DataClassification = CustomerContent;
    LookupPageID = "Announcement List";

    fields
    {
        field(1; "Announcement No."; Code[20])
        {
            Caption = 'Announcement No.';
            ToolTip = 'Specifies the unique number assigned to the announcement.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Announcement No." <> xRec."Announcement No." then begin
                    AnnouncementSetup.Get();
                    NoSeriesMgt.TestManual(AnnouncementSetup."Announcement No.");
                    "No. Series" := '';
                end;
            end;
        }

        field(2; "Announcement Type"; Option)
        {
            Caption = 'Announcement Type';
            ToolTip = 'Specifies whether the announcement is for staff, students, or everyone.';
            OptionCaption = ' ,Staff,Student,Everyone';
            OptionMembers = " ",Staff,Student,Everyone;
            DataClassification = CustomerContent;
        }

        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the related staff or student number based on the announcement type.';
            DataClassification = CustomerContent;
            TableRelation =
                if ("Announcement Type" = const(Staff)) Employee
            else
            if ("Announcement Type" = const(Student)) "Student Subjects";
        }

        field(9; "Date Created"; Date)
        {
            Caption = 'Starting Date';
            ToolTip = 'Specifies the date on which the announcement was created.';
            NotBlank = true;
            DataClassification = CustomerContent;
        }

        field(11; Priority; Option)
        {
            Caption = 'Priority';
            ToolTip = 'Specifies the importance level of the announcement.';
            InitValue = Normal;
            OptionCaption = 'Low,Normal,High';
            OptionMembers = Low,Normal,High;
            DataClassification = CustomerContent;
        }

        field(12; "Description-1"; Text[250])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the main description of the announcement.';
            DataClassification = CustomerContent;
        }

        field(13; Closed; Boolean)
        {
            Caption = 'Closed';
            ToolTip = 'Specifies whether the announcement is closed.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Closed then
                    "Date Closed" := Today;
            end;
        }

        field(14; "Date Closed"; Date)
        {
            Caption = 'Date Closed';
            ToolTip = 'Specifies the date on which the announcement was closed.';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            ToolTip = 'Specifies the number series used to assign the announcement number.';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }

        field(17; Canceled; Boolean)
        {
            Caption = 'Canceled';
            ToolTip = 'Specifies whether the announcement has been canceled.';
            DataClassification = CustomerContent;

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
            ToolTip = 'Specifies the date from which the announcement is valid.';
            DataClassification = CustomerContent;
        }

        field(19; "End Date"; Date)
        {
            Caption = 'End Date';
            ToolTip = 'Specifies the date until which the announcement is valid.';
            DataClassification = CustomerContent;
        }

        field(20; "Document Type"; Option)
        {
            Caption = 'Document Type';
            ToolTip = 'Specifies whether the record is an event, announcement, or circular.';
            OptionCaption = ' ,Event,Announcement,Circular';
            OptionMembers = " ","Event",Announcement,Circular;
            DataClassification = CustomerContent;
        }

        field(21; Subject; Text[250])
        {
            Caption = 'Subject';
            ToolTip = 'Specifies the subject of the announcement.';
            DataClassification = CustomerContent;
        }

        field(22; "Description-2"; Text[250])
        {
            ToolTip = 'Specifies additional details for the announcement.';
            DataClassification = CustomerContent;
        }

        field(23; "Description-3"; Text[250])
        {
            ToolTip = 'Specifies further information related to the announcement.';
            DataClassification = CustomerContent;
        }

        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
            ToolTip = 'Specifies the ID of the user who created the announcement.';
            Editable = false;
            DataClassification = SystemMetadata;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference ID linked to the announcement.';
            DataClassification = CustomerContent;
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
        if "Announcement No." = '' then begin
            AnnouncementSetup.Get();
            AnnouncementSetup.TestField("Announcement No.");
            "No. Series" := AnnouncementSetup."Announcement No.";
            "Announcement No." := NoSeriesMgt.GetNextNo("No. Series");
        end;
    end;

    var
        Announcement: Record Announcement;
        AnnouncementSetup: Record "Education Setup";
        NoSeriesMgt: Codeunit "No. Series";

    procedure AssistEdit(OldAnnouncement: Record Announcement): Boolean
    begin
        Announcement := Rec;
        AnnouncementSetup.Get();
        AnnouncementSetup.TestField("Announcement No.");
        if NoSeriesMgt.LookupRelatedNoSeries(AnnouncementSetup."Announcement No.", OldAnnouncement."No. Series", Announcement."No. Series") then begin
            Announcement."Announcement No." := NoSeriesMgt.GetNextNo(Announcement."No. Series");
            Rec := Announcement;
            exit(true);
        end;
    end;

}

