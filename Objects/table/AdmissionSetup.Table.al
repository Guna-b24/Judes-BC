table 71000 "Admission Setup"
{

    Caption = 'Admission Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            ToolTip = 'Specifies the primary key for the admission setup record.';
            DataClassification = SystemMetadata;
        }
        field(2; "Enquiry No."; Code[10])
        {
            Caption = 'Enquiry No.';
            TableRelation = "No. Series";
            ToolTip = 'Specifies the number series used for enquiries.';
            DataClassification = SystemMetadata;
        }
        field(3; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            TableRelation = "No. Series";
            ToolTip = 'Specifies the number series used for applications.';
            DataClassification = SystemMetadata;
        }
        field(4; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            ToolTip = 'Specifies the academic year applicable for admissions.';
            DataClassification = CustomerContent;

        }
        field(5; "Appl Cost Method"; Option)
        {
            Caption = 'Appl Cost Method';
            OptionCaption = ' ,Common,Classwise';
            OptionMembers = " ",Common,Classwise;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies how the application cost is calculated.';
        }
        field(6; "Application Cost"; Decimal)
        {
            Caption = 'Application Cost';
            ToolTip = 'Specifies the cost charged for the application.';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(7; "Registration Cost"; Decimal)
        {
            Caption = 'Registration Cost';
            ToolTip = 'Specifies the cost charged for registration.';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(8; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            ToolTip = 'Specifies the journal template used for posting.';
            TableRelation = "Gen. Journal Template";
            DataClassification = SystemMetadata;
        }
        field(9; "Application Sales Batch Name"; Code[20])
        {
            Caption = 'Application Sales Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
            ToolTip = 'Specifies the journal batch used for application sales.';
            DataClassification = SystemMetadata;
        }
        field(10; "Application Cost Account No."; Code[20])
        {
            Caption = 'Application Cost Account No.';
            ToolTip = 'Specifies the G/L account used for application cost posting.';
            TableRelation = "G/L Account";
            DataClassification = SystemMetadata;
        }
        field(11; "Registration Cost Account No."; Code[20])
        {
            Caption = 'Registration Cost Account No.';
            ToolTip = 'Specifies the G/L account used for registration cost posting.';
            TableRelation = "G/L Account";
            DataClassification = SystemMetadata;
        }
        field(12; "Application Cost Needed"; Boolean)
        {
            Caption = 'Application Cost Needed';
            ToolTip = 'Specifies whether application cost is required.';
            DataClassification = CustomerContent;
        }
        field(13; "Registration Cost Needed"; Boolean)
        {
            Caption = 'Registration Cost Needed';
            ToolTip = 'Specifies whether registration cost is required.';
            DataClassification = CustomerContent;
        }
        field(14; "Admission Year"; Code[10])
        {
            Caption = 'Admission Year';
            ToolTip = 'Specifies the admission year used for student admissions.';
            TableRelation = "Academic Year";
            DataClassification = CustomerContent;
        }
        field(15; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            ToolTip = 'Specifies the general business posting group.';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = SystemMetadata;
        }
        field(16; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            ToolTip = 'Specifies the customer posting group.';
            TableRelation = "Customer Posting Group";
            DataClassification = SystemMetadata;
        }
        field(17; "Student No."; Code[10])
        {
            Caption = 'Student No.';
            ToolTip = 'Specifies the number series used for student numbers.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
        field(21; "Registration Batch Name"; Code[20])
        {
            Caption = 'Registration Batch Name';
            ToolTip = 'Specifies the journal batch used for registration posting.';
            TableRelation = "Gen. Journal Batch".Name
                where("Journal Template Name" = field("Journal Template Name"));
            DataClassification = SystemMetadata;
        }
        field(22; "Application Sales Posting No."; Code[20])
        {
            Caption = 'Application Sales Posting No.';
            ToolTip = 'Specifies the number series used for application sales posting.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
        field(23; "Registration Posting No."; Code[20])
        {
            Caption = 'Registration Posting No.';
            ToolTip = 'Specifies the number series used for registration posting.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
        field(24; "Evaluation No."; Code[20])
        {
            Caption = 'Evaluation No.';
            ToolTip = 'Specifies the number series used for evaluation.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
        field(25; "Selection No."; Code[20])
        {
            Caption = 'Selection No.';
            ToolTip = 'Specifies the number series used for selection.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
        field(26; "Application Sale Method"; Option)
        {
            Caption = 'Application Sale Method';
            ToolTip = 'Specifies how applications are sold.';
            OptionCaption = ' ,Common,Classwise';
            OptionMembers = " ",Common,Classwise;
            DataClassification = CustomerContent;
        }
        field(27; "Application Sales From"; Date)
        {
            Caption = 'Application Sales From';
            ToolTip = 'Specifies the start date for application sales.';
            DataClassification = CustomerContent;
        }
        field(28; "Application Sales To"; Date)
        {
            Caption = 'Application Sales To';
            ToolTip = 'Specifies the end date for application sales.';
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the identifier used to synchronize data with the portal.';
            DataClassification = SystemMetadata;
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

