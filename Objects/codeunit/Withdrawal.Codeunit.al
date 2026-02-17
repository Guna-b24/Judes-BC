codeunit 71043 Withdrawal
{
    trigger OnRun()
    begin
    end;

    var
        TransferCertificate: Record "Transfer Certificate";
        Withdrawl: Record Withdrawal;
        Student: Record Student;
        Text000: Label 'T.C issued';


    procedure "Issue TC"("TCNo.": Code[20]; WithdrawlNo: Code[20]; "StudentNo.": Code[20])
    var
        Customer: Record Customer;
        TEXT001: Label 'Student balance amount is Pending..... Still Want to Continue?';
    begin
        Withdrawl.Get(WithdrawlNo);
        Customer.Get("StudentNo.");
        Customer.CalcFields("Balance (LCY)");
        if Customer."Balance (LCY)" > 0 then begin
            if Confirm(TEXT001) then
                "Issue TC Modify"("TCNo.", WithdrawlNo, "StudentNo.");
        end else
            "Issue TC Modify"("TCNo.", WithdrawlNo, "StudentNo.");

    end;


    procedure "Issue TC Modify"("TCNo.": Code[20]; WithdrawlNo: Code[20]; "StudNo.": Code[20])
    begin

        Withdrawl.Get(WithdrawlNo);
        TransferCertificate.Get("TCNo.");
        Student.Get("StudNo.");

        TransferCertificate."TC Issued" := true;

        if TransferCertificate."Date of Issue" = 0D then
            TransferCertificate."Date of Issue" := Today;

        TransferCertificate.Modify();

        Withdrawl."TC Issued" := true;

        if Withdrawl."Withdrawal date" = 0D then
            Withdrawl."Withdrawal date" := Today;

        Withdrawl.Modify();

        Student."Student Status" := Student."Student Status"::Alumni;

        if Student."Date of Leaving" = 0D then
            Student."Date of Leaving" := Today;

        Student.Modify();
        Message(Text000);

    end;
}

