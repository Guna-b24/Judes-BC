table 72121 "Salary Posting-1"
{
    Caption = 'Salary Posting';
    DataClassification = CustomerContent;
    LookupPageId = "Salary Posting1 Worksheet";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = "Location HR & Payroll Setup";
            ToolTip = 'Specifies the location for which the salary is posted.';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
            TableRelation = "Salary Plan";
            ToolTip = 'Specifies the salary plan.';
        }
        field(3; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            DataClassification = CustomerContent;
            TableRelation = "Payroll Month & Year" WHERE("Location Code" = FIELD("Location Code"),
                                                          "Salary Plan Code" = FIELD("Salary Plan Code"));
            ValidateTableRelation = false;
            ToolTip = 'Specifies the salary cycle.';
        }
        field(4; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll start date.';
        }
        field(5; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll end date.';
        }
        field(6; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll year.';
        }
        field(7; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll month.';
        }
        field(8; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value" WHERE("Global Dimension No." = CONST(1));
            ToolTip = 'Specifies the branch code.';
        }
        field(9; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Pay Elements" WHERE("Location Code" = FIELD("Location Code"),
                                                  "Salary Plan Code" = FIELD("Salary Plan Code"));
            ToolTip = 'Specifies the pay element.';
        }
        field(10; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
            ToolTip = 'Specifies whether the pay element is an addition, deduction, or reimbursement.';
        }
        field(11; "Actual Amount"; Decimal)
        {
            Caption = 'Actual Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the calculated actual amount.';
        }
        field(12; "Payable Amount"; Decimal)
        {
            Caption = 'Payable Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payable amount.';
        }
        field(13; "Employee VPF Amount"; Decimal)
        {
            Caption = 'Employee VPF Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee VPF amount.';
        }
        field(14; "Employee PF / ESI Amount"; Decimal)
        {
            Caption = 'Employee PF / ESI Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee PF or ESI amount.';
        }
        field(15; "Employer PF / ESI Amount"; Decimal)
        {
            Caption = 'Employer PF / ESI Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employer PF or ESI contribution amount.';
        }
        field(16; "Employer EPS Amount"; Decimal)
        {
            Caption = 'Employer EPS Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employer EPS amount.';
        }
        field(17; "PF Admin Charges Amount"; Decimal)
        {
            Caption = 'PF Admin Charges Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF administration charges amount.';
        }
        field(18; "PF EDLI Amount"; Decimal)
        {
            Caption = 'PF EDLI Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF EDLI amount.';
        }
        field(19; "PF RIFA Amount"; Decimal)
        {
            Caption = 'PF RIFA Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF RIFA amount.';
        }
        field(20; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the journal batch name.';
        }
        field(21; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the journal template name.';
        }
        field(22; "Salary Due Document No"; Code[20])
        {
            Caption = 'Salary Due Document No';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary due document number.';
        }
        field(23; "Salary Due Posted Date"; Date)
        {
            Caption = 'Salary Due Posted Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date when the salary due was posted.';
        }
        field(24; "Salary Payment Document No."; Code[20])
        {
            Caption = 'Salary Payment Document No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary payment document number.';
        }
        field(25; "Salary Payment Date"; Date)
        {
            Caption = 'Salary Payment Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary payment date.';
        }
        field(26; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            ToolTip = 'Specifies the type of account.';
        }
        field(27; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner";
        }
        field(28; "Pay Method"; Option)
        {
            Caption = 'Pay Method';
            DataClassification = CustomerContent;
            OptionCaption = 'Cash,Cheque,Bank Transfer';
            OptionMembers = Cash,Cheque,"Bank Transfer";
            ToolTip = 'Specifies the payment method.';
        }
        field(29; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cheque number.';
        }
        field(30; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cheque date.';
        }
        field(31; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the entry has been posted.';
        }
        field(32; "Emp Posting Group"; Code[20])
        {
            Caption = 'Emp Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Payroll Employee Posting Group" WHERE("Location Code" = FIELD("Location Code"),
                                                                    "Salary Plan Code" = FIELD("Salary Plan Code"));
            ToolTip = 'Specifies the employee posting group.';
        }
        field(33; "Pay Bus. Posting Group"; Code[20])
        {
            Caption = 'Pay Bus. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Payroll Business Posting Group" WHERE("Location Code" = FIELD("Location Code"),
                                                                    "Salary Plan Code" = FIELD("Salary Plan Code"));
            ToolTip = 'Specifies the payroll business posting group.';
        }
        field(34; "Pay Element Description"; Text[50])
        {
            Caption = 'Pay Element Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the pay element.';
        }
        field(35; "Salary Due Entry"; Boolean)
        {
            Caption = 'Salary Due Entry';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Specifies whether this is a salary due entry.';
        }
        field(36; "Salary Payment Entry"; Boolean)
        {
            Caption = 'Salary Payment Entry';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Specifies whether this is a salary payment entry.';
        }
        field(37; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the sorting order.';
        }
        field(38; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary";
            ToolTip = 'Specifies the employee category.';
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

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Processed Salary", "Branch Code", FieldNumber, ShortcutDimCode);
        Modify();
    end;
}

