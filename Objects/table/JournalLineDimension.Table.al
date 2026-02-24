table 50120 "Journal Line Dimension"
{
    Caption = 'Journal Line Dimension';
    DataClassification = CustomerContent;
    DrillDownPageId = "Journal Line Dimension List";
    LookupPageId = "Journal Line Dimension List";

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the table ID to which the journal line belongs.';
        }

        field(2; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the journal template name.';
        }

        field(3; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the journal batch name.';
        }

        field(4; "Journal Line No."; Integer)
        {
            Caption = 'Journal Line No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the journal line number.';
        }

        field(5; "Allocation Line No."; Integer)
        {
            Caption = 'Allocation Line No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the allocation line number.';
        }

        field(6; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the dimension code.';
        }

        field(7; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the dimension value code.';
        }

        field(8; "New Dimension Value Code"; Code[20])
        {
            Caption = 'New Dimension Value Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the new dimension value code to replace the existing one.';
        }
    }

    keys
    {
        key(PK; "Table ID", "Journal Template Name", "Journal Batch Name",
                "Journal Line No.", "Allocation Line No.", "Dimension Code")
        {
            Clustered = true;
        }
    }
}
