table 72096 "Final Settlement Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Final Settlement Line';

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(3; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
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
        field(8; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(9; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            NotBlank = true;
            TableRelation = "Pay Elements";
        }
        field(10; "Paid Category"; Option)
        {
            Caption = 'Paid Category';
            OptionCaption = 'Monthly,Yearly';
            OptionMembers = Monthly,Yearly;
        }
        field(11; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(12; "Fixed / Percent"; Option)
        {
            Caption = 'Fixed / Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
        }
        field(13; "Amount Calculation Type"; Option)
        {
            Caption = 'Amount Calculation Type';
            OptionCaption = 'Pay Day,Full Amount';
            OptionMembers = "Pay Day","Full Amount";
        }
        field(14; "Base Pay Elements"; Text[250])
        {
            Caption = 'Base Pay Elements';
            Editable = false;
        }
        field(15; "Percentage (%)"; Decimal)
        {
            Caption = 'Percentage (%)';
        }
        field(16; "Included In Pay Slip"; Boolean)
        {
            Caption = 'Included In Pay Slip';
        }
        field(17; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
        }
        field(18; "Total Days in a Month"; Integer)
        {
            Caption = 'Total Days in a Month';
        }
        field(19; "Paid Days"; Decimal)
        {
            Caption = 'Paid Days';
        }
        field(20; "Actual Amount"; Decimal)
        {
            Caption = 'Actual Amount';

            trigger OnValidate()
            begin
                if "Pay Type" = "Pay Type"::Deduction then
                    "Actual Amount" := -"Actual Amount";
            end;
        }
        field(21; "Payable Amount"; Decimal)
        {
            Caption = 'Payable Amount';

            trigger OnValidate()
            begin
                if "Pay Type" = "Pay Type"::Deduction then
                    "Payable Amount" := -"Payable Amount";
            end;
        }
        field(22; "PF / ESI / PT Gross Earnings"; Decimal)
        {
            Caption = 'PF / ESI / PT Gross Earnings';
        }
        field(23; "EPS Gross Earnings"; Decimal)
        {
            Caption = 'EPS Gross Earnings';
        }
        field(24; "Account No."; Code[20])
        {
            Caption = 'Account No.';
        }
        field(25; "Employee VPF Amount"; Decimal)
        {
            Caption = 'Employee VPF Amount';
        }
        field(26; "Employee PF / ESI Amount"; Decimal)
        {
            Caption = 'Employee PF / ESI Amount';
        }
        field(27; "Employer PF / ESI Amount"; Decimal)
        {
            Caption = 'Employer PF / ESI Amount';
        }
        field(28; "Employer EPS Amount"; Decimal)
        {
            Caption = 'Employer EPS Amount';
        }
        field(29; "PF Admin Charges Amount"; Decimal)
        {
            Caption = 'PF Admin Charges Amount';
        }
        field(30; "PF EDLI Amount"; Decimal)
        {
            Caption = 'PF EDLI Amount';
        }
        field(31; "PF RIFA Amount"; Decimal)
        {
            Caption = 'PF RIFA Amount';
        }
        field(32; "Salary Processed"; Boolean)
        {
            Caption = 'Salary Processed';
        }
        field(33; "Salary Posted"; Boolean)
        {
            Caption = 'Salary Posted';
        }
        field(34; Loan; Boolean)
        {
            Caption = 'Loan';
        }
        field(35; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            OptionCaption = 'Full Payment,First Payment,Second Payment';
            OptionMembers = "Full Payment","First Payment","Second Payment";
        }
        field(36; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Worker Permanent,Worker Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Worker Permanent","Worker Temporary";
        }
        field(37; Description; Text[50])
        {
            Caption = 'Description';
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

