// codeunit 71630 "Library Transactions"
// {
//     trigger OnRun()
//     begin
//     end;

//     var
//         BookTransRec: Record Table71632;
//         AccessionRec: Record Table71631;
//         LibrarySetup: Record Table71633;
//         IntDays: Integer;
//         VarFine: Decimal;
//         VarStaff: Decimal;
//         ItemRec: Record Item;
//         BookRec: Record Table71630;
//         BookTr: Record Table71632;
//         IntMaxBook: Integer;
//         IntCount: Integer;
//         PurchLineRec: Record "Purchase Line";
//         i: Integer;
//         AdvBook: Record Table71635;
//         EducationSetup: Record "Education Setup";
//         LibrarySetupClassWise: Record Table71636;
//         LibrarySetupCourseWise: Record Table71637;
//         Student: Record Student;
//         StudentCOLLEGE: Record Table71355;
//         Text000: Label 'Select Company';
//         Text001: Label 'Please Enter Maximum No. of Books for the Staff';
//         Text002: Label 'Please Enter Maximum No. of Books for the Students';
//         Text003: Label 'Please enter Total No of Books Eligible for Class %1';
//         Text004: Label 'Please enter Total No of Books Eligible for Course %1';
//         Text005: Label 'Books Issued Successfully';
//         Text006: Label 'Max Limit for Issuing is over';
//         Text007: Label 'Books Returned Successfully';
//         Text008: Label 'you cannot return the book unless you pay the fine';
//         Text009: Label 'Item Created Successfully';
//         Text010: Label 'Advance Booking completed';
//         Text011: Label 'Enter the Fine Amount For Students';
//         Text012: Label 'Enter the Fine Amount For Staff';
//         Text013: Label 'Fine already paid';
//         Text014: Label 'Fees Generated';
//         Text015: Label 'Maximum No of Renewal Has To Be Assigned';
//         Text016: Label 'Maximum Renewal Has Been Exceeded';
//         Text017: Label 'Book Renewed Successfully';
//         AccessNo: Code[20];

//     [Scope('Internal')]
//     procedure "Book Issue"("EntryNo.": Integer)
//     begin
//         // Start 01.VIGNESH
//         CLEAR(IntCount);

//         EducationSetup.GET;
//         IF EducationSetup.Company = EducationSetup.Company::" " THEN
//             ERROR(Text000);

//         LibrarySetup.GET;
//         IF LibrarySetup."No. of Books - Staffs" = 0 THEN
//             ERROR(Text001);

//         IF BookTransRec.GET("EntryNo.") THEN BEGIN
//             BookTransRec.TESTFIELD("No.");
//             BookTransRec.TESTFIELD("Accession No.");
//             BookTransRec.TESTFIELD("Date of Issue");
//             BookTransRec.TESTFIELD("Date of Return");
//             BookTr.RESET;
//             BookTr.SETCURRENTKEY("No.", "Transaction Status");
//             BookTr.SETRANGE("No.", BookTransRec."No.");
//             BookTr.SETRANGE("Transaction Status", BookTr."Transaction Status"::Issued);
//             IntCount := BookTr.COUNT;
//             IF BookTransRec.Type = BookTransRec.Type::Student THEN BEGIN
//                 IF EducationSetup.Company = EducationSetup.Company::School THEN BEGIN
//                     IF Student.GET(BookTransRec."No.") THEN BEGIN
//                         IF LibrarySetupClassWise.GET(Student.Class) THEN BEGIN
//                             IF LibrarySetupClassWise."No. of Books - Students" <> 0 THEN
//                                 IntMaxBook := LibrarySetupClassWise."No. of Books - Students"
//                             ELSE
//                                 ERROR(Text002);
//                         END ELSE
//                             ERROR(Text003, Student.Class);
//                     END;
//                 END ELSE
//                     IF EducationSetup.Company = EducationSetup.Company::College THEN BEGIN
//                         IF StudentCOLLEGE.GET(BookTransRec."No.") THEN BEGIN
//                             IF LibrarySetupCourseWise.GET(StudentCOLLEGE."Course Code") THEN BEGIN
//                                 IF LibrarySetupCourseWise."No. of Books - Students" <> 0 THEN
//                                     IntMaxBook := LibrarySetupCourseWise."No. of Books - Students"
//                                 ELSE
//                                     ERROR(Text002);
//                             END ELSE
//                                 ERROR(Text004, StudentCOLLEGE."Course Code");
//                         END;
//                     END;
//             END ELSE
//                 IF BookTransRec.Type = BookTransRec.Type::Staff THEN
//                     IntMaxBook := LibrarySetup."No. of Books - Staffs";

