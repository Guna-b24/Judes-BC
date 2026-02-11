table 72096 "Final Settlement Line"
{
    Caption = 'Final Settlement Line';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the payroll location.';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the salary plan.';
        }
        field(3; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the salary cycle.';
        }
        field(4; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll period start date.';
        }
        field(5; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll period end date.';
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
        field(8; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            NotBlank = true;
            TableRelation = Employee;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee number.';
        }
        field(9; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            NotBlank = true;
            TableRelation = "Pay Elements";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the salary pay element.';
        }
        field(10; "Paid Category"; Option)
        {
            Caption = 'Paid Category';
            OptionMembers = Monthly,Yearly;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the payment is monthly or yearly.';
        }
        field(11; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            OptionMembers = Addition,Deduction,Reimbursement;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the amount is an addition, deduction, or reimbursement.';
        }
        field(12; "Fixed / Percent"; Option)
        {
            Caption = 'Fixed / Percent';
            OptionMembers = "Fixed",Percent;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the amount is fixed or percentage based.';
        }
        field(13; "Amount Calculation Type"; Option)
        {
            Caption = 'Amount Calculation Type';
            OptionMembers = "Pay Day","Full Amount";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies how the amount is calculated.';
        }
        field(14; "Base Pay Elements"; Text[250])
        {
            Caption = 'Base Pay Elements';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Shows the base pay elements used for calculation.';
        }
        field(15; "Percentage (%)"; Decimal)
        {
            Caption = 'Percentage (%)';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the percentage value.';
        }
        field(16; "Included In Pay Slip"; Boolean)
        {
            Caption = 'Included In Pay Slip';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the element appears in the payslip.';
        }
        field(17; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
            DataClassification = SystemMetadata;
            ToolTip = 'Controls the display order.';
        }
        field(18; "Total Days in a Month"; Integer)
        {
            Caption = 'Total Days in a Month';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total working days in the month.';
        }
        field(19; "Paid Days"; Decimal)
        {
            Caption = 'Paid Days';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number of paid days.';
        }
        field(20; "Actual Amount"; Decimal)
        {
            Caption = 'Actual Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the calculated actual amount.';

            trigger OnValidate()
            begin
                if "Pay Type" = "Pay Type"::Deduction then
                    "Actual Amount" := -"Actual Amount";
            end;
        }
        field(21; "Payable Amount"; Decimal)
        {
            Caption = 'Payable Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the final payable amount.';

            trigger OnValidate()
            begin
                if "Pay Type" = "Pay Type"::Deduction then
                    "Payable Amount" := -"Payable Amount";
            end;
        }
        field(22; "PF / ESI / PT Gross Earnings"; Decimal)
        {
            Caption = 'PF / ESI / PT Gross Earnings';
            DataClassification = CustomerContent;
        }
        field(23; "EPS Gross Earnings"; Decimal)
        {
            Caption = 'EPS Gross Earnings';
            DataClassification = CustomerContent;
        }
        field(24; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
        }
        field(25; "Employee VPF Amount"; Decimal)
        {
            Caption = 'Employee VPF Amount';
            DataClassification = CustomerContent;
        }
        field(26; "Employee PF / ESI Amount"; Decimal)
        {
            Caption = 'Employee PF / ESI Amount';
            DataClassification = CustomerContent;
        }
        field(27; "Employer PF / ESI Amount"; Decimal)
        {
            Caption = 'Employer PF / ESI Amount';
            DataClassification = CustomerContent;
        }
        field(28; "Employer EPS Amount"; Decimal)
        {
            Caption = 'Employer EPS Amount';
            DataClassification = CustomerContent;
        }
        field(29; "PF Admin Charges Amount"; Decimal)
        {
            Caption = 'PF Admin Charges Amount';
            DataClassification = CustomerContent;
        }
        field(30; "PF EDLI Amount"; Decimal)
        {
            Caption = 'PF EDLI Amount';
            DataClassification = CustomerContent;
        }
        field(31; "PF RIFA Amount"; Decimal)
        {
            Caption = 'PF RIFA Amount';
            DataClassification = CustomerContent;
        }
        field(32; "Salary Processed"; Boolean)
        {
            Caption = 'Salary Processed';
            DataClassification = CustomerContent;
        }
        field(33; "Salary Posted"; Boolean)
        {
            Caption = 'Salary Posted';
            DataClassification = CustomerContent;
        }
        field(34; Loan; Boolean)
        {
            Caption = 'Loan';
            DataClassification = CustomerContent;
        }
        field(35; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Full Payment,First Payment,Second Payment';
            OptionMembers = "Full Payment","First Payment","Second Payment";
        }
        field(36; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Worker Permanent,Worker Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Worker Permanent","Worker Temporary";
        }
        field(37; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Salary Cycle Code", "Employee No", "Pay Element Code")
        {
            Clustered = true;
        }
        key(Key2; "Pay Type", "Sorting Order")
        {
            SumIndexFields = "Payable Amount";
        }
    }

    fieldgroups
    {
    }
}

