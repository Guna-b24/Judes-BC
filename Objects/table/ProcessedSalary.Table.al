table 72090 "Processed Salary"
{
    Caption = 'Processed Salary';
    DataClassification = CustomerContent;
    DataCaptionFields = "Employee No";
    // DrillDownPageID = 72124;
    // LookupPageID = 72124;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the location where the salary is processed.';
        }

        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary plan applicable for the employee.';
        }
        field(3; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            TableRelation = "Payroll Month & Year"."Salary Cyclic Code"
                WHERE("Location Code" = FIELD("Location Code"),
                      "Salary Plan Code" = FIELD("Salary Plan Code"));
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary processing cycle.';
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
        }

        field(7; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
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
            TableRelation = "Pay Elements"
                WHERE("Location Code" = FIELD("Location Code"),
                      "Salary Plan Code" = FIELD("Salary Plan Code"));
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary component.';
        }

        field(10; "Paid Category"; Option)
        {
            Caption = 'Paid Category';
            OptionCaption = 'Monthly,Yearly,Daily';
            OptionMembers = Monthly,Yearly,Daily;
            DataClassification = CustomerContent;
        }

        field(11; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
            DataClassification = CustomerContent;
        }
        field(12; "Fixed / Percent"; Option)
        {
            Caption = 'Fixed / Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
            DataClassification = CustomerContent;
        }

        field(13; "Amount Calculation Type"; Option)
        {
            Caption = 'Amount Calculation Type';
            OptionCaption = 'Pay Day,Full Amount';
            OptionMembers = "Pay Day","Full Amount";
            DataClassification = CustomerContent;
        }

        field(14; "Base Pay Elements"; Text[250])
        {
            Caption = 'Base Pay Elements';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Percentage (%)"; Decimal)
        {
            Caption = 'Percentage (%)';
            DataClassification = CustomerContent;
        }

        field(16; "Included In Pay Slip"; Boolean)
        {
            Caption = 'Included In Pay Slip';
            DataClassification = CustomerContent;
        }

        field(17; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
            DataClassification = CustomerContent;
        }
        field(18; "Total Days in a Month"; Integer)
        {
            Caption = 'Total Days in a Month';
            DataClassification = CustomerContent;
        }

        field(19; "Paid Days"; Decimal)
        {
            Caption = 'Paid Days';
            DataClassification = CustomerContent;
        }

        field(20; "Actual Amount"; Decimal)
        {
            Caption = 'Actual Amount';
            DataClassification = CustomerContent;
        }

        field(21; "Payable Amount"; Decimal)
        {
            Caption = 'Payable Amount';
            DataClassification = CustomerContent;
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
            ToolTip = 'Specifies the G/L or account number related to this entry.';
        }
        field(25; "Employee VPF Amount"; Decimal)
        {
            Caption = 'Employee VPF Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the voluntary provident fund amount contributed by the employee.';
        }

        field(26; "Employee PF / ESI Amount"; Decimal)
        {
            Caption = 'Employee PF / ESI Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF or ESI amount deducted from the employee salary.';
        }
        field(27; "Employer PF / ESI Amount"; Decimal)
        {
            Caption = 'Employer PF / ESI Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF or ESI amount contributed by the employer.';
        }

        field(28; "Employer EPS Amount"; Decimal)
        {
            Caption = 'Employer EPS Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employer contribution towards EPS.';
        }

        field(29; "PF Admin Charges Amount"; Decimal)
        {
            Caption = 'PF Admin Charges Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF administrative charges payable.';
        }
        field(30; "PF EDLI Amount"; Decimal)
        {
            Caption = 'PF EDLI Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF EDLI contribution amount.';
        }

        field(31; "PF RIFA Amount"; Decimal)
        {
            Caption = 'PF RIFA Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF RIFA contribution amount.';
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
            ToolTip = 'Specifies whether the processed salary line is related to a loan deduction.';
        }

        field(35; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            OptionCaption = 'Full Payment,First Payment,Second Payment';
            OptionMembers = "Full Payment","First Payment","Second Payment";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the payment is full, first installment, or second installment.';
        }

        field(36; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary,Class III Permanent,Class III Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary","Class III Permanent","Class III Temporary";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employment category of the employee for payroll processing.';
        }

        field(37; "Branch Code"; Code[10])
        {
            Caption = 'Branch Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the branch code associated with the employee salary.';
        }

        field(38; "PF Applicable"; Boolean)
        {
            Caption = 'PF Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether Provident Fund is applicable for this salary line.';
        }
        field(39; "Loan Id"; Code[20])
        {
            Caption = 'Loan Id';
            //TableRelation = "Employee Loans";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Salary Cycle Code", "Employee No", "Pay Element Code")
        {
            Clustered = true;
        }
        key(Key2; "Sorting Order", "Pay Element Code", "Pay Type")
        {
        }
        key(Key3; "Pay Type")
        {
            SumIndexFields = "Actual Amount", "Payable Amount";
        }
        key(Key4; "Employee No")
        {
        }
    }

    fieldgroups
    {
    }
}

