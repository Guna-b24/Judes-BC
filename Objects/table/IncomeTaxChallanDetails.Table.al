table 72102 "Income Tax Challan Details"
{
    Caption = 'Income Tax Challan Details';
    DataClassification = CustomerContent;
    DrillDownPageId = "Income Tax Challan List";
    LookupPageId = "Income Tax Challan List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the payroll location for the income tax challan.';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            ToolTip = 'Specifies the salary plan applicable for tax deduction.';
            TableRelation = "Salary Plan";
        }
        field(3; "Assessment Year"; Code[20])
        {
            Caption = 'Assessment Year';
            ToolTip = 'Specifies the income tax assessment year.';
            TableRelation = "Payroll Year"."Year Code" WHERE("Location Code" = FIELD("Location Code"),
                                                              "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                              "Year Type" = CONST("Income Tax Year"));
        }
        field(4; "Salary Year"; Code[20])
        {
            Caption = 'Salary Year';
            ToolTip = 'Specifies the salary year for which tax is calculated.';
            TableRelation = "Payroll Year"."Year Code" WHERE("Location Code" = FIELD("Location Code"),
                                                              "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                              "Year Type" = CONST("Salary Year"));
        }
        field(5; "Salary Cyclic Code"; Code[20])
        {
            Caption = 'Salary Cyclic Code';
            ToolTip = 'Specifies the payroll cycle for tax deduction.';
            TableRelation = "Payroll Month & Year"."Salary Cyclic Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                               "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(6; "Challan Process Year"; Integer)
        {
            Caption = 'Challan Process Year';
            ToolTip = 'Specifies the year in which the challan was processed.';
        }
        field(7; "Challan Process Month"; Integer)
        {
            Caption = 'Challan Process Month';
            ToolTip = 'Specifies the month in which the challan was processed.';
        }
        field(8; "Employe No"; Code[20])
        {
            Caption = 'Employee No.';
            ToolTip = 'Specifies the employee for whom the tax challan is created.';
            TableRelation = Employee;
        }
        field(9; "Taxable Gross Salary"; Decimal)
        {
            Caption = 'Taxable Gross Salary';
            ToolTip = 'Specifies the taxable gross salary amount.';
        }
        field(10; "Section Code"; Code[20])
        {
            Caption = 'Section Code';
            ToolTip = 'Specifies the income tax section applicable.';
        }
        field(11; "Voucher / Challan No"; Code[20])
        {
            Caption = 'Voucher / Challan No.';
            ToolTip = 'Specifies the voucher or challan reference number.';
        }
        field(12; "Voucher / Challan Date"; Date)
        {
            Caption = 'Voucher / Challan Date';
            ToolTip = 'Specifies the date of the voucher or challan.';
        }
        field(13; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            ToolTip = 'Specifies the bank through which tax is remitted.';
        }
        field(14; "Challan Income Tax"; Decimal)
        {
            Caption = 'Challan Income Tax';
            ToolTip = 'Specifies the income tax amount paid through challan.';
        }
        field(15; "Challan Surcharge"; Decimal)
        {
            Caption = 'Challan Surcharge';
            ToolTip = 'Specifies the surcharge amount paid through challan.';
        }
        field(16; "Challan ECess"; Decimal)
        {
            Caption = 'Challan Education Cess';
            ToolTip = 'Specifies the education cess amount paid through challan.';
        }
        field(17; "Challan Interest Amount"; Decimal)
        {
            Caption = 'Challan Interest Amount';
            ToolTip = 'Specifies the interest amount paid through challan.';
        }
        field(18; "Challan Other Amount"; Decimal)
        {
            Caption = 'Challan Other Amount';
            ToolTip = 'Specifies other tax-related amounts paid through challan.';
        }
        field(19; "Total Deposit Amount as Vouche"; Decimal)
        {
            Caption = 'Total Deposit Amount as Voucher';
            ToolTip = 'Specifies the total deposit amount as per voucher.';
            trigger OnValidate()
            begin
                "Total Deposit Amount as Vouche" := "Challan Income Tax" + "Challan Surcharge" + "Challan ECess";
            end;
        }
        field(20; "Total Deposit as Deductee"; Decimal)
        {
            Caption = 'Total Deposit as Deductee';
            ToolTip = 'Specifies the total deposit amount as per deductee.';
        }
        field(21; "TDS/TCS Income Tax"; Decimal)
        {
            Caption = 'TDS/TCS Income Tax';
            ToolTip = 'Specifies income tax deducted or collected at source.';
        }
        field(22; "TDS/TCS Surcharge"; Decimal)
        {
            Caption = 'TDS/TCS Surcharge';
            ToolTip = 'Specifies surcharge deducted or collected at source.';
        }
        field(23; "TDS/TCS Cess"; Decimal)
        {
            Caption = 'TDS/TCS Cess';
            ToolTip = 'Specifies cess deducted or collected at source.';
        }
        field(24; "Total Income Tax"; Decimal)
        {
            Caption = 'Total Income Tax';
            ToolTip = 'Specifies the total income tax amount.';
        }
        field(25; "TDS/TCS Interest Amount"; Decimal)
        {
            Caption = 'TDS/TCS Interest Amount';
            ToolTip = 'Specifies interest amount under TDS or TCS.';
        }
        field(26; "TDS/TCS Others"; Decimal)
        {
            Caption = 'TDS/TCS Other Amount';
            ToolTip = 'Specifies other TDS or TCS related amounts.';
        }
        field(27; "Cheque / DD No."; Code[20])
        {
            Caption = 'Cheque / DD No.';
            ToolTip = 'Specifies the cheque or demand draft number.';
        }
        field(28; "Bank/Cash"; Option)
        {
            Caption = 'Payment Mode';
            ToolTip = 'Specifies whether payment was made by bank or cash.';
            OptionMembers = " ",Cheque,Cash;
        }
        field(29; Post; Boolean)
        {
            Caption = 'Posted';
            ToolTip = 'Specifies whether the challan entry is posted.';
        }
        field(30; "Salary Paid Date"; Date)
        {
            Caption = 'Salary Paid Date';
            ToolTip = 'Specifies the date on which salary was paid.';
        }
        field(31; Select; Boolean)
        {
            Caption = 'Select';
            ToolTip = 'Specifies whether the record is selected for processing.';
        }
        field(32; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            ToolTip = 'Specifies the pay element associated with the challan.';
        }
        field(33; "Total Challan Amount"; Decimal)
        {
            Caption = 'Total Challan Amount';
            ToolTip = 'Specifies the total amount paid through the challan.';
        }
        field(34; "Quarterly Code"; Option)
        {
            Caption = 'Quarter';
            ToolTip = 'Specifies the financial quarter for tax reporting.';
            OptionMembers = Q1,Q2,Q3,Q4;
        }
        field(35; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            ToolTip = 'Specifies the employee code for reference.';
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Assessment Year", "Salary Cyclic Code", "Employe No")
        {
            Clustered = true;
        }
        key(Key2; "Employe No", "Quarterly Code", "Location Code", "Salary Plan Code", "Assessment Year", "Salary Cyclic Code")
        {
        }
        key(Key3; "Employe No", "Salary Cyclic Code")
        {
        }
        key(Key4; "Employee Code", "Quarterly Code")
        {
        }
    }

    fieldgroups
    {
    }
}

