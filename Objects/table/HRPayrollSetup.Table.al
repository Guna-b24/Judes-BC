table 72051 "HR & Payroll Setup"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.

    Caption = 'HR & Payroll Setup';
    DataCaptionFields = "User ID", "Location Code", "Location Name";

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Editable = true;
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            NotBlank = true;
            TableRelation = "Location HR & Payroll Setup";

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
            Editable = false;
        }
        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
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
            NotBlank = true;
            TableRelation = "Payroll Month & Year"."Salary Cyclic Code";
        }
        field(6; "Salary Start Date"; Date)
        {
            Caption = 'Salary Start Date';
            Editable = true;
        }
        field(7; "Salary End Date"; Date)
        {
            Caption = 'Salary End Date';
            Editable = true;
        }
        field(8; "Salary Year Code"; Code[20])
        {
            Caption = 'Salary Year Code';
            NotBlank = true;
        }
        field(9; "Payment Salary Plan Code"; Code[20])
        {
            Caption = 'Payment Salary Plan Code';
            TableRelation = "Salary Plan";

            trigger OnValidate()
            begin
                /*
                "Payment Salary Year Code" := '';
                "Payment Salary Cyclic Code" := '';
                "Payment Salary Start Date" := 0D;
                "Payment Salary End Date" := 0D;
                      */

            end;
        }
        field(10; "Payment Salary Year Code"; Code[20])
        {
            Caption = 'Payment Salary Year Code';
        }
        field(11; "Payment Salary Cyclic Code"; Code[20])
        {
            Caption = 'Payment Salary Cyclic Code';
            TableRelation = "Payroll Month & Year";
        }
        field(12; "Payment Salary Start Date"; Date)
        {
            Caption = 'Payment Salary Start Date';
            Editable = false;
        }
        field(13; "Payment Salary End Date"; Date)
        {
            Caption = 'Payment Salary End Date';
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

