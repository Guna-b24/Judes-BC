table 72102 "Income Tax Challan Details"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------


    fields
    {
        field(1; "Location Code"; Code[20])
        {
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            TableRelation = "Salary Plan";
        }
        field(3; "Assessment Year"; Code[20])
        {
            TableRelation = "Payroll Year"."Year Code" WHERE ("Location Code" = FIELD ("Location Code"),
                                                              "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                              "Year Type" = CONST ("Income Tax Year"));
        }
        field(4; "Salary Year"; Code[20])
        {
            TableRelation = "Payroll Year"."Year Code" WHERE ("Location Code" = FIELD ("Location Code"),
                                                              "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                              "Year Type" = CONST ("Salary Year"));
        }
        field(5; "Salary Cyclic Code"; Code[20])
        {
            TableRelation = "Payroll Month & Year"."Salary Cyclic Code" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                               "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(6; "Challan Process Year"; Integer)
        {
        }
        field(7; "Challan Process Month"; Integer)
        {
        }
        field(8; "Employe No"; Code[20])
        {
            TableRelation = Employee;
        }
        field(9; "Taxable Gross Salary"; Decimal)
        {
        }
        field(10; "Section Code"; Code[20])
        {
        }
        field(11; "Voucher / Challan No"; Code[20])
        {
        }
        field(12; "Voucher / Challan Date"; Date)
        {
        }
        field(13; "Bank Code"; Code[20])
        {
        }
        field(14; "Challan Income Tax"; Decimal)
        {
        }
        field(15; "Challan Surcharge"; Decimal)
        {
        }
        field(16; "Challan ECess"; Decimal)
        {
        }
        field(17; "Challan Interest Amount"; Decimal)
        {
        }
        field(18; "Challan Other Amount"; Decimal)
        {
        }
        field(19; "Total Deposit Amount as Vouche"; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Deposit Amount as Vouche" := "Challan Income Tax" + "Challan Surcharge" + "Challan ECess";
            end;
        }
        field(20; "Total Deposit as Deductee"; Decimal)
        {
        }
        field(21; "TDS/TCS Income Tax"; Decimal)
        {
        }
        field(22; "TDS/TCS Surcharge"; Decimal)
        {
        }
        field(23; "TDS/TCS Cess"; Decimal)
        {
        }
        field(24; "Total Income Tax"; Decimal)
        {
        }
        field(25; "TDS/TCS Interest Amount"; Decimal)
        {
        }
        field(26; "TDS/TCS Others"; Decimal)
        {
        }
        field(27; "Cheque / DD No."; Code[20])
        {
        }
        field(28; "Bank/Cash"; Option)
        {
            OptionMembers = " ",Cheque,Cash;
        }
        field(29; Post; Boolean)
        {
        }
        field(30; "Salary Paid Date"; Date)
        {
        }
        field(31; Select; Boolean)
        {
        }
        field(32; "Pay Element Code"; Code[20])
        {
        }
        field(33; "Total Challan Amount"; Decimal)
        {
        }
        field(34; "Quarterly Code"; Option)
        {
            OptionMembers = Q1,Q2,Q3,Q4;
        }
        field(35; "Employee Code"; Code[20])
        {
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