//             // Start 09.GUNA
//             IF AccessionRec.GET(BookTransRec."Book No.", BookTransRec."Accession No.") THEN BEGIN
//                 AccessionRec.Booked := TRUE;
//                 AccessionRec.MODIFY;
//             END;
//             // Stop 09.GUNA
//             IF IntCount < IntMaxBook THEN BEGIN
//                 BookTransRec."Transaction Status" := BookTransRec."Transaction Status"::Issued;
//                 BookTransRec."Entry Type" := BookTransRec."Entry Type"::Issue;
//                 BookTransRec.MODIFY;
//                 MESSAGE(Text005);
//             END ELSE
//                 ERROR(Text006);
//         END;
//         // Stop 01.VIGNESH
//     end;

//     [Scope('Internal')]
//     procedure "Book Return"("EntryNo.": Integer)
//     begin
//         // Start 07.VIGNESH
//         BookTransRec.GET("EntryNo.");
//         BookTransRec.TESTFIELD("Actual Date of Return");
//         IF ((BookTransRec."Fine Amount" = 0) OR ((BookTransRec."Fine Amount" <> 0) AND BookTransRec.Invoiced)) THEN BEGIN
//             AccessionRec.GET(BookTransRec."Book No.", BookTransRec."Accession No.");
//             AccessionRec.Booked := FALSE;
//             AccessionRec.MODIFY;
//             BookTransRec."Transaction Status" := BookTransRec."Transaction Status"::Returned;
//             BookTransRec.MODIFY;
//             MESSAGE(Text007);
//         END ELSE
//             MESSAGE(Text008);
//         // Stop 07.VIGNESH
//     end;

//     [Scope('Internal')]
//     procedure "Book Creation"(BookNo: Code[20])
//     begin
//         // Start 03.AJAX
//         IF BookRec.GET(BookNo) THEN BEGIN
//             LibrarySetup.RESET;
//             LibrarySetup.GET;
//             ItemRec."No." := BookRec."No.";
//             ItemRec.Description := BookRec."Book Name";
//             ItemRec."Base Unit of Measure" := LibrarySetup."Base Unit of Measure";
//             ItemRec."Unit Price" := BookRec."Unit Cost";
//             ItemRec.VALIDATE("Item Category Code", LibrarySetup."Item Category Code");
//             ItemRec.INSERT;
//             MESSAGE(Text009);
//         END;
//         // Stop 03.AJAX
//     end;

//     [Scope('Internal')]
//     procedure "AccNo Creation"(BookNo: Code[20]; StartAccNo: Code[20]; Qty: Integer; PurchDate: Date)
//     begin
//         // Start 04.AJAX

//         LibrarySetup.GET;

//         ItemRec.RESET;
//         //ItemRec.SETCURRENTKEY("No.","Item Category Code");
//         ItemRec.SETRANGE("No.", BookNo);
//         ItemRec.SETRANGE("Item Category Code", LibrarySetup."Item Category Code");
//         IF ItemRec.FINDFIRST THEN BEGIN

//             AccessionRec.INIT;
//             //AccessionRec.SETCURRENTKEY("Book No.");
//             //AccessionRec.SETRANGE("Book No.",BookNo);
//             IF AccessionRec.FINDFIRST THEN
//                 FOR i := 1 TO Qty DO BEGIN
//                     IF i = 1 THEN BEGIN
//                         AccessionRec."Accession No." := StartAccNo;
//                         StartAccNo := AccessionRec."Accession No.";
//                     END ELSE BEGIN
//                         AccessionRec."Accession No." := INCSTR(StartAccNo);
//                         StartAccNo := AccessionRec."Accession No.";
//                     END;
//                     AccessionRec."Date of Purchase" := PurchDate;
//                     AccessionRec.VALIDATE("Book No.", BookNo);
//                     AccessionRec.INSERT;
//                 END;
//         END;
//         // Stop 04.AJAX
//     end;

