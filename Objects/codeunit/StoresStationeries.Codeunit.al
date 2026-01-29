codeunit 71850 "Stores & Stationeries"
{
    //   No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    //  01   13/10/09  KATHIR    Line Post()               Function added to Get the students and Insert Items for repective students
    //  02   13/10/09  KATHIR    Post Items()              Function added to Create Sales Order and Post
    //  03   21/10/09  KATHIR    Insert Issue Line()       Function added to get Insert in to Line
    //  04   16.11.09  GUNA      Post Items()              To include free supply


    trigger OnRun()
    begin
    end;

    var
        Student: Record Student;
        BulkHeader: Record Table71850;
        BulkIssues: Record Table71852;
        BulkLine: Record Table71851;
        SalesHead: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesPost: Codeunit "Sales-Post";
        StoresSetup: Record Table71854;
        EducationSetup: Record "Education Setup";
        BulkStationeryHeader: Record Table71855;
        BulkStationeryLine: Record Table71856;
        StudentCOLLEGE: Record Table71355;
        "SetLineNo.": Integer;
        Text000: Label 'Please select the items';
        Text001: Label 'Nothing to post';
        BulkLine2: Record Table71851;
        Student2: Record Student;

    [Scope('Internal')]
    procedure "Line Post"("IssueNo.": Code[20])
    begin
        // Start 01.KATHIR
        BulkHeader.GET("IssueNo.");
        BulkLine2.SETRANGE(BulkLine2."Document No.", "IssueNo.");
        IF BulkLine2.FINDSET THEN BEGIN
            IF CONFIRM('Do u want to delete the exisitng \ line and update with the new !!!') THEN
                BulkLine2.DELETEALL;
        END;

        IF NOT BulkHeader."Dormitory Wise" THEN BEGIN
            BulkHeader.TESTFIELD("Indent No");
            BulkHeader.TESTFIELD("Issue Date");
            BulkHeader.TESTFIELD(BulkHeader."Class Code");
            BulkIssues.RESET;
            BulkIssues.SETRANGE("Document No.", "IssueNo.");
            IF BulkIssues.FINDSET THEN
                REPEAT
                    BulkIssues.TESTFIELD(Quantity);
                    Student.RESET;
                    Student.SETCURRENTKEY("Class Code");
                    Student.SETRANGE(Student."Class Code", BulkHeader."Class Code");
                    Student.SETRANGE("Student Status", Student."Student Status"::Student);
                    IF Student.FINDSET THEN
                        REPEAT
                            "Insert Issue Line"("IssueNo.", BulkHeader."Issue Date", Student."No.", Student.Name,
                              BulkIssues."Item No", BulkIssues.Quantity);
                        UNTIL Student.NEXT = 0;
                UNTIL BulkIssues.NEXT = 0
            ELSE
                ERROR(Text000);
        END ELSE BEGIN
            BulkIssues.RESET;
            BulkIssues.SETRANGE(BulkIssues."Document No.", "IssueNo.");
            IF BulkIssues.FINDSET THEN
                REPEAT
                    BulkIssues.TESTFIELD(BulkIssues.Quantity);
                    Student.RESET;
                    Student.SETRANGE(Student."Hostel Code", BulkHeader.Dormitory);
                    Student.SETRANGE(Student."Student Status", Student."Student Status"::Student);
                    IF Student.FINDSET THEN
                        REPEAT
                            "Insert Issue Line"("IssueNo.", BulkHeader."Issue Date", Student."No.", Student.Name,
                                              BulkIssues."Item No", BulkIssues.Quantity);
                        UNTIL Student.NEXT = 0;
                UNTIL BulkIssues.NEXT = 0
            ELSE
                ERROR('Please Select Items');
        END;

        // Stop 01.KATHIR
    end;

    [Scope('Internal')]
    procedure "Post Items"("IssueNo.": Code[20])
    begin
        // Start 02.KATHIR
        BulkLine.RESET;
        BulkHeader.GET("IssueNo.");
        BulkHeader.TESTFIELD(BulkHeader.Location);
        StoresSetup.GET;
        StoresSetup.TESTFIELD("Fee Code");
        BulkLine.SETRANGE("Document No.", "IssueNo.");
        IF BulkLine.ISEMPTY THEN
            ERROR(Text001);
        IF BulkLine.FINDSET THEN
            REPEAT
                SalesHead.INIT;
                SalesHead."Document Type" := SalesHead."Document Type"::Order;
                SalesHead."No." := '';
                SalesHead."Document Date" := TODAY;
                SalesHead."Posting Date" := BulkLine."Issue Date";
                SalesHead.VALIDATE("Sell-to Customer No.", BulkLine."Student No.");
                SalesHead."External Document No." := BulkLine."Document No.";
                SalesHead."Due Date" := TODAY;
                SalesHead."Order Date" := BulkLine."Issue Date";
                SalesHead."Fee Code" := StoresSetup."Fee Code";
                SalesHead.Ship := TRUE;
                SalesHead.Invoice := TRUE;
                SalesHead."Type of Fees" := SalesHead."Type of Fees"::Others;

                IF Student.GET(BulkLine."Student No.") THEN
                    SalesHead."Class Code" := Student."Class Code";
                //Commented By ARAVIND 11/11/10
                /*
                  IF NOT BulkHeader."Charge All" THEN
                    IF Student2.GET(BulkLine."Student No.") THEN
                      IF  Student2."New Student" = TRUE  THEN
                        IF Student2."Staff Child" = FALSE THEN
                          IF ((Student2."Student Status" = 4) OR (Student2."Student Status" = 1)) THEN BEGIN
                            SalesHead."Free Supply":=TRUE;
                            SalesHead.VALIDATE(SalesHead."Free Supply");
                           END;
                 */
                //Commented By ARAVIND 11/11/10

                //ARAVIND
                IF BulkHeader."Free Supply" THEN BEGIN
                    SalesHead."Free Supply" := TRUE;
                    SalesHead.VALIDATE(SalesHead."Free Supply");
                END;
                //ARAVIND


                /*
                // Start 04.GUNA
                IF BulkHeader."Charge All" THEN
                  SalesHead."Free Supply" := TRUE;
                // Stop 04.GUNA
                */
                BulkLine.CALCFIELDS(Location);
                SalesHead.INSERT(TRUE);
                IF BulkLine.Location <> '' THEN BEGIN
                    SalesHead.VALIDATE("Location Code", BulkLine.Location);
                    SalesHead.MODIFY;
                END;
                SalesLine.INIT;
                SalesLine."Document Type" := SalesHead."Document Type";
                SalesLine."Document No." := SalesHead."No.";
                SalesLine."Line No." := SalesLine."Line No." + 10000;
                SalesLine.VALIDATE("Sell-to Customer No.", SalesHead."Sell-to Customer No.");
                SalesLine.Type := SalesLine.Type::Item;
                SalesLine.VALIDATE("No.", BulkLine."Item No");
                SalesLine.Description := BulkLine.Description;
                SalesLine.Quantity := BulkLine.Quantity;
                SalesLine.VALIDATE(Quantity, BulkLine.Quantity);
                SalesLine."Unit of Measure" := BulkLine.UOM;
                SalesLine."Unit Price" := BulkLine."Unit Price";
                SalesLine."Line Amount" := BulkLine."Line Amount";
                SalesLine.INSERT(TRUE);
                SalesPost.RUN(SalesHead);
            UNTIL BulkLine.NEXT = 0;
        IF BulkHeader.GET("IssueNo.") THEN BEGIN
            BulkHeader.Posted := TRUE;
            BulkHeader.MODIFY;
        END;
        // Stop 02.KATHIR

    end;

    [Scope('Internal')]
    procedure "Insert Issue Line"("IssNo.": Code[20]; IssDate: Date; "StudNo.": Code[20]; Name: Text[100]; "ItmNo.": Code[20]; Qty: Integer)
    begin
        // Start 03.KATHIR
        BulkLine."Document No." := "IssNo.";
        BulkLine."Issue Date" := IssDate;
        BulkLine."Line No." += 10000;
        BulkLine."Serial No" += 1;
        BulkLine."Student No." := "StudNo.";
        BulkLine."Student Name" := Name;
        BulkLine.Type := BulkLine.Type::Item;
        BulkLine."Item No" := "ItmNo.";
        BulkLine.VALIDATE("Item No");
        BulkLine.Quantity := Qty;
        BulkLine."Line Amount" := BulkHeader.Quantity * BulkLine."Unit Price";
        BulkLine.VALIDATE(Quantity);
        BulkLine.INSERT;
        // Stop 03.KATHIR
    end;

    [Scope('Internal')]
    procedure "Bulk Stationery Line Post"("IssueNo.": Code[20])
    begin
        // Start 05.VIGNESH
        "SetLineNo." := 0;
        BulkStationeryHeader.GET("IssueNo.");
        BulkStationeryHeader.TESTFIELD("Indent No");
        BulkStationeryHeader.TESTFIELD("Issue Date");
        BulkStationeryHeader.TESTFIELD(Course);
        BulkStationeryHeader.TESTFIELD(Semester);
        BulkStationeryHeader.TESTFIELD("Academic Year");
        BulkIssues.RESET;
        BulkIssues.SETRANGE("Document No.", "IssueNo.");
        IF BulkIssues.FINDSET THEN
            REPEAT
                BulkIssues.TESTFIELD(Quantity);
                StudentCOLLEGE.RESET;
                StudentCOLLEGE.SETCURRENTKEY("Course Code", Semester, "Academic Year");
                StudentCOLLEGE.SETRANGE("Course Code", BulkStationeryHeader.Course);
                StudentCOLLEGE.SETRANGE(Semester, BulkStationeryHeader.Semester);
                StudentCOLLEGE.SETRANGE("Academic Year", BulkStationeryHeader."Academic Year");
                StudentCOLLEGE.SETRANGE(Section, BulkStationeryHeader.Section);
                StudentCOLLEGE.SETRANGE("Student Status", StudentCOLLEGE."Student Status"::Student);
                IF StudentCOLLEGE.FINDSET THEN
                    REPEAT
                        "SetLineNo." := "SetLineNo." + 10000;
                        "Insert Bulk Stationery Line"(BulkStationeryHeader."No.", BulkStationeryHeader."Issue Date",
                          StudentCOLLEGE."No.", StudentCOLLEGE."Student Name", BulkIssues."Item No", BulkIssues.Quantity, "SetLineNo.");
                    UNTIL StudentCOLLEGE.NEXT = 0;
            UNTIL BulkIssues.NEXT = 0
        ELSE
            ERROR(Text000);
        // Stop 05.VIGNESH
    end;

    [Scope('Internal')]
    procedure "Insert Bulk Stationery Line"("getIssueNo.": Code[20]; getIssueDate: Date; "getStudentNo.": Code[20]; getName: Text[100]; "getItemNo.": Code[20]; getQuantity: Integer; "getLineNo.": Integer)
    begin
        // Start 06.VIGNESH
        BulkStationeryLine.INIT;
        BulkStationeryLine."Document No." := "getIssueNo.";
        BulkStationeryLine."Line No." := "getLineNo.";
        BulkStationeryLine."Student No." := "getStudentNo.";
        BulkStationeryLine."Student Name" := getName;
        BulkStationeryLine.Type := BulkStationeryLine.Type::Item;
        BulkStationeryLine."Item No" := "getItemNo.";
        BulkStationeryLine.VALIDATE("Item No");
        BulkStationeryLine.Quantity := getQuantity;
        BulkStationeryLine."Line Amount" := BulkStationeryLine.Quantity * BulkStationeryLine."Unit Price";
        BulkStationeryLine.VALIDATE(Quantity);
        BulkStationeryLine.INSERT;
        // Stop 06.VIGNESH
    end;

    [Scope('Internal')]
    procedure "Post Bulk Stationery Items"("IssueNo.": Code[20])
    begin
        // Start 02.VIGENSH
        BulkStationeryLine.RESET;
        BulkStationeryHeader.GET("IssueNo.");

        StoresSetup.GET;
        StoresSetup.TESTFIELD("Fee Code");
        BulkStationeryLine.SETRANGE("Document No.", "IssueNo.");
        IF BulkStationeryLine.ISEMPTY THEN
            ERROR(Text001);
        IF BulkStationeryLine.FINDSET THEN
            REPEAT
                SalesHead.INIT;
                SalesHead."Document Type" := SalesHead."Document Type"::Order;
                SalesHead."No." := '';
                SalesHead."Document Date" := TODAY;
                SalesHead."Posting Date" := BulkStationeryLine."Issue Date";
                SalesHead.VALIDATE("Sell-to Customer No.", BulkStationeryLine."Student No.");
                SalesHead."External Document No." := BulkStationeryLine."Document No.";
                SalesHead."Due Date" := TODAY;
                SalesHead."Order Date" := BulkStationeryLine."Issue Date";
                SalesHead."Fee Code" := StoresSetup."Fee Code";
                SalesHead.Ship := TRUE;
                SalesHead.Invoice := TRUE;
                // Start 04.GUNA
                IF BulkStationeryHeader."Free Supply" THEN
                    SalesHead."Free Supply" := TRUE;
                // Stop 04.GUNA

                BulkStationeryLine.CALCFIELDS(Location);
                SalesHead.INSERT(TRUE);
                IF BulkStationeryLine.Location <> '' THEN BEGIN
                    SalesHead.VALIDATE("Location Code", BulkStationeryLine.Location);
                    SalesHead.MODIFY;
                END;
                SalesLine.INIT;
                SalesLine."Document Type" := SalesHead."Document Type";
                SalesLine."Document No." := SalesHead."No.";
                SalesLine."Line No." := SalesLine."Line No." + 10000;
                SalesLine.VALIDATE("Sell-to Customer No.", SalesHead."Sell-to Customer No.");
                SalesLine.Type := SalesLine.Type::Item;
                SalesLine.VALIDATE("No.", BulkStationeryLine."Item No");
                SalesLine.Description := BulkStationeryLine.Description;
                SalesLine.Quantity := BulkStationeryLine.Quantity;
                SalesLine.VALIDATE(Quantity, BulkStationeryLine.Quantity);
                SalesLine."Unit of Measure" := BulkStationeryLine.UOM;
                SalesLine."Unit Price" := BulkStationeryLine."Unit Price";
                SalesLine."Line Amount" := BulkStationeryLine."Line Amount";
                SalesLine.INSERT(TRUE);
                SalesPost.RUN(SalesHead);
            UNTIL BulkStationeryLine.NEXT = 0;

        IF BulkStationeryHeader.GET("IssueNo.") THEN BEGIN
            BulkStationeryHeader.Posted := TRUE;
            BulkStationeryHeader.MODIFY;
        END;
        // Stop 02.VIGNESH
    end;
}

