table 71072 "Fee Setup"
{
    Caption = 'Fee Setup';
    DataClassification = ToBeClassified;
    LookupPageId = "Fee Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
            ToolTip = 'Unique identifier for this fee setup record.';
        }

        field(2; "Class Fee No."; Code[10])
        {
            Caption = 'Class Fee No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            ToolTip = 'No. Series for class fees.';
        }
        field(3; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
            DataClassification = ToBeClassified;
            ToolTip = 'General journal template used for fee entries.';
        }

        field(4; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
            DataClassification = ToBeClassified;
            ToolTip = 'Batch within the journal template for fee entries.';
        }

        field(5; "Fee Number"; Code[20])
        {
            Caption = 'Fee Number';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            ToolTip = 'No. Series for individual fees.';
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = ToBeClassified;
            ToolTip = 'Portal identifier for integration purposes.';
        }
        field(70122; "Caution Deposit Template"; Code[20])
        {
            Caption = 'Caution Deposit Template';
            TableRelation = "Gen. Journal Template";
            DataClassification = ToBeClassified;
            ToolTip = 'Journal template for caution deposit transactions.';
        }

        field(70123; "Caution Deposit Batch"; Code[20])
        {
            Caption = 'Caution Deposit Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Caution Deposit Template"));
            DataClassification = ToBeClassified;
            ToolTip = 'Batch within the caution deposit journal template.';
        }

        field(70124; "Caution Deposit Number"; Code[20])
        {
            Caption = 'Caution Deposit Number';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            ToolTip = 'No. Series for caution deposit entries.';
        }

        field(70125; "Fee Receipt Template"; Code[10])
        {
            Caption = 'Fee Receipt Template';
            TableRelation = "Gen. Journal Template";
            DataClassification = ToBeClassified;
            ToolTip = 'Journal template used for fee receipts.';
        }
        field(70126; "Fee Receipt Batch"; Code[10])
        {
            Caption = 'Fee Receipt Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Fee Receipt Template"));
            DataClassification = ToBeClassified;
            ToolTip = 'Batch within the fee receipt journal template.';
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

