table 72101 "Income Tax"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    DrillDownPageID = 72138;
    LookupPageID = 72138;

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
        field(6; "Employee No"; Code[20])
        {
            TableRelation = Employee."No." WHERE ("No." = FILTER (<> ''));
        }
        field(7; Name; Text[50])
        {
        }
        field(8; Designation; Text[50])
        {
        }
        field(9; "P.A.N.No"; Code[20])
        {
        }
        field(10; Sex; Option)
        {
            OptionCaption = ' ,Female,Male,Sr.Citizen';
            OptionMembers = " ",Female,Male,"Sr.Citizen";
        }
        field(11; "Physically Handicapped"; Boolean)
        {
        }
        field(12; "Senior Citizen"; Boolean)
        {
        }
        field(13; "Projection Not Required"; Boolean)
        {
        }
        field(14; "Remaining Month for Projection"; Integer)
        {
        }
        field(15; "Last Month Gross Salary"; Decimal)
        {
        }
        field(16; "Salary Gross Earning Actual"; Decimal)
        {
        }
        field(17; "Salary Gross Earning Projected"; Decimal)
        {
        }
        field(18; "Salary Gross Earning Total"; Decimal)
        {
        }
        field(19; Bonus; Decimal)
        {
        }
        field(20; "Leave Salary"; Decimal)
        {
        }
        field(21; "Arrears Amount"; Decimal)
        {
        }
        field(22; "D.A Arrears - 1"; Decimal)
        {
        }
        field(23; "D.A Arrears - 2"; Decimal)
        {
        }
        field(24; "HRA Arrears"; Decimal)
        {
        }
        field(25; "Hon Amount"; Decimal)
        {
        }
        field(26; "Medical Reimburement"; Decimal)
        {
        }
        field(27; "Previous Job Earnings"; Decimal)
        {
        }
        field(28; LTA; Decimal)
        {
        }
        field(29; "Perk-1"; Decimal)
        {
        }
        field(30; "Perk-2"; Decimal)
        {
        }
        field(31; "Other Earnings-1"; Decimal)
        {
        }
        field(32; "Other Earnings-2"; Decimal)
        {
        }
        field(33; "Other Earnings Total"; Decimal)
        {
        }
        field(34; HRA; Decimal)
        {
        }
        field(35; "Conv.Allowance"; Decimal)
        {
        }
        field(36; "Transport Conveyance"; Decimal)
        {
        }
        field(37; "Exemptions Totals"; Decimal)
        {
        }
        field(38; "Professional Tax"; Decimal)
        {
        }
        field(39; "Entertainment Tax"; Decimal)
        {
        }
        field(40; "Gross Salary Income"; Decimal)
        {
        }
        field(41; "Housing Loan Interest"; Decimal)
        {
        }
        field(42; "Gross Total Income"; Decimal)
        {
        }
        field(43; "Actual - PF (Salary)"; Decimal)
        {
        }
        field(44; "Actual - PF (Direct)"; Decimal)
        {
        }
        field(45; "Actual - Total PF"; Decimal)
        {
        }
        field(46; "Actual - LIC Premium (Salary)"; Decimal)
        {
        }
        field(47; "Actual - LIC Premium (Direct)"; Decimal)
        {
        }
        field(48; "Actual - Total LIC Premium"; Decimal)
        {
        }
        field(49; "Actual - NSC (Direct)"; Decimal)
        {
        }
        field(50; "Actual - NSC Interest"; Decimal)
        {
        }
        field(51; "Actual - ULIP"; Decimal)
        {
        }
        field(52; "Actual - NSS Self"; Decimal)
        {
        }
        field(53; "Actual - Mutal Fund"; Decimal)
        {
        }
        field(54; "Actual -Housing Loan Principal"; Decimal)
        {
        }
        field(55; "Actual -Infra Development Bond"; Decimal)
        {
        }
        field(56; "Actual -Other 80 Deduction - 1"; Decimal)
        {
        }
        field(57; "Actual -Other 80 Deduction - 2"; Decimal)
        {
        }
        field(58; "Actual - Total 80 Deduction"; Decimal)
        {
        }
        field(59; "Actual - 80CCC (Pension Fund)"; Decimal)
        {
        }
        field(60; "Actual - 80D (Mediclaim)"; Decimal)
        {
        }
        field(61; "Actual - 80DD(Handicapped Dep)"; Decimal)
        {
        }
        field(62; "Actual - 80DDB(Medical Ex Spl)"; Decimal)
        {
        }
        field(63; "Actual - 80G (Donations)"; Decimal)
        {
        }
        field(64; "Actual - 80U(Physically Handi)"; Decimal)
        {
        }
        field(65; "Actual - Total 80A-Z Deduction"; Decimal)
        {
        }
        field(66; "Proj - PF (Salary)"; Decimal)
        {
        }
        field(67; "Proj - PF (Direct)"; Decimal)
        {
        }
        field(68; "Proj - Total PF"; Decimal)
        {
        }
        field(69; "Proj - LIC Premium (Salary)"; Decimal)
        {
        }
        field(70; "Proj - LIC Premium (Direct)"; Decimal)
        {
        }
        field(71; "Proj - Total LIC Premium"; Decimal)
        {
        }
        field(72; "Proj - NSC (Direct)"; Decimal)
        {
        }
        field(73; "Proj - NSC Interest"; Decimal)
        {
        }
        field(74; "Proj - ULIP"; Decimal)
        {
        }
        field(75; "Proj - NSS Self"; Decimal)
        {
        }
        field(76; "Proj - Mutal Fund"; Decimal)
        {
        }
        field(77; "Proj - Housing Loan Principal"; Decimal)
        {
        }
        field(78; "Proj - Infra Development Bond"; Decimal)
        {
        }
        field(79; "Proj - Other 80 Deduction - 1"; Decimal)
        {
        }
        field(80; "Proj - Other 80 Deduction - 2"; Decimal)
        {
        }
        field(81; "Proj - Total 80 Deduction"; Decimal)
        {
        }
        field(82; "Proj - 80CCC (Pension Fund)"; Decimal)
        {
        }
        field(83; "Proj - 80D (Mediclaim)"; Decimal)
        {
        }
        field(84; "Proj - 80DD(Handicapped Dep)"; Decimal)
        {
        }
        field(85; "Proj - 80DDB(Medical Ex Spl)"; Decimal)
        {
        }
        field(86; "Proj - 80G (Donations)"; Decimal)
        {
        }
        field(87; "Proj - 80U(Physically Handi)"; Decimal)
        {
        }
        field(88; "Proj - Total 80A-Z Deduction"; Decimal)
        {
        }
        field(89; "Taxable Income"; Decimal)
        {
        }
        field(90; "Income Tax Amount"; Decimal)
        {
        }
        field(91; "Higher Edu Cess Amount"; Decimal)
        {
        }
        field(92; "Cess Amount"; Decimal)
        {
        }
        field(93; "Surcharge Amount"; Decimal)
        {
        }
        field(94; "Total Tax Amount"; Decimal)
        {
        }
        field(95; "Tax Paid"; Decimal)
        {
        }
        field(96; "Tax Refund"; Decimal)
        {
        }
        field(97; "Tax Balance"; Decimal)
        {
        }
        field(98; "Tax Per Month"; Decimal)
        {
        }
        field(99; "Food Plus Card Allow"; Decimal)
        {
        }
        field(100; "Rent Received"; Decimal)
        {
        }
        field(101; "Medical Bill"; Decimal)
        {
        }
        field(102; "Medical Allow"; Decimal)
        {
        }
        field(103; "Proj -  80E (Educational Loan)"; Decimal)
        {
        }
        field(104; "Actu -  80E (Educational Loan)"; Decimal)
        {
        }
        field(105; Printed; Boolean)
        {
        }
        field(106; Verified; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Assessment Year", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmpRec: Record Employee;
}