//     [Scope('Internal')]
//     procedure "Advance Book"(BookingNo: Code[20])
//     begin
//         // Start 05.AJAX
//         IF AdvBook.GET(BookingNo) THEN BEGIN
//             AccessionRec.RESET;
//             AccessionRec.SETRANGE("Book No.", AdvBook."Book No.");
//             AccessionRec.SETRANGE("Advance Booked", FALSE);
//             IF AccessionRec.FINDSET THEN BEGIN
//                 AccessionRec.Type := AdvBook.Type;
//                 AccessionRec."Booked By" := AdvBook."No.";
//                 AccessionRec."Advance Booked" := TRUE;
//                 AccessionRec.MODIFY;
//                 AdvBook.Booked := TRUE;
//                 AdvBook."Accession No." := AccessionRec."Accession No.";
//                 AdvBook.MODIFY;
//                 IF GUIALLOWED THEN
//                     MESSAGE(Text010);
//             END;
//         END;
//         // Stop 05.AJAX
//     end;

//     [Scope('Internal')]
//     procedure "Calculate Fine"("getEntryNo.": Integer; getDate: Date): Decimal
//     var
//         BookTransaction: Record Table71632;
//         CountDays: Integer;
//     begin
//         // Start 06.VIGNESH
//         BookTransaction.GET("getEntryNo.");
//         LibrarySetup.GET;

//         IF getDate > BookTransaction."Date of Return" THEN
//             CountDays := getDate - BookTransaction."Date of Return";
//         // Calculating Fine amount for Students
//         LibrarySetup.GET;
//         IF BookTransaction.Type = BookTransaction.Type::Student THEN BEGIN
//             IF LibrarySetup."Fine - Students" = 0 THEN
//                 ERROR(Text011);
//             IF CountDays <> 0 THEN
//                 EXIT(LibrarySetup."Fine - Students" * CountDays)
//             ELSE
//                 EXIT(0);
//         END ELSE
//             IF BookTransaction.Type = BookTransaction.Type::Staff THEN BEGIN
//                 IF LibrarySetup."Fine - Staffs" = 0 THEN
//                     ERROR(Text012);
//                 IF CountDays <> 0 THEN
//                     EXIT(LibrarySetup."Fine - Staffs" * CountDays)
//                 ELSE
//                     EXIT(0);
//             END;
//         // Stop 06.VIGNESH
//     end;

//     [Scope('Internal')]
//     procedure "Pay Fine"("getEntryNo.": Integer)
//     var
//         FeeManagement: Codeunit "Fee Management";
//         FeeManagementCOLLEGE: Codeunit Codeunit71357;
//         BookTransaction: Record Table71632;
//         "LocalInvoiceNo.": Code[20];
//         FeeSetup: Record "Fee Setup";
//         GenJournalLine: Record "Gen. Journal Line";
//         FeeSetupCollege: Record Table71387;
//     begin
//         // Start 07.VIGNESH
//         BookTransaction.GET("getEntryNo.");
//         IF (BookTransaction."Fine Amount" <> 0) AND (NOT BookTransaction.Invoiced) THEN BEGIN
//             IF BookTransaction."Invoice No." <> '' THEN
//                 ERROR(Text013);
//             LibrarySetup.GET;
//             LibrarySetup.TESTFIELD("Fine Code");
//             // Post Through Sales Order
//             /*
//             EducationSetup.GET;
//             IF EducationSetup.Company = EducationSetup.Company::School THEN BEGIN
//               BookTransaction."Invoice No." :=
//                 FeeManagement."Post Sales"(BookTransaction."No.",LibrarySetup."Fine Code",BookTransaction."Fine Amount");
//             END ELSE
//               IF EducationSetup.Company = EducationSetup.Company::College THEN
//                 BookTransaction."Invoice No." := FeeManagementCOLLEGE."Post Sales"(BookTransaction."No.",LibrarySetup."Fine Code",
//                 BookTransaction."Fine Amount");
//             IF BookTransaction."Invoice No." <> '' THEN
//               BookTransaction.Invoiced := TRUE;
//             BookTransaction.MODIFY;
//             */
//             // Post Through Journal Line
//             EducationSetup.GET;
//             IF EducationSetup.Company = EducationSetup.Company::School THEN BEGIN
//                 FeeManagement.FeeProcess(BookTransaction."No.", LibrarySetup."Fine Code", BookTransaction."Fine Amount");
//                 FeeSetup.GET;
//                 FeeSetup.TESTFIELD("Journal Template Name");
//                 FeeSetup.TESTFIELD("Journal Batch Name");
//             END ELSE
//                 IF EducationSetup.Company = EducationSetup.Company::College THEN BEGIN
//                     FeeManagementCOLLEGE.FeeProcess(BookTransaction."No.", LibrarySetup."Fine Code", BookTransaction."Fine Amount");
//                     //Start 10.Ankesh
//                     FeeSetupCollege.GET;
//                     FeeSetupCollege.TESTFIELD("Journal Template Name");
//                     FeeSetupCollege.TESTFIELD("Journal Batch Name");
//                     // Stop 10.Ankesh
//                 END;
//             GenJournalLine.RESET;
//             GenJournalLine.SETRANGE("Journal Template Name", FeeSetup."Journal Template Name");
//             GenJournalLine.SETRANGE("Journal Batch Name", FeeSetup."Journal Batch Name");
//             IF GenJournalLine.FINDSET THEN BEGIN
//                 "LocalInvoiceNo." := GenJournalLine."Document No.";
//                 CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
//             END;
//             IF "LocalInvoiceNo." <> '' THEN
//                 BookTransaction."Invoice No." := "LocalInvoiceNo.";
//             BookTransaction.Invoiced := TRUE;
//             BookTransaction.MODIFY;
//             MESSAGE(Text014);
//         END;
//         // Stop 07.VIGNESH

