table 72115 "Salary Posting"
{
    Caption = 'Salary Posting';
    DataClassification = CustomerContent;
    LookupPageId = "Salary Posting Worksheet";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the location for the salary posting.';
        }

        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary plan associated with this posting.';
        }
        field(3; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            TableRelation = "Payroll Month & Year" WHERE("Location Code" = FIELD("Location Code"),
                                                          "Salary Plan Code" = FIELD("Salary Plan Code"));

            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary cycle for the selected location and salary plan.';
        }
        field(4; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the start date of the payroll period.';
        }

        field(5; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the end date of the payroll period.';
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
            TableRelation = "Dimension Value"
                WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the branch dimension value.';
        }

        field(9; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            NotBlank = true;
            TableRelation = "Pay Elements"
                WHERE("Location Code" = FIELD("Location Code"),
                       "Salary Plan Code" = FIELD("Salary Plan Code"));
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the pay element for this posting.';
        }

        field(10; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            OptionMembers = Addition,Deduction,Reimbursement;
            OptionCaption = 'Addition,Deduction,Reimbursement';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the pay element is an addition, deduction, or reimbursement.';
        }

        field(11; "Actual Amount"; Decimal)
        {
            Caption = 'Actual Amount';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the calculated actual salary amount.';
        }

        field(12; "Payable Amount"; Decimal)
        {
            Caption = 'Payable Amount';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the net payable salary amount.';
        }
        field(13; "Employee VPF Amount"; Decimal)
        {
            Caption = 'Employee VPF Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the net Employee VPF Amount.';
        }
        field(14; "Employee PF / ESI Amount"; Decimal)
        {
            Caption = 'Employee PF / ESI Amount';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee contribution towards PF or ESI.';
        }

        field(15; "Employer PF / ESI Amount"; Decimal)
        {
            Caption = 'Employer PF / ESI Amount';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employer contribution towards PF or ESI.';
        }

        field(16; "Employer EPS Amount"; Decimal)
        {
            Caption = 'Employer EPS Amount';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employer EPS contribution amount.';
        }
        field(17; "PF Admin Charges Amount"; Decimal)
        {
            Caption = 'PF Admin Charges Amount';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF administrative charges amount.';
        }

        field(18; "PF EDLI Amount"; Decimal)
        {
            Caption = 'PF EDLI Amount';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF EDLI contribution amount.';
        }

        field(19; "PF RIFA Amount"; Decimal)
        {
            Caption = 'PF RIFA Amount';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF RIFA contribution amount.';
        }
        field(20; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the general journal batch used for posting.';
        }

        field(21; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the general journal template used for posting.';
        }

        field(22; "Salary Due Document No"; Code[20])
        {
            Caption = 'Salary Due Document No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the document number created for salary due posting.';
        }

        field(23; "Salary Due Posted Date"; Date)
        {
            Caption = 'Salary Due Posted Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date when salary due was posted.';
        }

        field(24; "Salary Payment Document No."; Code[20])
        {
            Caption = 'Salary Payment Document No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the document number created for salary payment.';
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
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the account type used for posting.';
        }
        field(27; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the account number used for posting.';
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
            OptionMembers = Cash,Cheque,"Bank Transfer";
            OptionCaption = 'Cash,Cheque,Bank Transfer';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payment method.';
        }

        field(29; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cheque number if payment method is cheque.';
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
        }
        field(32; "Emp Posting Group"; Code[20])
        {
            Caption = 'Employee Posting Group';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee posting group.';
            TableRelation = "Payroll Employee Posting Group" WHERE("Location Code" = FIELD("Location Code"),
                                                                    "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(33; "Pay Bus. Posting Group"; Code[20])
        {
            Caption = 'Pay Business Posting Group';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the pay business posting group.';
            TableRelation = "Payroll Business Posting Group" WHERE("Location Code" = FIELD("Location Code"),
                                                                    "Salary Plan Code" = FIELD("Salary Plan Code"));
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
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether a salary due entry is created.';
        }

        field(36; "Salary Payment Entry"; Boolean)
        {
            Caption = 'Salary Payment Entry';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether a salary payment entry is created.';
        }

        field(37; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the sorting order for processing.';
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Salary Cycle Code", "Branch Code", "Pay Type", "Sorting Order")
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

