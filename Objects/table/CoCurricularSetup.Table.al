table 71080 "Co-Curricular Setup"
{
    Caption = 'Co-Curricular Setup';
    DataClassification = SystemMetadata;
    LookupPageId = "Co-Curricular Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            ToolTip = 'Specifies the primary key for the co-curricular setup record.';
            NotBlank = true;
            DataClassification = SystemMetadata;
        }

        field(2; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            ToolTip = 'Specifies the number series used to generate competition entry numbers.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }

        field(3; "Participant Entry No."; Code[20])
        {
            Caption = 'Participant Entry No.';
            ToolTip = 'Specifies the number series used to generate participant entry numbers.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }

        field(4; "Result Individual Entry No."; Code[20])
        {
            Caption = 'Result Individual Entry No.';
            ToolTip = 'Specifies the number series used to generate individual result entry numbers.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
        field(5; "Result Team Entry No."; Code[20])
        {
            Caption = 'Result Team Entry No.';
            ToolTip = 'Specifies the number series used to generate team result entry numbers.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }

        field(50000; "Last Used Team No"; Code[20])
        {
            Caption = 'Last Used Team No';
            ToolTip = 'Stores the last generated team number for internal tracking.';
            Editable = false;
            DataClassification = SystemMetadata;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference identifier.';
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