//     end;

//     [Scope('Internal')]
//     procedure "Book Renewal"("EntryNo.": Integer)
//     var
//         BookTransaction: Record Table71632;
//         BookTransaction1: Record Table71632;
//         IntEligible: Integer;
//         IntRenewal: Integer;
//     begin
//         // Start 11.ABK
//         BookTransaction.GET("EntryNo.");
//         BEGIN
//             IntEligible := 0;
//             IntRenewal := 0;
//             IF BookTransaction.Type = BookTransaction.Type::Student THEN
//                 IF StudentCOLLEGE.GET(BookTransaction."No.") THEN
//                     IF LibrarySetupCourseWise.GET(StudentCOLLEGE."Course Code") THEN
//                         IntEligible := LibrarySetupCourseWise."No. of Renewal - Students";
//             IF IntEligible = 0 THEN
//                 ERROR(Text015);

//             BookTransaction1.RESET;
//             BookTransaction1.SETRANGE("No.", BookTransaction."No.");
//             BookTransaction1.SETRANGE("Accession No.", BookTransaction."Accession No.");
//             BookTransaction1.SETRANGE("Entry Type", BookTransaction1."Entry Type"::Renewal);
//             IntRenewal := BookTransaction1.COUNT;
//             IF IntRenewal >= IntEligible THEN
//                 ERROR(Text016);
//         END;
//         // Stop 11.ABK
//         // Start 08. VANDHANA
//         BookTransaction.GET("EntryNo.");
//         BEGIN
//             BookTransaction."Transaction Status" := BookTransaction."Transaction Status"::Returned;
//             BookTransaction."Actual Date of Return" := WORKDATE;
//             BookTransaction.MODIFY;
//             BookTransaction1.INIT;
//             BookTransaction1.Type := BookTransaction.Type;
//             BookTransaction1."Entry Type" := BookTransaction1."Entry Type"::Renewal;
//             BookTransaction1.VALIDATE("No.", BookTransaction."No.");
//             BookTransaction1.Name := BookTransaction.Name;
//             BookTransaction1."Accession No." := BookTransaction."Accession No.";
//             BookTransaction1."Book No." := BookTransaction."Book No.";
//             BookTransaction1."Book Name" := BookTransaction."Book Name";
//             BookTransaction1."Date of Issue" := WORKDATE;
//             BookTransaction1."User ID" := BookTransaction."User ID";
//             BookTransaction1."Transaction Status" := BookTransaction1."Transaction Status"::Issued;
//             BookTransaction1."Renewal Entry No." := BookTransaction."Entry No.";
//             BookTransaction1.INSERT(TRUE);
//             MESSAGE(Text017);
//         END;
//         // Stop 08. VANDHANA
//     end;

//     [Scope('Internal')]
//     procedure "Book Availablity"(BookNo: Code[20]) Ret: array[2] of Boolean
//     var
//         Book: Record Table71630;
//         BookAccession: Record Table71631;
//     begin
//     end;
// }

