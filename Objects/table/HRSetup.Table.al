table 72000 "HR Setup"
{
    Caption = 'HR Setup';
    DataCaptionFields = "Primary Key";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the primary key for the setup record.';
        }

        field(2; "Indenting SNo"; Code[10])
        {
            Caption = 'Indenting No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used for indenting documents.';
        }

        field(3; "ResumeDB SNo"; Code[10])
        {
            Caption = 'Resume Database No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used for resume database entries.';
        }

        field(4; "Appraisal SNo"; Code[20])
        {
            Caption = 'Appraisal No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used for appraisal documents.';
        }

        field(5; "File Directory"; Code[150])
        {
            Caption = 'File Directory';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the default file directory path used by HR processes.';
        }

        field(6; Appraisal; DateFormula)
        {
            Caption = 'Appraisal Period Formula';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date formula used to calculate appraisal periods.';
        }

        field(7; "Send to HR Mail"; Text[30])
        {
            Caption = 'Send to HR Email';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the email address to which HR notifications are sent.';
        }
        field(8; "Send to HR Mail CC"; Text[30])
        {
            Caption = 'Send to HR Email CC';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the CC email address for HR notifications.';
        }

        field(9; "Training SNo"; Code[10])
        {
            Caption = 'Training No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used for training documents.';
        }

        field(10; "Interview SNo"; Code[10])
        {
            Caption = 'Interview No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used for interview documents.';
        }

        field(11; "Selection SNo"; Code[10])
        {
            Caption = 'Selection No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used for selection documents.';
        }
        field(12; MsWordPath; Text[150])
        {
            Caption = 'MS Word Template Path';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the file path for MS Word templates used in HR.';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

