table 71884 "Education Setup"
{
    Caption = 'Education Setup';
    DataPerCompany = false;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;

        }
        field(2; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            DataClassification = CustomerContent;
        }
        field(3; "Rank Generation No."; Code[20])
        {
            Caption = 'Rank Generation No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(4; Company; Option)
        {
            Caption = 'Company';
            DataClassification = CustomerContent;
            OptionCaption = ' ,School,College';
            OptionMembers = " ",School,College;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(7; "Task No."; Code[20])
        {
            Caption = 'Task No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(8; "Announcement No."; Code[10])
        {
            Caption = 'Announcement No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(9; "Image File Path"; Text[250])
        {
            Caption = 'Image File Path';
            DataClassification = SystemMetadata;
        }
        field(10; "XML File Path"; Text[250])
        {
            Caption = 'XML File Path';
            DataClassification = SystemMetadata;
        }
        field(11; "Assignment No."; Code[20])
        {
            Caption = 'Assignment No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
        }
        field(70122; "Admission Posting Date"; Date)
        {
            Caption = 'Admission Posting Date';
            DataClassification = CustomerContent;
        }
        field(70123; "Promotion Academic Year"; Code[10])
        {
            Caption = 'Promotion Academic Year';
            TableRelation = "Academic Year";
            DataClassification = CustomerContent;
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

