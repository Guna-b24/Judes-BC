codeunit 72010 "Salary Group Posting"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Codeunit Created for PAYROLL Module
    // -----------------------------------------------------------------------------------------------


    trigger OnRun()
    begin
    end;

    var
        Text001: Label 'Pay Element - %1 is not found in Payelement Master';
        Text002: Label 'General Posting Group is not defined for Business Posting Group %1 %2';
        Text003: Label 'Business Posting %1 is not defined in Business Posting Group Master';
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        PayElements: Record "Pay Elements";
        Employee: Record Employee;
        PayrollBusinessPostingGroup: Record "Payroll Business Posting Group";
        PayrollProductPostingGroup: Record "Payroll Product Posting Group";
        PayrollGeneralPostingSetup: Record "Payroll General Posting Setup";
        Text004: Label 'G/L Account Not defined in Payroll General Posting %1 %2 ';
        PayrollEmployeePostingGroup: Record "Payroll Employee Posting Group";
        GenJournalLine: Record "Gen. Journal Line";
        PayDate: Date;
        PayBusinessPosting: Code[20];
        ProductPosting: Code[20];
        TotAddAmt: Decimal;
        TotDedAmt: Decimal;

    [Scope('Internal')]
    procedure Posting(var GSalaryPosting: Record "Salary Posting-1")
    var
        SalaryPosting: Record "Salary Posting-1";
    begin
        LocationHRPayrollSetup.GET(GSalaryPosting."Location Code");

        SalaryPosting.RESET;
        SalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        SalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        SalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        SalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        SalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        //SalaryPosting.SETRANGE(Loan,FALSE);
        IF SalaryPosting.FINDSET THEN
            REPEAT
                CASE SalaryPosting."Pay Type" OF
                    SalaryPosting."Pay Type"::Addition, SalaryPosting."Pay Type"::Reimbursement:
                        IF NOT PayElements.GET(SalaryPosting."Pay Element Code",
                             SalaryPosting."Location Code",
                             SalaryPosting."Salary Plan Code")
                        THEN
                            ERROR(Text001, SalaryPosting."Pay Element Code")
                        ELSE BEGIN
                            PayElements.TESTFIELD("Pay Prod. Posting Group");
                            IF NOT PayrollBusinessPostingGroup.GET(SalaryPosting."Pay Bus. Posting Group",
                                 SalaryPosting."Location Code",
                                   SalaryPosting."Salary Plan Code")
                            THEN
                                ERROR(Text003, SalaryPosting."Pay Bus. Posting Group")
                            ELSE
                                IF NOT PayrollGeneralPostingSetup.GET(PayrollBusinessPostingGroup.Code,
                                   PayElements."Pay Prod. Posting Group",
                                     SalaryPosting."Location Code",
                                       SalaryPosting."Salary Plan Code")
                                THEN
                                    ERROR(Text002, PayrollBusinessPostingGroup.Code, PayElements."Pay Prod. Posting Group");
                        END;

                    SalaryPosting."Pay Type"::Deduction:
                        IF (SalaryPosting."Pay Element Code" <> 'PF') AND (SalaryPosting."Pay Element Code" <> 'ESI') AND
                           (SalaryPosting."Pay Element Code" <> 'TDS') AND (SalaryPosting."Pay Element Code" <> 'PT')
                        THEN
                            IF NOT PayElements.GET(SalaryPosting."Pay Element Code",
                                 SalaryPosting."Location Code",
                                SalaryPosting."Salary Plan Code")
                            THEN
                                ERROR(Text001, SalaryPosting."Pay Element Code")
                            ELSE BEGIN
                                PayElements.TESTFIELD("Pay Prod. Posting Group");
                                IF NOT PayrollBusinessPostingGroup.GET(SalaryPosting."Pay Bus. Posting Group",
                                     SalaryPosting."Location Code",
                                     SalaryPosting."Salary Plan Code")
                                THEN
                                    ERROR(Text003, SalaryPosting."Pay Bus. Posting Group")
                                ELSE
                                    IF NOT PayrollGeneralPostingSetup.GET(PayrollBusinessPostingGroup.Code,
                                       PayElements."Pay Prod. Posting Group",
                                       SalaryPosting."Location Code",
                                       SalaryPosting."Salary Plan Code")
                                    THEN
                                        ERROR(Text002, PayrollBusinessPostingGroup.Code, PayElements."Pay Prod. Posting Group");
                            END;
                END;
            UNTIL SalaryPosting.NEXT = 0;

        // Finding the Debit Account & Credit Accounts for Additions & Deductions

        SalaryPosting.RESET;
        SalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        SalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        SalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        SalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        SalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        //SalaryPosting.SETRANGE(Loan,FALSE);
        IF SalaryPosting.FINDSET THEN
            REPEAT
                CASE SalaryPosting."Pay Type" OF
                    SalaryPosting."Pay Type"::Addition, SalaryPosting."Pay Type"::Reimbursement:
                        BEGIN
                            PayElements.GET(SalaryPosting."Pay Element Code",
                             SalaryPosting."Location Code",
                             SalaryPosting."Salary Plan Code");
                            PayrollProductPostingGroup.GET(PayElements."Pay Prod. Posting Group",
                             SalaryPosting."Location Code",
                             SalaryPosting."Salary Plan Code");

                            ProductPosting := PayrollProductPostingGroup.Code;

                            PayrollBusinessPostingGroup.GET(SalaryPosting."Pay Bus. Posting Group",
                             SalaryPosting."Location Code",
                             SalaryPosting."Salary Plan Code");

                            PayBusinessPosting := PayrollBusinessPostingGroup.Code;

                            PayrollGeneralPostingSetup.GET(PayBusinessPosting, ProductPosting,
                              SalaryPosting."Location Code",
                              SalaryPosting."Salary Plan Code");

                            IF PayrollGeneralPostingSetup."G/L Code" = '' THEN
                                ERROR(Text004, PayrollGeneralPostingSetup."Pay Bus.Posting Group",
                                PayrollGeneralPostingSetup."Pay Prod. Posting Group");

                            SalaryPosting."Pay Element Description" := SalaryPosting."Pay Element Code" + ' ' + SalaryPosting."Salary Cycle Code";
                            SalaryPosting."Account No." := PayrollGeneralPostingSetup."G/L Code";
                            SalaryPosting.MODIFY;

                            InitGenJnlLine(SalaryPosting, SalaryPosting."Payable Amount");
                        END;

                    SalaryPosting."Pay Type"::Deduction:
                        IF (SalaryPosting."Pay Element Code" <> 'PF') AND
                           (SalaryPosting."Pay Element Code" <> 'ESI') AND
                           (SalaryPosting."Pay Element Code" <> 'TDS') AND
                           (SalaryPosting."Pay Element Code" <> 'PT') AND
                           (SalaryPosting."Pay Element Code" <> 'LOAN')
                        THEN BEGIN
                            PayElements.GET(SalaryPosting."Pay Element Code",
                              SalaryPosting."Location Code",
                              SalaryPosting."Salary Plan Code");

                            PayrollProductPostingGroup.GET(PayElements."Pay Prod. Posting Group",
                              SalaryPosting."Location Code",
                              SalaryPosting."Salary Plan Code");

                            ProductPosting := PayrollProductPostingGroup.Code;

                            PayrollBusinessPostingGroup.GET(SalaryPosting."Pay Bus. Posting Group",
                              SalaryPosting."Location Code",
                              SalaryPosting."Salary Plan Code");

                            PayBusinessPosting := PayrollBusinessPostingGroup.Code;

                            PayrollGeneralPostingSetup.GET(PayBusinessPosting, ProductPosting,
                              SalaryPosting."Location Code",
                              SalaryPosting."Salary Plan Code");

                            IF PayrollGeneralPostingSetup."G/L Code" = '' THEN
                                ERROR(Text004, PayrollGeneralPostingSetup."Pay Bus.Posting Group",
                                 PayrollGeneralPostingSetup."Pay Prod. Posting Group");

                            SalaryPosting."Pay Element Description" := SalaryPosting."Pay Element Code" + ' ' + SalaryPosting."Salary Cycle Code";
                            SalaryPosting."Account No." := PayrollGeneralPostingSetup."G/L Code";
                            SalaryPosting.MODIFY;
                            InitGenJnlLine(SalaryPosting, -SalaryPosting."Payable Amount");
                        END;
                END;
            UNTIL SalaryPosting.NEXT = 0;

        // EMPLOYER ESI CONTRIBUTION

        SalaryPosting.RESET;
        SalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        SalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        SalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        SalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        SalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        SalaryPosting.SETRANGE("Pay Type", SalaryPosting."Pay Type"::Deduction);
        SalaryPosting.SETRANGE("Pay Element Code", 'ESI');
        IF SalaryPosting.FINDFIRST THEN BEGIN
            LocationHRPayrollSetup.TESTFIELD("Employer ESI GL Code");
            SalaryPosting."Account No." := LocationHRPayrollSetup."Employer ESI GL Code";
            SalaryPosting."Pay Element Description" := SalaryPosting."Pay Element Code" + ' ' + SalaryPosting."Salary Cycle Code";
            SalaryPosting.MODIFY;
            InitGenJnlLine(SalaryPosting, SalaryPosting."Employer PF / ESI Amount");
        END;

        // EMPLOYER EPS CONTRIBUTION
        SalaryPosting.RESET;
        SalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        SalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        SalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        SalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        SalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        SalaryPosting.SETRANGE("Pay Type", SalaryPosting."Pay Type"::Deduction);
        SalaryPosting.SETRANGE("Pay Element Code", 'PF');
        IF SalaryPosting.FINDFIRST THEN BEGIN
            LocationHRPayrollSetup.TESTFIELD("Employer EPS GL Code");
            SalaryPosting."Account No." := LocationHRPayrollSetup."Employer EPS GL Code";
            SalaryPosting."Pay Element Description" := SalaryPosting."Pay Element Code" + ' ' + SalaryPosting."Salary Cycle Code";
            SalaryPosting.MODIFY;
            InitGenJnlLine(SalaryPosting, SalaryPosting."Employer EPS Amount");
        END;

        // EMPLOYER PF CONTRIBUTION,PF ADMIN CHARGES , ELDI CHARGES, RIFA CHARGES
        SalaryPosting.RESET;
        SalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        SalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        SalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        SalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        SalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        SalaryPosting.SETRANGE("Pay Element Code", 'PF');
        IF SalaryPosting.FINDFIRST THEN BEGIN
            // EMPLOYER PF
            LocationHRPayrollSetup.TESTFIELD("Employer PF GL Code");
            SalaryPosting."Account No." := LocationHRPayrollSetup."Employer PF GL Code";
            SalaryPosting."Pay Element Description" := 'PF PFC' + ' ' + SalaryPosting."Salary Cycle Code";
            InitGenJnlLine(SalaryPosting, SalaryPosting."Employer PF / ESI Amount");

            // PF ADMIN CHARGES
            LocationHRPayrollSetup.TESTFIELD("PF Admin Charges GL Code");
            SalaryPosting."Account No." := LocationHRPayrollSetup."PF Admin Charges GL Code";
            SalaryPosting."Pay Element Description" := 'PF Admin ' + ' ' + SalaryPosting."Salary Cycle Code";
            InitGenJnlLine(SalaryPosting, SalaryPosting."PF Admin Charges Amount");

            // ELDI CHARGES
            LocationHRPayrollSetup.TESTFIELD("EDLI Charges GLCode");
            SalaryPosting."Account No." := LocationHRPayrollSetup."EDLI Charges GLCode";
            SalaryPosting."Pay Element Description" := 'PF EDLI ' + ' ' + SalaryPosting."Salary Cycle Code";
            InitGenJnlLine(SalaryPosting, SalaryPosting."PF EDLI Amount");

            // RIFA CHARGES
            LocationHRPayrollSetup.TESTFIELD("RIFA Charges GL Code");
            SalaryPosting."Account No." := LocationHRPayrollSetup."RIFA Charges GL Code";
            SalaryPosting."Pay Element Description" := 'PF RIFA ' + ' ' + SalaryPosting."Salary Cycle Code";
            InitGenJnlLine(SalaryPosting, SalaryPosting."PF RIFA Amount");
        END;

        Deductions(GSalaryPosting);
    end;

    [Scope('Internal')]
    procedure InitGenJnlLine(LSalaryPosting: Record "Salary Posting-1"; Amount: Decimal)
    var
        JournalLineDimension: Record Table356;
    begin
        IF Amount <> 0 THEN BEGIN
            PayElements.GET(LSalaryPosting."Pay Element Code", LSalaryPosting."Location Code", LSalaryPosting."Salary Plan Code");
            GenJournalLine.INIT;
            GenJournalLine."Journal Template Name" := LSalaryPosting."Journal Template Name";
            GenJournalLine."Journal Batch Name" := LSalaryPosting."Journal Batch Name";
            GenJournalLine."Line No." += 10000;
            GenJournalLine."Account Type" := LSalaryPosting."Account Type";
            GenJournalLine.VALIDATE("Account No.", LSalaryPosting."Account No.");
            GenJournalLine."Posting Date" := LSalaryPosting."Salary Due Posted Date";
            GenJournalLine."Document No." := LSalaryPosting."Salary Due Document No";
            GenJournalLine.Description := LSalaryPosting."Branch Code" + ' - ' + LSalaryPosting."Pay Element Description";
            GenJournalLine."Bal. Account Type" := LSalaryPosting."Account Type";
            GenJournalLine.VALIDATE(Amount, Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := LSalaryPosting."Branch Code";
            GenJournalLine."Source Code" := 'GENJNL';
            GenJournalLine.INSERT;

            JournalLineDimension.INIT;
            JournalLineDimension."Table ID" := DATABASE::"Gen. Journal Line";
            JournalLineDimension."Journal Template Name" := GenJournalLine."Journal Template Name";
            JournalLineDimension."Journal Batch Name" := GenJournalLine."Journal Batch Name";
            JournalLineDimension."Journal Line No." := GenJournalLine."Line No.";
            JournalLineDimension."Dimension Code" := 'BRANCH';
            JournalLineDimension."Dimension Value Code" := LSalaryPosting."Branch Code";
            JournalLineDimension.INSERT;
        END;
    end;

    [Scope('Internal')]
    procedure Deductions(GSalaryPosting: Record "Salary Posting-1")
    var
        LSalaryPosting: Record "Salary Posting-1";
        Additions: Decimal;
        Deductions: Decimal;
        AccountType: Option "G/L Account";
    begin
        PayrollEmployeePostingGroup.GET(GSalaryPosting."Emp Posting Group",
          GSalaryPosting."Location Code",
          GSalaryPosting."Salary Plan Code");

        // PF Account

        LSalaryPosting.RESET;
        LSalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        LSalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        LSalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        LSalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        LSalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        LSalaryPosting.SETRANGE("Pay Type", LSalaryPosting."Pay Type"::Deduction);
        LSalaryPosting.SETRANGE("Pay Element Code", 'PF');
        IF LSalaryPosting.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("PF Payable A/c");
            LSalaryPosting."Account No." := PayrollEmployeePostingGroup."PF Payable A/c";
            InitGenJnlLine(LSalaryPosting,
            -(LSalaryPosting."Employee PF / ESI Amount" +
              LSalaryPosting."Employer PF / ESI Amount"));
        END;
        // EPS Account
        LSalaryPosting.RESET;
        LSalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        LSalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        LSalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        LSalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        LSalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        LSalaryPosting.SETRANGE("Pay Type", LSalaryPosting."Pay Type"::Deduction);
        LSalaryPosting.SETRANGE("Pay Element Code", 'PF');
        IF LSalaryPosting.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("EPS Payable A/c");
            LSalaryPosting."Account No." := PayrollEmployeePostingGroup."EPS Payable A/c";
            LSalaryPosting."Pay Element Description" := 'PF EPS ' + LSalaryPosting."Salary Cycle Code";
            InitGenJnlLine(LSalaryPosting, -LSalaryPosting."Employer EPS Amount");
        END;

        // PT PAYABLE ACCOUNT
        LSalaryPosting.RESET;
        LSalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        LSalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        LSalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        LSalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        LSalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        LSalaryPosting.SETRANGE("Pay Type", LSalaryPosting."Pay Type"::Deduction);
        LSalaryPosting.SETRANGE("Pay Element Code", 'PT');
        IF LSalaryPosting.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("PT Payable A/c");
            LSalaryPosting."Account No." := PayrollEmployeePostingGroup."PT Payable A/c";
            LSalaryPosting."Pay Element Description" := LSalaryPosting."Pay Element Code" + ' ' + LSalaryPosting."Salary Cycle Code";
            InitGenJnlLine(LSalaryPosting, -LSalaryPosting."Payable Amount");
        END;

        // ESI Account
        LSalaryPosting.RESET;
        LSalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        LSalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        LSalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        LSalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        LSalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        LSalaryPosting.SETRANGE("Pay Type", LSalaryPosting."Pay Type"::Deduction);
        LSalaryPosting.SETRANGE("Pay Element Code", 'ESI');
        IF LSalaryPosting.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("ESI Payable A/c");
            LSalaryPosting."Account No." := PayrollEmployeePostingGroup."ESI Payable A/c";
            LSalaryPosting."Pay Element Description" := LSalaryPosting."Pay Element Code" + ' ' + LSalaryPosting."Salary Cycle Code";
            InitGenJnlLine(LSalaryPosting,
             -(LSalaryPosting."Employee PF / ESI Amount" +
               LSalaryPosting."Employer PF / ESI Amount"));
        END;
        // TDS Account
        LSalaryPosting.RESET;
        LSalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        LSalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        LSalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        LSalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        LSalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        LSalaryPosting.SETRANGE("Pay Type", LSalaryPosting."Pay Type"::Deduction);
        LSalaryPosting.SETRANGE("Pay Element Code", 'TDS');
        IF LSalaryPosting.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("TDS Payable A/c");
            LSalaryPosting."Account No." := PayrollEmployeePostingGroup."TDS Payable A/c";
            LSalaryPosting."Pay Element Description" := LSalaryPosting."Pay Element Code" + ' ' + LSalaryPosting."Salary Cycle Code";
            InitGenJnlLine(LSalaryPosting, -LSalaryPosting."Payable Amount");
        END;

        // BONUS Account

        LSalaryPosting.RESET;
        LSalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        LSalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        LSalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        LSalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        LSalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        LSalaryPosting.SETRANGE("Pay Type", LSalaryPosting."Pay Type"::Addition);
        LSalaryPosting.SETRANGE("Pay Element Code", 'BONUS');
        IF LSalaryPosting.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("Bonus Payable A/c");
            LSalaryPosting."Account No." := PayrollEmployeePostingGroup."Bonus Payable A/c";
            LSalaryPosting."Pay Element Description" := LSalaryPosting."Pay Element Code" + ' ' + LSalaryPosting."Salary Cycle Code";
            InitGenJnlLine(LSalaryPosting, -LSalaryPosting."Payable Amount");
        END;

        // LOAN Account

        LSalaryPosting.RESET;
        LSalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        LSalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        LSalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        LSalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        LSalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        LSalaryPosting.SETRANGE("Pay Type", LSalaryPosting."Pay Type"::Deduction);
        LSalaryPosting.SETRANGE("Pay Element Code", 'LOAN');
        IF LSalaryPosting.FINDSET THEN BEGIN
            PayElements.GET(LSalaryPosting."Pay Element Code", LSalaryPosting."Location Code",
              LSalaryPosting."Salary Plan Code");
            PayElements.TESTFIELD("GL Code");
            LSalaryPosting."Account No." := PayElements."GL Code";
            LSalaryPosting."Pay Element Description" := LSalaryPosting."Pay Element Code" + ' ' + LSalaryPosting."Salary Cycle Code";
            InitGenJnlLine(LSalaryPosting, -LSalaryPosting."Payable Amount");
        END;

        // Salary Payable Account
        Additions := 0;
        Deductions := 0;

        LSalaryPosting.RESET;
        LSalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        LSalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        LSalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        LSalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        LSalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        IF LSalaryPosting.FINDSET THEN BEGIN
            REPEAT
                CASE LSalaryPosting."Pay Type" OF
                    LSalaryPosting."Pay Type"::Addition, LSalaryPosting."Pay Type"::Reimbursement:
                        Additions := Additions + LSalaryPosting."Payable Amount";

                    LSalaryPosting."Pay Type"::Deduction:
                        Deductions := Deductions + LSalaryPosting."Payable Amount";
                END;
            UNTIL LSalaryPosting.NEXT = 0;

            PayrollEmployeePostingGroup.TESTFIELD("Salary Payable1 A/c");
            LSalaryPosting."Account No." := PayrollEmployeePostingGroup."Salary Payable1 A/c";
            LSalaryPosting."Pay Element Description" := 'Net Amount ' + LSalaryPosting."Salary Cycle Code";
            InitGenJnlLine(LSalaryPosting, -(Additions - Deductions));
        END;

        // PF ADMIN CHARGES , ELDI CHARGES, RIFA CHARGES

        LSalaryPosting.RESET;
        LSalaryPosting.SETRANGE("Location Code", GSalaryPosting."Location Code");
        LSalaryPosting.SETRANGE("Salary Plan Code", GSalaryPosting."Salary Plan Code");
        LSalaryPosting.SETRANGE("Salary Cycle Code", GSalaryPosting."Salary Cycle Code");
        LSalaryPosting.SETRANGE("Branch Code", GSalaryPosting."Branch Code");
        LSalaryPosting.SETRANGE("Salary Due Entry", GSalaryPosting."Salary Due Entry");
        LSalaryPosting.SETRANGE("Pay Type", LSalaryPosting."Pay Type"::Deduction);
        LSalaryPosting.SETRANGE("Pay Element Code", 'PF');
        IF LSalaryPosting.FINDFIRST THEN BEGIN
            PayrollEmployeePostingGroup.TESTFIELD("PF Admin Charge Payable A/c");
            LSalaryPosting."Account No." := PayrollEmployeePostingGroup."PF Admin Charge Payable A/c";
            LSalaryPosting."Pay Element Description" := 'PF Admin ' + LSalaryPosting."Salary Cycle Code";
            InitGenJnlLine(LSalaryPosting, -LSalaryPosting."PF Admin Charges Amount");

            PayrollEmployeePostingGroup.TESTFIELD("EDLI Payable A/c");
            LSalaryPosting."Account No." := PayrollEmployeePostingGroup."EDLI Payable A/c";
            LSalaryPosting."Pay Element Description" := 'PF EDLI ' + LSalaryPosting."Salary Cycle Code";
            InitGenJnlLine(LSalaryPosting, -LSalaryPosting."PF EDLI Amount");

            PayrollEmployeePostingGroup.TESTFIELD("RIFA Payable A/c");
            LSalaryPosting."Account No." := PayrollEmployeePostingGroup."RIFA Payable A/c";
            LSalaryPosting."Pay Element Description" := 'PF RIFA ' + LSalaryPosting."Salary Cycle Code";
            InitGenJnlLine(LSalaryPosting, -LSalaryPosting."PF RIFA Amount");
        END;
    end;
}

