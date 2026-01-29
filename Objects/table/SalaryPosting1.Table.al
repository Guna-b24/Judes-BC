table 72121 "Salary Posting-1"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Salary Posting';

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(3; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            TableRelation = "Payroll Month & Year" WHERE ("Location Code" = FIELD ("Location Code"),
                                                          "Salary Plan Code" = FIELD ("Salary Plan Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(4; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
        }
        field(5; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
        }
        field(6; Year; Integer)
        {
            Caption = 'Year';
        }
        field(7; Month; Integer)
        {
            Caption = 'Month';
        }
        field(8; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            TableRelation = "Dimension Value" WHERE ("Global Dimension No." = CONST (1));
        }
        field(9; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            NotBlank = true;
            TableRelation = "Pay Elements" WHERE ("Location Code" = FIELD ("Location Code"),
                                                  "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(10; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(11; "Actual Amount"; Decimal)
        {
            Caption = 'Actual Amount';
        }
        field(12; "Payable Amount"; Decimal)
        {
            Caption = 'Payable Amount';
        }
        field(13; "Employee VPF Amount"; Decimal)
        {
            Caption = 'Employee VPF Amount';
        }
        field(14; "Employee PF / ESI Amount"; Decimal)
        {
            Caption = 'Employee PF / ESI Amount';
        }
        field(15; "Employer PF / ESI Amount"; Decimal)
        {
            Caption = 'Employer PF / ESI Amount';
        }
        field(16; "Employer EPS Amount"; Decimal)
        {
            Caption = 'Employer EPS Amount';
        }
        field(17; "PF Admin Charges Amount"; Decimal)
        {
            Caption = 'PF Admin Charges Amount';
        }
        field(18; "PF EDLI Amount"; Decimal)
        {
            Caption = 'PF EDLI Amount';
        }
        field(19; "PF RIFA Amount"; Decimal)
        {
            Caption = 'PF RIFA Amount';
        }
        field(20; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
        }
        field(21; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
        }
        field(22; "Salary Due Document No"; Code[20])
        {
            Caption = 'Salary Due Document No';
        }
        field(23; "Salary Due Posted Date"; Date)
        {
            Caption = 'Salary Due Posted Date';
        }
        field(24; "Salary Payment Document No."; Code[20])
        {
            Caption = 'Salary Payment Document No.';
        }
        field(25; "Salary Payment Date"; Date)
        {
            Caption = 'Salary Payment Date';
        }
        field(26; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(27; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST ("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST (Customer)) Customer
            ELSE
            IF ("Account Type" = CONST (Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST ("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST ("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST ("IC Partner")) "IC Partner";
        }
        field(28; "Pay Method"; Option)
        {
            Caption = 'Pay Method';
            OptionCaption = 'Cash,Cheque,Bank Transfer';
            OptionMembers = Cash,Cheque,"Bank Transfer";
        }
        field(29; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
        }
        field(30; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
        }
        field(31; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(32; "Emp Posting Group"; Code[20])
        {
            Caption = 'Emp Posting Group';
            TableRelation = "Payroll Employee Posting Group" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                    "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(33; "Pay Bus. Posting Group"; Code[20])
        {
            Caption = 'Pay Bus. Posting Group';
            TableRelation = "Payroll Business Posting Group" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                    "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(34; "Pay Element Description"; Text[50])
        {
            Caption = 'Pay Element Description';
        }
        field(35; "Salary Due Entry"; Boolean)
        {
            Caption = 'Salary Due Entry';
            Editable = false;
        }
        field(36; "Salary Payment Entry"; Boolean)
        {
            Caption = 'Salary Payment Entry';
            Editable = false;
        }
        field(37; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
        }
        field(38; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary";
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Salary Cycle Code", "Employee Category", "Pay Type", "Sorting Order")
        {
            Clustered = true;
        }
        key(Key2; "Sorting Order", "Pay Element Code", "Pay Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit DimensionManagement;

    [Scope('Internal')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Processed Salary", "Branch Code", FieldNumber, ShortcutDimCode);
        Modify;
    end;
}

