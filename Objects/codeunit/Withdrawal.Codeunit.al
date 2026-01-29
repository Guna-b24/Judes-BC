codeunit 71043 Withdrawal
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01   11/10/09  KATHIR   Issue TC()                 Function added to Issue TC
    //   02   21/10/09  KATHIR   Issue TC Modify()          Function added to modify the student after TC been issued
    //   03   17/11/09  VIGNESH  Issue TC Modify()          Code modified to validate the date fields


    trigger OnRun()
    begin
    end;

    var
        TransferCertificate: Record "Transfer Certificate";
        Withdrawl: Record Withdrawal;
        Student: Record Student;
        Text000: Label 'T.C issued';

    [Scope('Internal')]
    procedure "Issue TC"("TCNo.": Code[20]; WithdrawlNo: Code[20]; "StudentNo.": Code[20])
    var
        Customer: Record Customer;
        TEXT001: Label 'Student balance amount is Pending..... Still Want to Continue?';
    begin
        // Start 01.KATHIR
        Withdrawl.Get(WithdrawlNo);
        Customer.Get("StudentNo.");
        Customer.CalcFields("Balance (LCY)");
        if Customer."Balance (LCY)" > 0 then begin
            if Confirm(TEXT001) then
                "Issue TC Modify"("TCNo.", WithdrawlNo, "StudentNo.");
        end else
            "Issue TC Modify"("TCNo.", WithdrawlNo, "StudentNo.");
        // Stop 01.KATHIR
    end;

    [Scope('Internal')]
    procedure "Issue TC Modify"("TCNo.": Code[20]; WithdrawlNo: Code[20]; "StudNo.": Code[20])
    begin
        // Start 02.KATHIR
        Withdrawl.Get(WithdrawlNo);
        TransferCertificate.Get("TCNo.");
        Student.Get("StudNo.");

        TransferCertificate."TC Issued" := true;
        // Start 03.VIGNESH
        if TransferCertificate."Date of Issue" = 0D then
            TransferCertificate."Date of Issue" := Today;
        // Stop 03.VIGNESH
        TransferCertificate.Modify;

        Withdrawl."TC Issued" := true;
        // Start 03.VIGNESH
        if Withdrawl."Withdrawal date" = 0D then
            Withdrawl."Withdrawal date" := Today;
        // Stop 03.VIGNESH
        Withdrawl.Modify;

        Student."Student Status" := Student."Student Status"::Alumni;
        // Start 03.VIGNESH
        if Student."Date of Leaving" = 0D then
            Student."Date of Leaving" := Today;
        // Stop 03.VIGNESH
        Student.Modify;
        Message(Text000);
        // Stop 02.KATHIR
    end;
}

