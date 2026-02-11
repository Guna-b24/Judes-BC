table 72101 "Income Tax"
{
    Caption = 'Income Tax';
    DataClassification = CustomerContent;
    DataCaptionFields = "Employee No", Name, "Assessment Year";
    // DrillDownPageID = 72138;
    // LookupPageID = 72138;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the payroll location for which income tax is calculated.';
            DataClassification = CustomerContent;
            TableRelation = "Location HR & Payroll Setup";
        }

        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            ToolTip = 'Specifies the salary plan applicable to the employee.';
            DataClassification = CustomerContent;
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
            ToolTip = 'Specifies the income tax Salary year.';
            TableRelation = "Payroll Year"."Year Code" WHERE("Location Code" = FIELD("Location Code"),
                                                              "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                              "Year Type" = CONST("Salary Year"));
        }
        field(5; "Salary Cyclic Code"; Code[20])
        {
            Caption = 'Salary Cyclic Code';
            ToolTip = 'Specifies the income tax Salary Cyclic Code.';
            TableRelation = "Payroll Month & Year"."Salary Cyclic Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                               "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(6; "Employee No"; Code[20])
        {
            Caption = 'Employee No.';
            ToolTip = 'Specifies the employee for whom income tax is calculated.';
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
        }
        field(7; Name; Text[50])
        {
            Caption = 'Employee Name';
            ToolTip = 'Specifies the name of the employee.';
            DataClassification = CustomerContent;
        }
        field(8; Designation; Text[50])
        {
            Caption = 'Designation';
            ToolTip = 'Specifies the designation of the employee.';
            DataClassification = CustomerContent;
        }
        field(9; "P.A.N.No"; Code[20])
        {
            Caption = 'PAN No.';
            ToolTip = 'Specifies the Permanent Account Number of the employee.';
            // DataClassification = SensitivePersonalData;
        }
        field(10; Sex; Option)
        {
            Caption = 'Gender';
            ToolTip = 'Specifies the gender category for tax calculation.';
            OptionCaption = ' ,Female,Male,Senior Citizen';
            OptionMembers = " ",Female,Male,"Sr.Citizen";
        }
        field(11; "Physically Handicapped"; Boolean)
        {
            Caption = 'Physically Handicapped';
            ToolTip = 'Specifies whether the employee is physically handicapped.';

        }

        field(12; "Senior Citizen"; Boolean)
        {
            Caption = 'Senior Citizen';
            ToolTip = 'Specifies whether the employee is a senior citizen.';

        }

        field(13; "Projection Not Required"; Boolean)
        {
            Caption = 'Projection Not Required';
            ToolTip = 'Specifies whether salary projection is skipped.';
            DataClassification = CustomerContent;
        }

        field(14; "Remaining Month for Projection"; Integer)
        {
            Caption = 'Remaining Months';
            ToolTip = 'Specifies remaining months for salary projection.';
            DataClassification = CustomerContent;
        }
        field(15; "Last Month Gross Salary"; Decimal)
        {
            Caption = 'Last Month Gross Salary';
            ToolTip = 'Specifies gross salary of the last processed month.';
            DataClassification = CustomerContent;
        }
        field(16; "Salary Gross Earning Actual"; Decimal)
        {
            Caption = 'Actual Gross Salary';
            ToolTip = 'Specifies the actual gross salary earned during the year.';
            DataClassification = CustomerContent;
        }
        field(17; "Salary Gross Earning Projected"; Decimal)
        {
            Caption = 'Projected Gross Salary';
            ToolTip = 'Specifies the projected gross salary for remaining months.';
            DataClassification = CustomerContent;
        }
        field(18; "Salary Gross Earning Total"; Decimal)
        {
            Caption = 'Total Gross Salary';
            DataClassification = CustomerContent;
        }
        field(19; Bonus; Decimal)
        {
            Caption = 'Bonus';
            ToolTip = 'Specifies bonus amount.';
            DataClassification = CustomerContent;
        }

        field(20; "Leave Salary"; Decimal)
        {
            Caption = 'Leave Salary';
            ToolTip = 'Specifies leave salary amount.';
            DataClassification = CustomerContent;
        }
        field(21; "Arrears Amount"; Decimal)
        {
            Caption = 'Arrears Amount';
            ToolTip = 'Specifies salary arrears amount.';
            DataClassification = CustomerContent;
        }
        field(22; "D.A Arrears - 1"; Decimal)
        {
            Caption = 'DA Arrears 1';
            ToolTip = 'Specifies the first installment of dearness allowance arrears.';
        }
        field(23; "D.A Arrears - 2"; Decimal)
        {
            Caption = 'DA Arrears 2';
            ToolTip = 'Specifies the second installment of dearness allowance arrears.';
        }
        field(24; "HRA Arrears"; Decimal)
        {
            Caption = 'HRA Arrears';
            ToolTip = 'Specifies house rent allowance arrears.';
        }
        field(25; "Hon Amount"; Decimal)
        {
            Caption = 'Honorarium Amount';
            ToolTip = 'Specifies the honorarium amount paid to the employee.';
        }
        field(26; "Medical Reimburement"; Decimal)
        {
            Caption = 'Medical Reimbursement';
            ToolTip = 'Specifies medical reimbursement claimed by the employee.';
        }
        field(27; "Previous Job Earnings"; Decimal)
        {
            Caption = 'Previous Job Earnings';
            ToolTip = 'Specifies income earned from the employee’s previous employment.';
        }
        field(28; LTA; Decimal)
        {
            Caption = 'LTA';
            ToolTip = 'Specifies leave travel allowance amount.';
        }
        field(29; "Perk-1"; Decimal)
        {
            Caption = 'Perquisite 1';
            ToolTip = 'Specifies taxable perquisite amount.';
        }
        field(30; "Perk-2"; Decimal)
        {
            Caption = 'Perquisite 2';
            ToolTip = 'Specifies additional taxable perquisite amount.';
        }
        field(31; "Other Earnings-1"; Decimal)
        {
            Caption = 'Other Earnings 1';
            ToolTip = 'Specifies other earnings included in income.';
        }
        field(32; "Other Earnings-2"; Decimal)
        {
            Caption = 'Other Earnings 2';
            ToolTip = 'Specifies additional other earnings.';
        }
        field(33; "Other Earnings Total"; Decimal)
        {
            Caption = 'Other Earnings Total';
            ToolTip = 'Specifies total of all other earnings.';
        }
        field(34; HRA; Decimal)
        {
            Caption = 'House Rent Allowance';
            ToolTip = 'Specifies house rent allowance amount.';
        }
        field(35; "Conv.Allowance"; Decimal)
        {
            Caption = 'Conveyance Allowance';
            ToolTip = 'Specifies conveyance allowance amount.';
        }
        field(36; "Transport Conveyance"; Decimal)
        {
            Caption = 'Transport Allowance';
            ToolTip = 'Specifies transport allowance amount.';
        }
        field(37; "Exemptions Totals"; Decimal)
        {
            Caption = 'Total Exemptions';
            ToolTip = 'Specifies total exempted income amounts.';
        }
        field(38; "Professional Tax"; Decimal)
        {
            Caption = 'Professional Tax';
            ToolTip = 'Specifies professional tax deducted.';
        }
        field(39; "Entertainment Tax"; Decimal)
        {
            Caption = 'Entertainment Tax';
            ToolTip = 'Specifies entertainment tax deduction.';
        }
        field(40; "Gross Salary Income"; Decimal)
        {
            Caption = 'Gross Salary Income';
            ToolTip = 'Specifies gross salary after exemptions.';
        }
        field(41; "Housing Loan Interest"; Decimal)
        {
            Caption = 'Housing Loan Interest';
            ToolTip = 'Specifies interest paid on housing loan.';
        }
        field(42; "Gross Total Income"; Decimal)
        {
            Caption = 'Gross Total Income';
            ToolTip = 'Specifies total income before deductions.';
        }
        field(43; "Actual - PF (Salary)"; Decimal)
        {
            Caption = 'Actual PF (Salary)';
            ToolTip = 'Specifies actual provident fund contribution through salary.';
        }
        field(44; "Actual - PF (Direct)"; Decimal)
        {
            Caption = 'Actual PF (Direct)';
            ToolTip = 'Specifies direct provident fund contribution.';
        }
        field(45; "Actual - Total PF"; Decimal)
        {
            Caption = 'Actual Total PF';
            ToolTip = 'Specifies total actual provident fund contribution.';
        }
        field(46; "Actual - LIC Premium (Salary)"; Decimal)
        {
            Caption = 'Actual LIC Premium (Salary)';
            ToolTip = 'Specifies LIC premium deducted through salary.';
        }
        field(47; "Actual - LIC Premium (Direct)"; Decimal)
        {
            Caption = 'Actual LIC Premium (Direct)';
            ToolTip = 'Specifies LIC premium paid directly.';
        }
        field(48; "Actual - Total LIC Premium"; Decimal)
        {
            Caption = 'Actual Total LIC Premium';
            ToolTip = 'Specifies total LIC premium amount.';
        }
        field(49; "Actual - NSC (Direct)"; Decimal)
        {
            Caption = 'Actual NSC';
            ToolTip = 'Specifies National Savings Certificate investment.';
        }
        field(50; "Actual - NSC Interest"; Decimal)
        {
            Caption = 'Actual NSC Interest';
            ToolTip = 'Specifies interest earned on NSC.';
        }
        field(51; "Actual - ULIP"; Decimal)
        {
            Caption = 'Actual ULIP';
            ToolTip = 'Specifies ULIP investment amount.';
        }
        field(52; "Actual - NSS Self"; Decimal)
        {
            Caption = 'Actual NSS';
            ToolTip = 'Specifies National Savings Scheme contribution.';
        }
        field(53; "Actual - Mutal Fund"; Decimal)
        {
            Caption = 'Actual Mutual Fund';
            ToolTip = 'Specifies mutual fund investment amount.';
        }
        field(54; "Actual -Housing Loan Principal"; Decimal)
        {
            Caption = 'Actual Housing Loan Principal';
            ToolTip = 'Specifies principal repayment of housing loan.';
        }
        field(55; "Actual -Infra Development Bond"; Decimal)
        {
            Caption = 'Actual Infrastructure Bond';
            ToolTip = 'Specifies infrastructure bond investment.';
        }
        field(56; "Actual -Other 80 Deduction - 1"; Decimal)
        {
            Caption = 'Actual Other 80 Deduction 1';
            ToolTip = 'Specifies other deduction under section 80.';
        }
        field(57; "Actual -Other 80 Deduction - 2"; Decimal)
        {
            Caption = 'Actual Other 80 Deduction 2';
            ToolTip = 'Specifies additional deduction under section 80.';
        }
        field(58; "Actual - Total 80 Deduction"; Decimal)
        {
            Caption = 'Actual Total 80C Deduction';
            ToolTip = 'Specifies total deductions under section 80C.';
        }
        field(59; "Actual - 80CCC (Pension Fund)"; Decimal)
        {
            Caption = 'Actual 80CCC Pension Fund';
            ToolTip = 'Specifies pension fund contribution under section 80CCC.';
        }
        field(60; "Actual - 80D (Mediclaim)"; Decimal)
        {
            Caption = 'Actual 80D Mediclaim';
            ToolTip = 'Specifies mediclaim premium under section 80D.';
        }
        field(61; "Actual - 80DD(Handicapped Dep)"; Decimal)
        {
            Caption = 'Actual 80DD Dependent';
            ToolTip = 'Specifies deduction for handicapped dependent.';
        }
        field(62; "Actual - 80DDB(Medical Ex Spl)"; Decimal)
        {
            Caption = 'Actual 80DDB Medical';
            ToolTip = 'Specifies medical treatment expenses deduction.';
        }
        field(63; "Actual - 80G (Donations)"; Decimal)
        {
            Caption = 'Actual 80G Donation';
            ToolTip = 'Specifies donations eligible for deduction.';
        }
        field(64; "Actual - 80U(Physically Handi)"; Decimal)
        {
            Caption = 'Actual 80U Disability';
            ToolTip = 'Specifies deduction for physical disability.';
        }
        field(65; "Actual - Total 80A-Z Deduction"; Decimal)
        {
            Caption = 'Actual Total 80A-Z Deduction';
            ToolTip = 'Specifies total deductions under sections 80A to 80U.';
        }
        field(66; "Proj - PF (Salary)"; Decimal)
        {
            Caption = 'Projected PF (Salary)';
            ToolTip = 'Specifies projected provident fund contribution through salary.';
        }
        field(67; "Proj - PF (Direct)"; Decimal)
        {
            Caption = 'Projected PF (Direct)';
            ToolTip = 'Specifies projected direct provident fund contribution.';
        }
        field(68; "Proj - Total PF"; Decimal)
        {
            Caption = 'Projected Total PF';
            ToolTip = 'Specifies total projected provident fund contribution.';
        }
        field(69; "Proj - LIC Premium (Salary)"; Decimal)
        {
            Caption = 'Projected LIC Premium (Salary)';
            ToolTip = 'Specifies projected LIC premium deducted through salary.';
        }
        field(70; "Proj - LIC Premium (Direct)"; Decimal)
        {
            Caption = 'Projected LIC Premium (Direct)';
            ToolTip = 'Specifies projected LIC premium paid directly.';
        }
        field(71; "Proj - Total LIC Premium"; Decimal)
        {
            Caption = 'Projected Total LIC Premium';
            ToolTip = 'Specifies total projected LIC premium amount.';
        }
        field(72; "Proj - NSC (Direct)"; Decimal)
        {
            Caption = 'Projected NSC';
            ToolTip = 'Specifies projected National Savings Certificate investment.';
        }
        field(73; "Proj - NSC Interest"; Decimal)
        {
            Caption = 'Projected NSC Interest';
            ToolTip = 'Specifies projected interest on NSC investment.';
        }
        field(74; "Proj - ULIP"; Decimal)
        {
            Caption = 'Projected ULIP';
            ToolTip = 'Specifies projected ULIP investment amount.';
        }
        field(75; "Proj - NSS Self"; Decimal)
        {
            Caption = 'Projected NSS';
            ToolTip = 'Specifies projected National Savings Scheme contribution.';
        }
        field(76; "Proj - Mutal Fund"; Decimal)
        {
            Caption = 'Projected Mutual Fund';
            ToolTip = 'Specifies projected mutual fund investment.';
        }
        field(77; "Proj - Housing Loan Principal"; Decimal)
        {
            Caption = 'Projected Housing Loan Principal';
            ToolTip = 'Specifies projected principal repayment of housing loan.';
        }
        field(78; "Proj - Infra Development Bond"; Decimal)
        {
            Caption = 'Projected Infrastructure Bond';
            ToolTip = 'Specifies projected infrastructure development bond investment.';
        }
        field(79; "Proj - Other 80 Deduction - 1"; Decimal)
        {
            Caption = 'Projected Other 80 Deduction 1';
            ToolTip = 'Specifies projected other deduction under section 80.';
        }
        field(80; "Proj - Other 80 Deduction - 2"; Decimal)
        {
            Caption = 'Projected Other 80 Deduction 2';
            ToolTip = 'Specifies projected additional deduction under section 80.';
        }
        field(81; "Proj - Total 80 Deduction"; Decimal)
        {
            Caption = 'Projected Total 80C Deduction';
            ToolTip = 'Specifies total projected deductions under section 80C.';
        }
        field(82; "Proj - 80CCC (Pension Fund)"; Decimal)
        {
            Caption = 'Projected 80CCC Pension Fund';
            ToolTip = 'Specifies projected pension fund contribution under section 80CCC.';
        }
        field(83; "Proj - 80D (Mediclaim)"; Decimal)
        {
            Caption = 'Projected 80D Mediclaim';
            ToolTip = 'Specifies projected mediclaim premium under section 80D.';
        }
        field(84; "Proj - 80DD(Handicapped Dep)"; Decimal)
        {
            Caption = 'Projected 80DD Dependent';
            ToolTip = 'Specifies projected deduction for handicapped dependent.';
        }
        field(85; "Proj - 80DDB(Medical Ex Spl)"; Decimal)
        {
            Caption = 'Projected 80DDB Medical';
            ToolTip = 'Specifies projected medical treatment expense deduction.';
        }
        field(86; "Proj - 80G (Donations)"; Decimal)
        {
            Caption = 'Projected 80G Donation';
            ToolTip = 'Specifies projected donations eligible for deduction.';
        }
        field(87; "Proj - 80U(Physically Handi)"; Decimal)
        {
            Caption = 'Projected 80U Disability';
            ToolTip = 'Specifies projected deduction for physical disability.';
        }
        field(88; "Proj - Total 80A-Z Deduction"; Decimal)
        {
            Caption = 'Projected Total 80A–Z Deduction';
            ToolTip = 'Specifies total projected deductions under sections 80A to 80U.';
        }
        field(89; "Taxable Income"; Decimal)
        {
            Caption = 'Taxable Income';
            ToolTip = 'Specifies income liable for tax.';
        }
        field(90; "Income Tax Amount"; Decimal)
        {
            Caption = 'Income Tax';
            ToolTip = 'Specifies calculated income tax amount.';
        }
        field(91; "Higher Edu Cess Amount"; Decimal)
        {
            Caption = 'Higher Education Cess';
            ToolTip = 'Specifies higher education cess amount.';
        }
        field(92; "Cess Amount"; Decimal)
        {
            Caption = 'Cess Amount';
            ToolTip = 'Specifies applicable cess amount.';
        }
        field(93; "Surcharge Amount"; Decimal)
        {
            Caption = 'Surcharge Amount';
            ToolTip = 'Specifies surcharge applied on tax.';
        }
        field(94; "Total Tax Amount"; Decimal)
        {
            Caption = 'Total Tax';
            ToolTip = 'Specifies total tax payable.';
        }
        field(95; "Tax Paid"; Decimal)
        {
            Caption = 'Tax Paid';
            ToolTip = 'Specifies tax amount already paid.';
        }
        field(96; "Tax Refund"; Decimal)
        {
            Caption = 'Tax Refund';
            ToolTip = 'Specifies refundable tax amount.';
        }
        field(97; "Tax Balance"; Decimal)
        {
            Caption = 'Tax Balance';
            ToolTip = 'Specifies remaining tax balance.';
        }
        field(98; "Tax Per Month"; Decimal)
        {
            Caption = 'Tax Per Month';
            ToolTip = 'Specifies monthly tax deduction.';
        }
        field(99; "Food Plus Card Allow"; Decimal)
        {
            Caption = 'Food Card Allowance';
            ToolTip = 'Specifies food card allowance amount.';
        }
        field(100; "Rent Received"; Decimal)
        {
            Caption = 'Rent Received';
            ToolTip = 'Specifies rent income received.';
        }
        field(101; "Medical Bill"; Decimal)
        {
            Caption = 'Medical Bills';
            ToolTip = 'Specifies medical bills submitted.';
        }
        field(102; "Medical Allow"; Decimal)
        {
            Caption = 'Medical Allowance';
            ToolTip = 'Specifies medical allowance amount.';
        }
        field(103; "Proj -  80E (Educational Loan)"; Decimal)
        {
            Caption = 'Projected 80E Education Loan';
            ToolTip = 'Specifies projected interest on education loan.';
        }
        field(104; "Actu -  80E (Educational Loan)"; Decimal)
        {
            Caption = 'Actual 80E Education Loan';
            ToolTip = 'Specifies actual interest paid on education loan.';
        }
        field(105; Printed; Boolean)
        {
            Caption = 'Printed';
            ToolTip = 'Specifies whether income tax statement is printed.';
        }
        field(106; Verified; Boolean)
        {
            Caption = 'Verified';
            ToolTip = 'Specifies whether income tax details are verified.';
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

}

