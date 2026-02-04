table 71884 "Education Setup"
{
    //   No   Date     Sign          Trigger          Description
    //  ------------------------------------------------------------------------------------------
    //   01  17/09/09  VIGNESH                        Table Created by Vignesh
    //   02  19/10/09  VANDHANA      OnInsert         Code to assign User ID.
    //   03  06.01.10  GUNA                           New fields Task No and Announcement No is created

    Caption = 'Education Setup';
    DataPerCompany = false;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(3; "Rank Generation No."; Code[20])
        {
            Caption = 'Rank Generation No.';
            TableRelation = "No. Series";
        }
        field(4; Company; Option)
        {
            Caption = 'Company';
            OptionCaption = ' ,School,College';
            OptionMembers = " ",School,College;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(7; "Task No."; Code[20])
        {
            Caption = 'Task No.';
            TableRelation = "No. Series";
        }
        field(8; "Announcement No."; Code[10])
        {
            Caption = 'Announcement No.';
            TableRelation = "No. Series";
        }
        field(9; "Image File Path"; Text[250])
        {
            Caption = 'Image File Path';
        }
        field(10; "XML File Path"; Text[250])
        {
            Caption = 'XML File Path';
        }
        field(11; "Assignment No."; Code[20])
        {
            Caption = 'Assignment No.';
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
        field(70122; "Admission Posting Date"; Date)
        {
        }
        field(70123; "Promotion Academic Year"; Code[10])
        {
            TableRelation = "Academic Year";
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

    trigger OnInsert()
    begin
        // Start 02. VANDHANA
        "User ID" := UserId;
        // Stop 02. VANDHANA
    end;
}

