codeunit 71044 "Fee Management"
{
    //   No   Date      Sign     Trigger            Description
    // -----------------------------------------------------------------------------------------------
    //   01  24/09/09   KATHIR   FeeProcess()       Function Added to Create Journal for Fees and also for batch post
    //   02  25/09/09   KATHIR   CheckDuplication() Function created to check the duplication entry in Cust. ledger Entry
    //   03  10/10/09  VANDHANA  CopyFees()         Function added to copy feeLines from one fee to another.
    //   04  14/10/19  VIGNESH   Post Sales()       Function Creted to post the Fee through Sales Order


    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'Fee Copied';

    [Scope('Internal')]
    procedure FeeProcess(StudNo: Code[20]; FeeCode1: Code[10]; Amount: Decimal)
    var
        FeeSetup: Record "Fee Setup";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalLine: Record "Gen. Journal Line";
        NoSeries: Codeunit NoSeriesManagement;
        GenJournalBatch: Record "Gen. Journal Batch";
        Genjourrec: Record "Gen. Journal Line";
        FeeCode: Record "Fee Components";
        Student: Record Student;
        "TempDocNo.": Code[20];
        CheckBool: Boolean;
    begin
        // Start 01.KATHIR
        CLEAR(NoSeries);
        FeeSetup.GET;
        FeeSetup.TESTFIELD("Journal Template Name");
        FeeSetup.TESTFIELD("Journal Batch Name");
        FeeCode.GET(FeeCode1);
        Student.GET(StudNo);
        "TempDocNo." := NoSeries.GetNextNo(FeeSetup."Fee Number", 0D, TRUE);
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", FeeSetup."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", FeeSetup."Journal Batch Name");
        IF GenJournalLine.FINDLAST THEN
            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000
        ELSE
            GenJournalLine."Line No." := 10000;

        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := FeeSetup."Journal Template Name";
        GenJournalLine."Journal Batch Name" := FeeSetup."Journal Batch Name";
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        IF Amount > 0 THEN
            GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice
        ELSE
            IF Amount < 0 THEN
                GenJournalLine."Document Type" := GenJournalLine."Document Type"::Payment;
        GenJournalLine."Account No." := StudNo;
        GenJournalLine.VALIDATE("Account No.");
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No." := FeeCode."G/L Account";
        GenJournalLine.Description := FeeCode.Description;
        GenJournalLine."Posting Date" := TODAY;
        GenJournalLine."Debit Amount" := Amount;
        GenJournalLine.VALIDATE("Debit Amount");
        GenJournalLine."Document No." := "TempDocNo.";
        GenJournalLine.Class := Student.Class;
        GenJournalLine.Section := Student.Section;
        GenJournalLine."Academic Year" := Student."Academic Year";
        GenJournalLine."Fee Code" := FeeCode1;
        GenJournalLine.INSERT(TRUE);
        // Stop 01.KATHIR
    end;

    [Scope('Internal')]
    procedure CheckDuplication("StudNo.": Code[20]; FeeCode: Code[20]; Class: Code[20]; Sec: Code[10]; Accyear: Code[20]): Boolean
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        //Start 02.KATHIR
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Fee Code", Class, Section, "Academic Year");
        CustLedgerEntry.SETRANGE("Customer No.", "StudNo.");
        CustLedgerEntry.SETRANGE("Fee Code", FeeCode);
        CustLedgerEntry.SETRANGE(Class, Class);
        CustLedgerEntry.SETRANGE(Section, Sec);
        CustLedgerEntry.SETRANGE("Academic Year", Accyear);
        IF CustLedgerEntry.ISEMPTY THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE)
        // Stop 02.KATHIR
    end;

    [Scope('Internal')]
    procedure CopyFees(feecode: Code[20]; ClassFeeNo: Code[20])
    var
        ClassFeeLine: Record "Class Fee Line";
        ClassFeeLine1: Record "Class Fee Line";
    begin
        // Start 01 VANDHANA
        ClassFeeLine.RESET;
        ClassFeeLine.SETRANGE("Document No.", feecode);
        IF ClassFeeLine.FINDSET THEN
            REPEAT
                ClassFeeLine1.INIT;
                ClassFeeLine1.TRANSFERFIELDS(ClassFeeLine);
                ClassFeeLine1."Document No." := ClassFeeNo;
                ClassFeeLine1.INSERT;
            UNTIL ClassFeeLine.NEXT = 0;
        MESSAGE(Text000);
        // Stop 01 VANDHANA
    end;

    [Scope('Internal')]
    procedure "Post Sales"("getStudentNo.": Code[20]; getFeeCode: Code[20]; getAmount: Decimal): Code[20]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesPost: Codeunit "Sales-Post";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        FeeComponents: Record "Fee Components";
        Student: Record Student;
        EducationSetup: Record "Education Setup";
        SalesHeader1: Record "Sales Header";
    begin
        // Start 04.VIGNESH
        FeeComponents.GET(getFeeCode);
        FeeComponents.TESTFIELD("G/L Account");
        Student.GET("getStudentNo.");
        EducationSetup.GET;
        SalesHeader.RESET;
        SalesHeader.INIT;
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."Sell-to Customer No." := "getStudentNo.";
        SalesHeader."Posting Date" := TODAY;
        SalesHeader."Shipment Date" := TODAY;
        SalesHeader."Document Date" := TODAY;
        SalesHeader.VALIDATE("Sell-to Customer No.");
        SalesHeader."Payment Method Code" := 'CASH';
        SalesHeader."Payment Terms Code" := '0d';
        SalesHeader.VALIDATE("Payment Terms Code");
        SalesHeader.Ship := TRUE;
        SalesHeader.Invoice := TRUE;
        SalesHeader."Fee Code" := getFeeCode;
        SalesHeader.Section := Student.Section;
        SalesHeader."Academic Year" := EducationSetup."Academic Year";
        SalesHeader.Class := Student.Class;
        SalesHeader.INSERT(TRUE);

        SalesLine.INIT;
        SalesLine."Document Type" := SalesLine."Document Type"::Order;
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." += 10000;
        SalesLine.Type := SalesLine.Type::"G/L Account";
        SalesLine.VALIDATE(Type);
        SalesLine."No." := FeeComponents."G/L Account";
        SalesLine.VALIDATE("No.");
        SalesLine.Quantity := 1;
        SalesLine.VALIDATE(Quantity);
        SalesLine."Unit Price" := getAmount;
        SalesLine.VALIDATE("Unit Price");
        SalesLine.INSERT(TRUE);

        IF SalesHeader1.GET(SalesHeader."Document Type"::Order, SalesHeader."No.") THEN BEGIN
            CLEAR(SalesPost);
            SalesPost.SetPostingDate(FALSE, FALSE, SalesHeader1."Posting Date");
            SalesPost.RUN(SalesHeader1);

            SalesInvoiceHeader.RESET;
            SalesInvoiceHeader.SETRANGE("Order No.", SalesHeader."No.");
            IF SalesInvoiceHeader.FINDFIRST THEN
                EXIT(SalesInvoiceHeader."No.");
        END;
        // Stop 04.VIGNESH
    end;
}

