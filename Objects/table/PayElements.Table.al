table 72060 "Pay Elements"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.

    Caption = 'Pay Elements';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Pay Element Code", Description;
    DrillDownPageID = 72076;
    LookupPageID = 72076;

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
        field(3; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            NotBlank = true;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Pay Slip Printing Caption"; Code[20])
        {
            Caption = 'Pay Slip Printing Caption';
        }
        field(6; "Paid Category"; Option)
        {
            Caption = 'Paid Category';
            InitValue = Monthly;
            OptionCaption = 'Monthly,Yearly,Daily';
            OptionMembers = Monthly,Yearly,Daily;
        }
        field(7; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(8; "Fixed/Percent"; Option)
        {
            Caption = 'Fixed/Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
        }
        field(9; "Base Pay Elements"; Text[250])
        {
            Caption = 'Base Pay Elements';
            TableRelation = "Pay Elements" WHERE ("Paid Category" = CONST (Monthly),
                                                  "Pay Type" = CONST (Addition));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(10; "Base Amount ( For % )"; Decimal)
        {
            Caption = 'Base Amount ( For % )';
            Editable = false;
        }
        field(11; "Percent (%)"; Decimal)
        {
            Caption = 'Percent (%)';
            MaxValue = 100;
            MinValue = 0;
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(13; "Amount Calculation Type"; Option)
        {
            Caption = 'Amount Calculation Type';
            OptionCaption = 'Pay Day,Full Amount';
            OptionMembers = "Pay Day","Full Amount";
        }
        field(14; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
        }
        field(15; "Regular Element"; Boolean)
        {
            Caption = 'Regular Element';
        }
        field(16; "Variable Element"; Boolean)
        {
            Caption = 'Variable Element';
        }
        field(17; "Loan Element"; Boolean)
        {
            Caption = 'Loan Element';
        }
        field(18; "Eligible for ESI Earnings"; Boolean)
        {
            Caption = 'Eligible for ESI Earnings';
        }
        field(19; "Eligible for PF"; Boolean)
        {
            Caption = 'Eligible for PF';
        }
        field(20; "Eligible for PT"; Boolean)
        {
            Caption = 'Eligible for PT';
        }
        field(21; "Eligible for OT"; Boolean)
        {
            Caption = 'Eligible for OT';
        }
        field(22; "Eligible for Bonus"; Boolean)
        {
            Caption = 'Eligible for Bonus';
        }
        field(23; "Eligible for Leave Encashment"; Boolean)
        {
            Caption = 'Eligible for Leave Encashment';
        }
        field(24; "Eligible for Gratuity"; Boolean)
        {
            Caption = 'Eligible for Gratuity';
        }
        field(25; "Eligible for Income Tax"; Boolean)
        {
            Caption = 'Eligible for Income Tax';
        }
        field(26; "Included In Pay Slip"; Boolean)
        {
            Caption = 'Included In Pay Slip';
        }
        field(27; "Excluded In Pay Slip"; Boolean)
        {
            Caption = 'Excluded In Pay Slip';
        }
        field(28; "All Grade"; Boolean)
        {
            Caption = 'All Grade';
        }
        field(29; "Predefined Code"; Boolean)
        {
            Caption = 'Predefined Code';
            Editable = false;
        }
        field(30; "Pay Prod. Posting Group"; Code[20])
        {
            Caption = 'Pay Prod. Posting Group';
            TableRelation = "Payroll Product Posting Group" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                   "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(31; "GL Code"; Code[20])
        {
            Caption = 'GL Code';
            TableRelation = "G/L Account";
        }
        field(32; "Income Tax Link Code"; Option)
        {
            Caption = 'Income Tax Link Code';
            OptionCaption = ' ,E-01,E-02,E-03,E-04,E-05,E-06,E-07,E-08,E-09,E-10,E-11,E-12,E-13,E-14,E-15,E-16,E-17,E-18,E-19,E-20,E-21,E-22,D-01,D-02,D-03';
            OptionMembers = " ","E-01","E-02","E-03","E-04","E-05","E-06","E-07","E-08","E-09","E-10","E-11","E-12","E-13","E-14","E-15","E-16","E-17","E-18","E-19","E-20","E-21","E-22","D-01","D-02","D-03";
        }
        field(33; Select; Boolean)
        {
            Caption = 'Select';
        }
        field(34; "Eligible for Credit Days"; Boolean)
        {
            Caption = 'Eligible for Credit Days';
        }
        field(35; "Eligible for ESI Limit Amount"; Boolean)
        {
            Caption = 'Eligible for ESI Limit Amount';
        }
        field(36; "Fixed Pay Element"; Boolean)
        {
            Caption = 'Fixed Pay Element';
        }
        field(37; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            OptionCaption = 'Full Payment,First Payment,Second Payment';
            OptionMembers = "Full Payment","First Payment","Second Payment";
        }
        field(38; "Gross Amount Pay Elements"; Boolean)
        {
            Caption = 'Gross Amount Pay Elements';
        }
        field(39; "Daily Wages Pay Elements"; Boolean)
        {
            Caption = 'Daily Wages Pay Elements';
        }
        field(40; "No of Day for DA"; Decimal)
        {
            Caption = 'No of Day for DA';
            MaxValue = 31;
            MinValue = 0;
        }
        field(41; "Eligible for Layoff"; Boolean)
        {
            Caption = 'Eligible for Layoff';
        }
        field(42; "Eligible for Extra Allowances"; Boolean)
        {
            Caption = 'Eligible for Extra Allowances';
        }
    }

    keys
    {
        key(Key1; "Pay Element Code", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
        key(Key2; "Sorting Order", "Pay Element Code")
        {
        }
    }

    fieldgroups
    {
    }
}

