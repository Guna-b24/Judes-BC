table 72051 "HR & Payroll Setup"
{
    Caption = 'HR & Payroll Setup';
    DataClassification = CustomerContent;
    DataCaptionFields = "User ID", "Location Code", "Location Name";

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = SystemMetadata;
            Editable = true;
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            NotBlank = true;
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if LocationHRPayrollSetup.Get("Location Code") then
                    "Location Name" := LocationHRPayrollSetup."Location Name";
                "Salary Plan Code" := '';
                "Salary Cyclic Code" := '';
                "Salary Start Date" := 0D;
                "Salary End Date" := 0D;
                "Salary Year Code" := '';
            end;
        }
        field(3; "Location Name"; Text[50])
        {
            Caption = 'Location Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Salary Plan";

            trigger OnValidate()
            begin
                "Salary Cyclic Code" := '';
                "Salary Start Date" := 0D;
                "Salary End Date" := 0D;
                "Salary Year Code" := '';
            end;
        }
        field(5; "Salary Cyclic Code"; Code[20])
        {
            Caption = 'Salary Cyclic Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Payroll Month & Year"."Salary Cyclic Code";
        }
        field(6; "Salary Start Date"; Date)
        {
            Caption = 'Salary Start Date';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(7; "Salary End Date"; Date)
        {
            Caption = 'Salary End Date';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(8; "Salary Year Code"; Code[20])
        {
            Caption = 'Salary Year Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(9; "Payment Salary Plan Code"; Code[20])
        {
            Caption = 'Payment Salary Plan Code';
            DataClassification = CustomerContent;
            TableRelation = "Salary Plan";
        }
        field(10; "Payment Salary Year Code"; Code[20])
        {
            Caption = 'Payment Salary Year Code';
            DataClassification = CustomerContent;
        }
        field(11; "Payment Salary Cyclic Code"; Code[20])
        {
            Caption = 'Payment Salary Cyclic Code';
            DataClassification = CustomerContent;
            TableRelation = "Payroll Month & Year";
        }
        field(12; "Payment Salary Start Date"; Date)
        {
            Caption = 'Payment Salary Start Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Payment Salary End Date"; Date)
        {
            Caption = 'Payment Salary End Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
}

