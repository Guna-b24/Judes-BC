table 71000 "Admission Setup"
{
    // 
    // No   Date        Sign       Trigger          Description
    // -----------------------------------------------------------------------------------------------
    // 01   17/09/09    Kathir                      Table Created by Kathir
    // 02   19/10/09    VANDHANA   OnInsert()       Code to assign the User ID.
    // 03   16.11.09    VIGNESH                     New Fields Application Sale Method, Application Sales from, Application Sales To added

    Caption = 'Admission Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Enquiry No."; Code[10])
        {
            Caption = 'Enquiry No.';
            TableRelation = "No. Series";
        }
        field(3; "Application No."; Code[10])
        {
            Caption = 'Application No.';
            TableRelation = "No. Series";
        }
        field(4; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(5; "Appl Cost Method"; Option)
        {
            Caption = 'Appl Cost Method';
            OptionCaption = ' ,Common,Classwise';
            OptionMembers = " ",Common,Classwise;
        }
        field(6; "Application Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Application Cost';
        }
        field(7; "Registration Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Registration Cost';
        }
        field(8; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(9; "Application Sales Batch Name"; Code[20])
        {
            Caption = 'Application Sales Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Journal Template Name"));
        }
        field(10; "Application Cost Account No."; Code[20])
        {
            Caption = 'Application Cost Account No.';
            TableRelation = "G/L Account";
        }
        field(11; "Registration Cost Account No."; Code[20])
        {
            Caption = 'Registration Cost Account No.';
            TableRelation = "G/L Account";
        }
        field(12; "Application Cost Needed"; Boolean)
        {
            Caption = 'Application Cost Needed';
        }
        field(13; "Registration Cost Needed"; Boolean)
        {
            Caption = 'Registration Cost Needed';
        }
        field(14; "Admission Year"; Code[10])
        {
            Caption = 'Admission Year';
            TableRelation = "Academic Year";
        }
        field(15; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(16; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(17; "Student No."; Code[10])
        {
            Caption = 'Student No.';
            TableRelation = "No. Series";
        }
        field(21; "Registration Batch Name"; Code[20])
        {
            Caption = 'Registration Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Journal Template Name"));
        }
        field(22; "Application Sales Posting No."; Code[20])
        {
            Caption = 'Application Sales Posting No.';
            TableRelation = "No. Series";
        }
        field(23; "Registration Posting No."; Code[20])
        {
            Caption = 'Registration Posting No.';
            TableRelation = "No. Series";
        }
        field(24; "Evaluation No."; Code[20])
        {
            Caption = 'Evaluation No.';
            TableRelation = "No. Series";
        }
        field(25; "Selection No."; Code[20])
        {
            Caption = 'Selection No.';
            TableRelation = "No. Series";
        }
        field(26; "Application Sale Method"; Option)
        {
            Caption = 'Application Sale Method';
            OptionCaption = ' ,Common,Classwise';
            OptionMembers = " ",Common,Classwise;
        }
        field(27; "Application Sales From"; Date)
        {
            Caption = 'Application Sales From';
        }
        field(28; "Application Sales To"; Date)
        {
            Caption = 'Application Sales To';
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
        // Start 01.VANDHANA
        "User ID" := UserId;
        // Stop 01.VANDHANA
    end;
}

