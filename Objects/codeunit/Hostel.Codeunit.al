codeunit 71680 Hostel
{
    //   No   Date      Sign     Trigger            Description
    // -----------------------------------------------------------------------------------------------
    //   01   08/10/09  KATHIR  Room Allocation()        Function added to Allot Room for a student
    //   02   08/10/09  KATHIR  Vacate Room()            Function added for a student for Vacate Room
    //   03   13/10/09 VIGNESH  GetStudents()            Function addted to get the hostel students
    //   04   13/10/09 VIGNESH  Post Journal()           Function Added to Post the Hostel Fees
    //   05   14/10/09 VIGNESH  Calculate Mess Amount()  Function Added for Mess Fees
    //   06   14/10/19 VIGNESH Calculate Consumption()   Function added to calulate the consumption
    //   07   14/12/09 VIGNESH AllotRoom No. -VIT()      Function added to allot Hoste Room No. for a Student
    //   08   14/12/09 VIGNESH VacateRoom - VIT()        Function added to vacate the student from hostel
    //   09   14/12/09 VIGNESH ChangeRoom -VIT()         Function Added to change the Hostel Rooms
    //   10   14/12/09 VIGNESH ChangeMess - VIT()        Function added to change the mess
    //   11   24/03/10 Ankesh  AllotRoom No. -VIT()      Code commented to unavoid invoicing while alloting room
    //   12   24/03/10 Ankesh  Calculate Consumption()   Code Modified to calculate for mess and electricity consumption.


    trigger OnRun()
    begin
    end;

    var
        RoomAllocation: Record Table71682;
        HostelRooms: Record Table71681;
        Student: Record Student;
        StudentCOLLEGE: Record Table71355;
        HostelRoomsLine: Record Table71689;
        FeeManagement: Codeunit "Fee Management";
        FeeManagementCOLLEGE: Codeunit Codeunit71357;
        HostelSetup: Record Table71683;
        RoomType: Record Table71688;
        FeeSetup: Record "Fee Setup";
        FeeSetupCOLLEGE: Record Table71387;
        GenJournalLine: Record "Gen. Journal Line";
        RoomChange: Record Table71690;
        MessChange: Record Table71694;
        Text000: Label 'Student not Found';
        Text001: Label 'Room allocate for %1';
        Text002: Label '%1 Vacated the Room Succesfully';
        Text003: Label 'You cannot regenrate already posted';
        Text004: Label ' Fess is generated already';
        Text005: Label 'Mess Fee is Not generated for Hostel %1';
        Text006: Label 'Fees Generated';
        Text007: Label 'Please enter the Total Expence for the Mess Location %1';
        Text008: Label 'Please Specify Total Expence';
        Text009: Label 'Please generate Hostel Fee for Hostel Code %1';
        Text010: Label 'Only for consumption total Amount can be calculated';
        Text011: Label 'Date Range Should be Filled';
        Text012: Label 'Consumption is not Entered yet';
        Text013: Label 'Consumption Amount updated';
        Text014: Label 'Electricity Consumption is not Entered yet';
        Text015: Label 'Electricity Consumption Amount updated';
        Text016: Label 'Already Room had been alloted for this Student %1';
        Text017: Label 'Already Room had been Vacated for this Student %1';
        Text018: Label 'You can not modified the same';
        Text019: Label '%1 Room cahnged Succesfully';
        Text020: Label ' Mess Change Update Completed';
        Text021: Label 'Do you want to Delete & Update the Students';
        Text022: Label 'Do you want to Allot Room';
        Text023: Label 'Do you want to Change Mess';
        Text024: Label 'Do you want to Change Room';

    [Scope('Internal')]
    procedure "Room Allocation"("HostelNo.": Code[20])
    begin
        // Start 01.KATHIR
        RoomAllocation.GET("HostelNo.");
        RoomAllocation.TESTFIELD("Student No.");
        RoomAllocation.TESTFIELD("Hostel No.");
        RoomAllocation.TESTFIELD("Room No");
        RoomAllocation.TESTFIELD(BedNo);
        RoomAllocation.RoomAlloted := TRUE;
        RoomAllocation.MODIFY;
        IF HostelRooms.GET(RoomAllocation."Hostel No.", RoomAllocation."Room No", RoomAllocation.BedNo) THEN BEGIN
            HostelRooms.Alloted := TRUE;
            HostelRooms.MODIFY;
        END;

        IF RoomAllocation.Company = RoomAllocation.Company::School THEN
            IF Student.GET(RoomAllocation."Student No.") THEN BEGIN
                Student."Room No." := RoomAllocation."Room No";
                Student."Hostel Code" := RoomAllocation."Hostel No.";
                Student."Hostel Alloted" := TRUE;
                Student.MODIFY;
            END ELSE
                ERROR(Text000);

        IF RoomAllocation.Company = RoomAllocation.Company::College THEN
            IF StudentCOLLEGE.GET(RoomAllocation."Student No.") THEN BEGIN
                StudentCOLLEGE."Room No." := RoomAllocation."Room No";
                StudentCOLLEGE."Hostel Code" := RoomAllocation."Hostel No.";
                StudentCOLLEGE."Hostel Alloted" := TRUE;
                StudentCOLLEGE.MODIFY;
            END ELSE
                ERROR(Text000);
        MESSAGE(Text001, RoomAllocation."Student Name");
        // Stop 01.KATHIR
    end;

    [Scope('Internal')]
    procedure "Vacate Room"("HostelNo.": Code[20])
    begin
        // Start 02.KATHIR
        RoomAllocation.GET("HostelNo.");
        RoomAllocation.TESTFIELD("Student No.");
        RoomAllocation.TESTFIELD("Hostel No.");
        RoomAllocation.TESTFIELD("Room No");
        RoomAllocation.TESTFIELD(BedNo);
        IF RoomAllocation."Vacate Date" = 0D THEN
            RoomAllocation."Vacate Date" := TODAY;
        RoomAllocation.Vacated := TRUE;
        RoomAllocation.MODIFY;

        IF HostelRooms.GET(RoomAllocation."Hostel No.", RoomAllocation."Room No", RoomAllocation.BedNo) THEN BEGIN
            HostelRooms.Alloted := FALSE;
            HostelRooms.MODIFY;
        END;

        IF RoomAllocation.Company = RoomAllocation.Company::School THEN
            IF Student.GET(RoomAllocation."Student No.") THEN BEGIN
                Student."Room No." := '';
                Student."Hostel Code" := '';
                Student."Hostel Alloted" := FALSE;
                Student."Hostel Vacated" := TRUE;
                Student.MODIFY;
            END ELSE
                ERROR(Text000);

        IF RoomAllocation.Company = RoomAllocation.Company::College THEN
            IF StudentCOLLEGE.GET(RoomAllocation."Student No.") THEN BEGIN
                StudentCOLLEGE."Room No." := '';
                StudentCOLLEGE."Hostel Code" := '';
                StudentCOLLEGE."Hostel Alloted" := FALSE;
                StudentCOLLEGE."Hostel Vacated" := TRUE;
                StudentCOLLEGE.MODIFY;
            END ELSE
                ERROR(Text000);

        MESSAGE(Text002, RoomAllocation."Student Name");
        // Stop 02.KATHIR
    end;

    [Scope('Internal')]
    procedure GetStudents("getBillNo.": Code[20])
    var
        EducationSetup: Record "Education Setup";
        HostelFee: Record Table71684;
        HostelFeeLine: Record Table71685;
        LocalLineNo: Integer;
    begin
        // Start 03.VIGNESH

        EducationSetup.GET;
        HostelFee.GET("getBillNo.");

        IF HostelFee.Closed THEN
            ERROR(Text003);

        HostelFeeLine.RESET;
        HostelFeeLine.SETRANGE("Bill No.", "getBillNo.");
        IF HostelFeeLine.FINDFIRST THEN
            IF CONFIRM(Text021, FALSE) THEN
                HostelFeeLine.DELETEALL
            ELSE
                EXIT;

        IF EducationSetup.Company = EducationSetup.Company::School THEN BEGIN
            LocalLineNo := 0;
            Student.RESET;
            Student.SETRANGE("Hostel Code", HostelFee."Hostel Code");
            Student.SETRANGE("Hostel Alloted", TRUE);
            IF Student.FINDSET THEN
                REPEAT
                    LocalLineNo += 10000;
                    HostelFeeLine.INIT;
                    HostelFeeLine."Bill No." := HostelFee."Bill No.";
                    HostelFeeLine."Line No." := LocalLineNo;
                    HostelFeeLine."Hostel Code" := HostelFee."Hostel Code";
                    HostelFeeLine."Student No." := Student."No.";
                    HostelFeeLine."Total Days" := HostelFee."Billable Days";
                    HostelFeeLine.INSERT;
                UNTIL Student.NEXT = 0;
        END;

        IF EducationSetup.Company = EducationSetup.Company::College THEN BEGIN
            StudentCOLLEGE.RESET;
            StudentCOLLEGE.SETRANGE("Hostel Code", HostelFee."Hostel Code");
            StudentCOLLEGE.SETRANGE("Hostel Alloted", TRUE);
            IF StudentCOLLEGE.FINDSET THEN
                REPEAT
                    LocalLineNo += 10000;
                    HostelFeeLine.INIT;
                    HostelFeeLine."Bill No." := HostelFee."Bill No.";
                    HostelFeeLine."Line No." := LocalLineNo;
                    HostelFeeLine."Hostel Code" := HostelFee."Hostel Code";
                    HostelFeeLine."Student No." := StudentCOLLEGE."No.";
                    HostelFeeLine."Total Days" := HostelFee."Billable Days";
                    HostelFeeLine."Days Present" := HostelFee."Billable Days";
                    HostelFeeLine.INSERT;
                UNTIL StudentCOLLEGE.NEXT = 0;
        END;
        HostelFee.Update := TRUE;
        HostelFee.MODIFY;
        // Stop 03.VIGNESH
    end;

    [Scope('Internal')]
    procedure "Post Journal"("getBillNo.": Code[20])
    var
        HostelFeeLine: Record Table71685;
        Hostel: Record Table71680;
        EducationSetup: Record "Education Setup";
        FeeManagenmentCOLLEGE: Codeunit Codeunit71357;
        HostelFee: Record Table71684;
        MessTotalExpense: Record Table71686;
    begin
        // Start 04.VIGNESH
        HostelFee.GET("getBillNo.");
        Hostel.GET(HostelFee."Hostel Code");

        IF HostelFee.Closed THEN
            ERROR(Text004);

        HostelFeeLine.RESET;
        HostelFeeLine.SETRANGE("Bill No.", "getBillNo.");
        HostelFeeLine.SETFILTER("Days Present", '<>%1', 0);
        HostelFeeLine.SETRANGE("Fee Amount", 0);
        IF HostelFeeLine.FINDFIRST THEN
            ERROR(Text005, Hostel.Code);

        HostelSetup.GET;
        HostelSetup.TESTFIELD("Hostel Fee Code");
        EducationSetup.GET;

        IF EducationSetup.Company = EducationSetup.Company::School THEN BEGIN
            FeeSetup.GET;
            FeeSetup.TESTFIELD("Journal Template Name");
            FeeSetup.TESTFIELD("Journal Batch Name");
        END;

        IF EducationSetup.Company = EducationSetup.Company::College THEN BEGIN
            FeeSetupCOLLEGE.GET;
            FeeSetupCOLLEGE.TESTFIELD("Journal Template Name");
            FeeSetupCOLLEGE.TESTFIELD("Journal Batch Name");
        END;

        HostelFeeLine.RESET;
        HostelFeeLine.SETRANGE("Bill No.", "getBillNo.");
        IF HostelFeeLine.FINDSET THEN
            REPEAT
                IF (EducationSetup.Company = EducationSetup.Company::School) AND
                   (HostelFeeLine."Fee Amount" <> 0)
                THEN
                    FeeManagement.FeeProcess(HostelFeeLine."Student No.", HostelSetup."Hostel Fee Code", HostelFeeLine."Fee Amount");
                IF (EducationSetup.Company = EducationSetup.Company::College) AND
                   (HostelFeeLine."Fee Amount" <> 0)
                THEN
                    FeeManagenmentCOLLEGE.FeeProcess(HostelFeeLine."Student No.", HostelSetup."Hostel Fee Code",
                      HostelFeeLine."Fee Amount");
            UNTIL HostelFeeLine.NEXT = 0;

        IF EducationSetup.Company = EducationSetup.Company::School THEN BEGIN
            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name", FeeSetup."Journal Template Name");
            GenJournalLine.SETRANGE("Journal Batch Name", FeeSetup."Journal Batch Name");
        END;

        IF EducationSetup.Company = EducationSetup.Company::College THEN BEGIN
            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCOLLEGE."Journal Template Name");
            GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCOLLEGE."Journal Batch Name");
        END;

        IF GenJournalLine.FINDSET THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
            MessTotalExpense.RESET;
            MessTotalExpense.SETRANGE("Mess Location", Hostel.Mess);
            MessTotalExpense.SETRANGE("From Date", HostelFee."Start Date");
            MessTotalExpense.SETRANGE("To Date", HostelFee."End Date");
            MessTotalExpense.SETRANGE(Closed, FALSE);
            MessTotalExpense.MODIFYALL(Closed, TRUE);
            HostelFee.Closed := TRUE;
            HostelFee.MODIFY;
            MESSAGE(Text006);
        END;
        // Stop 04.VIGNESH
    end;

    [Scope('Internal')]
    procedure "Calculate Mess Amount"(getLocation: Code[20])
    var
        Hostel: Record Table71680;
        HostelFee: Record Table71684;
        HostelFeeLine: Record Table71685;
        MessTotalExpense: Record Table71686;
        TotalExpense: Decimal;
        PerStudentAmount: Decimal;
        StartDate: Date;
        EndDate: Date;
        TotalPresent: Integer;
    begin
        // Start 05.VIGNESH
        TotalExpense := 0;
        MessTotalExpense.RESET;
        MessTotalExpense.SETRANGE("Mess Location", getLocation);
        MessTotalExpense.SETRANGE(Closed, FALSE);
        IF MessTotalExpense.ISEMPTY THEN
            ERROR(Text007, getLocation)
        ELSE
            IF MessTotalExpense.FINDSET THEN
                REPEAT
                    TotalExpense += MessTotalExpense."Total Amount";
                    StartDate := MessTotalExpense."From Date";
                    EndDate := MessTotalExpense."To Date";
                UNTIL MessTotalExpense.NEXT = 0;

        IF TotalExpense = 0 THEN
            ERROR(Text008);

        PerStudentAmount := 0;
        TotalPresent := 0;
        Hostel.RESET;
        Hostel.SETRANGE(Mess, getLocation);
        IF Hostel.FINDSET THEN
            REPEAT
                HostelFee.RESET;
                HostelFee.SETRANGE("Hostel Code", Hostel.Code);
                HostelFee.SETRANGE("Start Date", StartDate);
                HostelFee.SETRANGE("End Date", EndDate);
                HostelFee.SETRANGE(Update, TRUE);
                HostelFee.SETRANGE(Closed, FALSE);
                IF HostelFee.ISEMPTY THEN
                    ERROR(Text009, Hostel.Code)
                ELSE
                    IF HostelFee.FINDFIRST THEN BEGIN
                        HostelFeeLine.RESET;
                        HostelFeeLine.SETRANGE("Bill No.", HostelFee."Bill No.");
                        IF HostelFeeLine.FINDSET THEN
                            REPEAT
                                TotalPresent += HostelFeeLine."Days Present";
                            UNTIL HostelFeeLine.NEXT = 0;
                    END;
            UNTIL Hostel.NEXT = 0;

        IF TotalPresent <> 0 THEN
            PerStudentAmount := TotalExpense / TotalPresent;

        Hostel.RESET;
        Hostel.SETRANGE(Mess, getLocation);
        IF Hostel.FINDSET THEN
            REPEAT
                HostelFee.RESET;
                HostelFee.SETRANGE("Hostel Code", Hostel.Code);
                HostelFee.SETRANGE("Start Date", StartDate);
                HostelFee.SETRANGE("End Date", EndDate);
                HostelFee.SETRANGE(Update, TRUE);
                HostelFee.SETRANGE(Closed, FALSE);
                IF HostelFee.FINDFIRST THEN BEGIN
                    HostelFeeLine.RESET;
                    HostelFeeLine.SETRANGE("Bill No.", HostelFee."Bill No.");
                    IF HostelFeeLine.FINDSET THEN
                        REPEAT
                            IF HostelFeeLine."Days Present" <> 0 THEN
                                HostelFeeLine."Fee Amount" := PerStudentAmount * HostelFeeLine."Days Present";
                            HostelFeeLine.MODIFY;
                        UNTIL HostelFeeLine.NEXT = 0;
                END;
            UNTIL Hostel.NEXT = 0;
        // Stop 05.VIGNESH
    end;

    [Scope('Internal')]
    procedure "Calculate Consumption"(getLocation: Code[20]; getFromDate: Date; getToDate: Date; getCostCode: Code[20])
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ConsumptionAmount: Decimal;
        MessExpenseAmount: Record Table71686;
        "G/LEntry": Record "G/L Entry";
        CostCode: Record Table71687;
    begin
        // Start 06.VIGNESH
        // Start 12.Ankesh
        CLEAR(ConsumptionAmount);
        HostelSetup.GET;
        HostelSetup.TESTFIELD("Consumption Code");
        HostelSetup.TESTFIELD("Electricity Expense Code");

        IF (getFromDate = 0D) OR (getToDate = 0D) THEN
            ERROR(Text011);

        IF getCostCode = HostelSetup."Consumption Code" THEN BEGIN
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Location Code", "Posting Date");
            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::"Negative Adjmt.");
            ItemLedgerEntry.SETRANGE("Location Code", getLocation);
            ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', getFromDate, getToDate);
            IF ItemLedgerEntry.FINDSET THEN
                REPEAT
                    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    ConsumptionAmount += ABS(ItemLedgerEntry."Cost Amount (Actual)");
                UNTIL ItemLedgerEntry.NEXT = 0;
            IF ConsumptionAmount = 0 THEN
                MESSAGE(Text012)
            ELSE BEGIN
                MessExpenseAmount.RESET;
                MessExpenseAmount.GET(getLocation, getFromDate, getToDate, getCostCode);
                MessExpenseAmount."Total Amount" := ConsumptionAmount;
                MessExpenseAmount.MODIFY;
                MESSAGE(Text013);
            END;
        END ELSE
            IF getCostCode = HostelSetup."Electricity Expense Code" THEN BEGIN
                "G/LEntry".RESET;
                IF CostCode.GET(getCostCode) THEN;
                "G/LEntry".SETRANGE("G/L Account No.", CostCode."G/L Account No.");
                "G/LEntry".SETRANGE("Location Code", getLocation);
                "G/LEntry".SETFILTER("Posting Date", '%1..%2', getFromDate, getToDate);
                IF "G/LEntry".FINDSET THEN
                    REPEAT
                        ConsumptionAmount += "G/LEntry".Amount;
                    UNTIL "G/LEntry".NEXT = 0;

                IF ConsumptionAmount = 0 THEN
                    MESSAGE(Text014)
                ELSE BEGIN
                    MessExpenseAmount.RESET;
                    MessExpenseAmount.GET(getLocation, getFromDate, getToDate, getCostCode);
                    MessExpenseAmount."Total Amount" := ConsumptionAmount;
                    MessExpenseAmount.MODIFY;
                    MESSAGE(Text015);
                END;
            END;
        // Stop 12.Ankesh
        // Stop 06.VIGNESH
    end;

    [Scope('Internal')]
    procedure "AllotRoom No."("GetNo.": Code[20])
    begin
        // Start 07.VIGNESH
        RoomAllocation.GET("GetNo.");
        RoomAllocation.TESTFIELD("Student No.");
        RoomAllocation.TESTFIELD("Hostel No.");
        RoomAllocation.TESTFIELD("Room No");
        RoomAllocation.TESTFIELD(BedNo);
        IF RoomAllocation.RoomAlloted OR
           (RoomAllocation."Room Status" = RoomAllocation."Room Status"::Occupied)
        THEN
            ERROR(Text016, RoomAllocation."Student No.");

        IF NOT CONFIRM(Text022, FALSE) THEN
            EXIT;

        HostelSetup.GET;
        HostelSetup.TESTFIELD("Hostel Fee Code");
        HostelSetup.TESTFIELD("Room Rent Charging");

        HostelRoomsLine.RESET;
        HostelRoomsLine.SETRANGE("Hostel Code", RoomAllocation."Hostel No.");
        HostelRoomsLine.SETRANGE("Room No.", RoomAllocation."Room No");
        HostelRoomsLine.SETFILTER("Total Vacant", '<>%1', 0);
        IF HostelRoomsLine.FINDFIRST THEN BEGIN
            HostelRoomsLine.TESTFIELD("Per Student Rent");
            IF RoomAllocation.Company = RoomAllocation.Company::School THEN BEGIN
                IF Student.GET(RoomAllocation."Student No.") THEN BEGIN
                    IF NOT Student."Hostel Alloted" THEN BEGIN
                        Student."Room No." := RoomAllocation."Room No";
                        Student."Hostel Code" := RoomAllocation."Hostel No.";
                        Student."Room Type" := HostelRoomsLine."Room Type";
                        Student.Mess := RoomAllocation."Mess Location";
                        Student."Hostel Alloted" := TRUE;
                        Student."Hostel Vacated" := FALSE;
                        Student.MODIFY;
                    END ELSE
                        ERROR(Text016, RoomAllocation."Student No.");
                END ELSE
                    ERROR(Text000);
            END ELSE
                IF RoomAllocation.Company = RoomAllocation.Company::College THEN BEGIN
                    IF StudentCOLLEGE.GET(RoomAllocation."Student No.") THEN BEGIN
                        IF StudentCOLLEGE."Hostel Alloted" THEN BEGIN
                            StudentCOLLEGE."Room No." := RoomAllocation."Room No";
                            StudentCOLLEGE."Hostel Code" := RoomAllocation."Hostel No.";
                            StudentCOLLEGE."Room Type" := HostelRoomsLine."Room Type";
                            StudentCOLLEGE.Mess := RoomAllocation."Mess Location";
                            StudentCOLLEGE."Hostel Alloted" := TRUE;
                            StudentCOLLEGE."Hostel Vacated" := FALSE;
                            StudentCOLLEGE.MODIFY;
                        END ELSE
                            ERROR(Text016, RoomAllocation."Student No.");
                    END ELSE
                        ERROR(Text000);
                END;
            IF HostelRooms.GET(RoomAllocation."Hostel No.", RoomAllocation."Room No", RoomAllocation.BedNo) THEN BEGIN
                HostelRooms.Alloted := TRUE;
                HostelRooms.MODIFY;
            END;
            /*
           // Start 11.Ankesh
            IF HostelSetup."Room Rent Charging" <> HostelSetup."Room Rent Charging"::" " THEN BEGIN
              GenJournalLine.RESET;
              IF RoomAllocation.Company = RoomAllocation.Company::School THEN BEGIN
                IF HostelSetup."Room Rent Charging" = HostelSetup."Room Rent Charging"::"Based on Roon Type" THEN BEGIN
                  FeeManagement.FeeProcess(RoomAllocation."Student No.",HostelSetup."Hostel Fee Code",HostelRoomsLine."Per Student Rent");
                END ELSE
                  IF HostelSetup."Room Rent Charging" = HostelSetup."Room Rent Charging"::"Flat Rate" THEN BEGIN
                    HostelSetup.TESTFIELD("Room Rent");
                    FeeManagement.FeeProcess(RoomAllocation."Student No.",HostelSetup."Hostel Fee Code",HostelSetup."Room Rent");
                  END;

                FeeSetup.GET;
                FeeSetup.TESTFIELD("Journal Template Name");
                FeeSetup.TESTFIELD("Journal Batch Name");

                GenJournalLine.SETRANGE("Journal Template Name",FeeSetup."Journal Template Name");
                GenJournalLine.SETRANGE("Journal Batch Name",FeeSetup."Journal Batch Name");
              END ELSE
                IF RoomAllocation.Company = RoomAllocation.Company::College THEN BEGIN
                  IF HostelSetup."Room Rent Charging" = HostelSetup."Room Rent Charging"::"Based on Roon Type" THEN BEGIN
                    FeeManagementCOLLEGE.FeeProcess(RoomAllocation."Student No.",HostelSetup."Hostel Fee Code",
                      HostelRoomsLine."Per Student Rent");
                  END ELSE
                    IF HostelSetup."Room Rent Charging" = HostelSetup."Room Rent Charging"::"Flat Rate" THEN BEGIN
                      HostelSetup.TESTFIELD("Room Rent");
                      FeeManagementCOLLEGE.FeeProcess(RoomAllocation."Student No.",HostelSetup."Hostel Fee Code",
                        HostelSetup."Room Rent");
                    END;
                  FeeSetupCOLLEGE.GET;
                  FeeSetupCOLLEGE.TESTFIELD("Journal Template Name");
                  FeeSetupCOLLEGE.TESTFIELD("Journal Batch Name");
                  GenJournalLine.SETRANGE("Journal Template Name",FeeSetupCOLLEGE."Journal Template Name");
                  GenJournalLine.SETRANGE("Journal Batch Name",FeeSetupCOLLEGE."Journal Batch Name");
                END;
              IF GenJournalLine.FINDSET THEN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
            END;
            // Stop 11.Ankesh
             */
            HostelRoomsLine."Total Vacant" := HostelRoomsLine."Total Vacant" - 1;
            RoomAllocation.RoomAlloted := TRUE;
            RoomAllocation."Room Status" := RoomAllocation."Room Status"::Occupied;
            RoomAllocation."Allocation Date" := TODAY;
            RoomAllocation."Vacate Date" := 0D;
            RoomAllocation.Vacated := FALSE;
            RoomAllocation.MODIFY;
            HostelRoomsLine.MODIFY;
            MESSAGE(Text001, RoomAllocation."Student Name");
            // Stop 01.KATHIR
        END;
        // Stop 07.VIGNESH

    end;

    [Scope('Internal')]
    procedure VacateRoom("GetNo.": Code[20]): Boolean
    begin
        // Start 08.VIGNESH
        RoomAllocation.GET("GetNo.");
        RoomAllocation.TESTFIELD("Student No.");
        RoomAllocation.TESTFIELD("Hostel No.");
        RoomAllocation.TESTFIELD("Room No");
        IF (NOT RoomAllocation.RoomAlloted) OR RoomAllocation.Vacated OR
           (RoomAllocation."Room Status" = RoomAllocation."Room Status"::Vacated)
        THEN
            ERROR(Text017, RoomAllocation."Student No.");

        HostelRoomsLine.RESET;
        HostelRoomsLine.SETRANGE("Hostel Code", RoomAllocation."Hostel No.");
        HostelRoomsLine.SETRANGE("Room No.", RoomAllocation."Room No");
        IF HostelRoomsLine.FINDFIRST THEN BEGIN
            IF RoomAllocation.Company = RoomAllocation.Company::School THEN BEGIN
                IF Student.GET(RoomAllocation."Student No.") THEN BEGIN
                    IF Student."Hostel Alloted" THEN BEGIN
                        Student."Room No." := '';
                        Student."Hostel Code" := '';
                        Student."Room Type" := '';
                        Student.Mess := '';
                        Student."Hostel Alloted" := FALSE;
                        Student."Hostel Vacated" := TRUE;
                        Student.MODIFY;
                    END ELSE
                        ERROR(Text017, RoomAllocation."Student No.");
                END ELSE
                    ERROR(Text000);
            END ELSE
                IF RoomAllocation.Company = RoomAllocation.Company::College THEN BEGIN
                    IF StudentCOLLEGE.GET(RoomAllocation."Student No.") THEN BEGIN
                        IF StudentCOLLEGE."Hostel Alloted" THEN BEGIN
                            StudentCOLLEGE."Room No." := '';
                            StudentCOLLEGE."Hostel Code" := '';
                            StudentCOLLEGE."Room Type" := '';
                            StudentCOLLEGE.Mess := '';
                            StudentCOLLEGE."Hostel Alloted" := FALSE;
                            StudentCOLLEGE."Hostel Vacated" := TRUE;
                            StudentCOLLEGE.MODIFY;
                        END ELSE
                            ERROR(Text017, RoomAllocation."Student No.");
                    END ELSE
                        ERROR(Text000);
                END;

            IF HostelRooms.GET(RoomAllocation."Hostel No.", RoomAllocation."Room No", RoomAllocation.BedNo) THEN BEGIN
                HostelRooms.Alloted := FALSE;
                HostelRooms.MODIFY;
            END;

            HostelRoomsLine."Total Vacant" := HostelRoomsLine."Total Vacant" + 1;
            RoomAllocation."Room No" := '';
            RoomAllocation."Hostel No." := '';
            RoomAllocation."Hostel Name" := '';
            RoomAllocation."Mess Location" := '';
            RoomAllocation.BedNo := '';
            RoomAllocation.RoomAlloted := FALSE;
            RoomAllocation."Room Status" := RoomAllocation."Room Status"::Vacated;
            RoomAllocation."Allocation Date" := 0D;
            RoomAllocation."Vacate Date" := TODAY;
            RoomAllocation.Vacated := TRUE;
            RoomAllocation.MODIFY;
            HostelRoomsLine.MODIFY;
            EXIT(TRUE);
        END;
        // Stop 08.VIGNESH
    end;

    [Scope('Internal')]
    procedure ChangeRoom("GetNo.": Code[20])
    begin
        // Start 09.VIGNESH
        RoomChange.GET("GetNo.");
        RoomChange.TESTFIELD("Room Allocation No.");
        RoomChange.TESTFIELD("New Hostel Code");
        RoomChange.TESTFIELD("New Room No.");
        RoomChange.TESTFIELD("Academic Year");
        RoomChange.TESTFIELD("New Bed No.");
        IF RoomChange."Room Changed" THEN
            ERROR(Text018);
        IF NOT CONFIRM(Text024, FALSE) THEN
            EXIT;

        HostelSetup.GET;
        HostelSetup.TESTFIELD("Hostel Fee Code");

        IF VacateRoom(RoomChange."Room Allocation No.") THEN BEGIN
            IF RoomChange.Company = RoomChange.Company::School THEN BEGIN
                FeeManagement.FeeProcess(RoomChange."Student No.", HostelSetup."Hostel Fee Code", -HostelRoomsLine."Per Student Rent");
            END ELSE
                IF RoomChange.Company = RoomChange.Company::College THEN
                    FeeManagementCOLLEGE.FeeProcess(RoomChange."Student No.", HostelSetup."Hostel Fee Code", -HostelRoomsLine."Per Student Rent")
                    ;

            HostelRoomsLine.RESET;
            HostelRoomsLine.SETRANGE("Hostel Code", RoomChange."New Hostel Code");
            HostelRoomsLine.SETRANGE("Room No.", RoomChange."New Room No.");
            HostelRoomsLine.SETFILTER("Total Vacant", '<>%1', 0);
            IF HostelRoomsLine.FINDFIRST THEN BEGIN
                HostelRoomsLine.TESTFIELD("Per Student Rent");
                IF RoomChange.Company = RoomChange.Company::School THEN BEGIN
                    IF Student.GET(RoomChange."Student No.") THEN BEGIN
                        IF Student."Hostel Alloted" THEN BEGIN
                            Student."Room No." := RoomChange."New Room No.";
                            Student."Hostel Code" := RoomChange."New Hostel Code";
                            Student."Room Type" := HostelRoomsLine."Room Type";
                            Student.Mess := RoomChange."New Mess Location";
                            Student."Hostel Alloted" := TRUE;
                            Student."Hostel Vacated" := FALSE;
                            Student.MODIFY;
                        END ELSE
                            ERROR(Text016, RoomChange."Student No.");
                    END ELSE
                        ERROR(Text000);
                END ELSE
                    IF RoomChange.Company = RoomChange.Company::College THEN BEGIN
                        IF StudentCOLLEGE.GET(RoomChange."Student No.") THEN BEGIN
                            IF NOT StudentCOLLEGE."Hostel Alloted" THEN BEGIN
                                StudentCOLLEGE."Room No." := RoomChange."New Room No.";
                                StudentCOLLEGE."Hostel Code" := RoomChange."New Hostel Code";
                                StudentCOLLEGE."Room Type" := HostelRoomsLine."Room Type";
                                StudentCOLLEGE.Mess := RoomChange."New Mess Location";
                                StudentCOLLEGE."Hostel Alloted" := TRUE;
                                StudentCOLLEGE."Hostel Vacated" := FALSE;
                                StudentCOLLEGE.MODIFY;
                            END ELSE
                                ERROR(Text016, RoomChange."Student No.");
                        END ELSE
                            ERROR(Text000);
                    END;

                IF RoomChange.Company = RoomChange.Company::School THEN
                    FeeManagement.FeeProcess(RoomChange."Student No.", HostelSetup."Hostel Fee Code", HostelRoomsLine."Per Student Rent")
                ELSE
                    IF RoomChange.Company = RoomChange.Company::College THEN
                        FeeManagementCOLLEGE.FeeProcess(RoomChange."Student No.", HostelSetup."Hostel Fee Code", HostelRoomsLine."Per Student Rent")
                        ;

                GenJournalLine.RESET;
                IF RoomChange.Company = RoomChange.Company::School THEN BEGIN
                    FeeSetup.GET;
                    FeeSetup.TESTFIELD("Journal Template Name");
                    FeeSetup.TESTFIELD("Journal Batch Name");
                    GenJournalLine.SETRANGE("Journal Template Name", FeeSetup."Journal Template Name");
                    GenJournalLine.SETRANGE("Journal Batch Name", FeeSetup."Journal Batch Name");
                END ELSE
                    IF RoomChange.Company = RoomChange.Company::College THEN BEGIN
                        FeeSetupCOLLEGE.GET;
                        FeeSetupCOLLEGE.TESTFIELD("Journal Template Name");
                        FeeSetupCOLLEGE.TESTFIELD("Journal Batch Name");
                        GenJournalLine.SETRANGE("Journal Template Name", FeeSetupCOLLEGE."Journal Template Name");
                        GenJournalLine.SETRANGE("Journal Batch Name", FeeSetupCOLLEGE."Journal Batch Name");
                    END;

                IF GenJournalLine.FINDSET THEN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);

                HostelRoomsLine."Total Vacant" := HostelRoomsLine."Total Vacant" - 1;
                RoomAllocation.GET(RoomChange."Room Allocation No.");
                RoomAllocation."Room No" := RoomChange."New Room No.";
                RoomAllocation."Hostel No." := RoomChange."New Hostel Code";
                RoomAllocation."Hostel Name" := RoomChange."New Hostel Name";
                RoomAllocation.BedNo := RoomChange."New Bed No.";
                RoomAllocation."Mess Location" := RoomChange."New Mess Location";
                RoomAllocation.RoomAlloted := TRUE;
                RoomAllocation."Room Status" := RoomAllocation."Room Status"::Occupied;
                RoomAllocation."Allocation Date" := TODAY;
                RoomAllocation."Vacate Date" := 0D;
                RoomAllocation.Vacated := FALSE;
                RoomChange."Room Change Date" := TODAY;
                RoomChange."Room Changed" := TRUE;
                RoomChange.MODIFY;
                RoomAllocation.MODIFY;
                HostelRoomsLine.MODIFY;
                MESSAGE(Text019, RoomChange."Student Name");
            END;
        END;
        // Start 09.VIGNESH
    end;

    [Scope('Internal')]
    procedure ChangeMess()
    begin
        // Start 10.VIGNESH
        IF NOT CONFIRM(Text023, FALSE) THEN
            EXIT;
        MessChange.RESET;
        MessChange.SETRANGE(Approval, TRUE);
        IF MessChange.FINDFIRST THEN
            REPEAT
                IF MessChange."Required Mess" <> '' THEN BEGIN
                    StudentCOLLEGE.GET(MessChange."Student No.");
                    StudentCOLLEGE.Mess := MessChange."Required Mess";
                    StudentCOLLEGE.MODIFY;
                END;
            UNTIL MessChange.NEXT = 0;
        MESSAGE(Text020);
        // Stop 10.VIGNESH
    end;
}

