page 71262 "Transfer Certificate Card"
{
    PageType = Card;
    SourceTable = "Transfer Certificate";
    Caption = 'Transfer Certificate';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("TC No."; Rec."TC No.")
                {
                }
                field("Student No."; Rec."Student No.")
                {
                }
                field(Class; Rec.Class)
                {
                }
                field(Section; Rec.Section)
                {
                }
                field(Curriculum; Rec.Curriculum)
                {
                }
                field("Academic Year"; Rec."Academic Year")
                {
                }
                field("Withdrawl date"; Rec."Withdrawl date")
                {
                }
                field("TC Issued"; Rec."TC Issued")
                {
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                }
                field(Age; Rec.Age)
                {
                }
                field("Date of Issue"; Rec."Date of Issue")
                {
                }
                field(Conduct; Rec.Conduct)
                {
                }
                field("Withdrawl No."; Rec."Withdrawl No.")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Reason for Leaving"; Rec."Reason for Leaving")
                {
                }
                field(Months; Rec.Months)
                {
                }
                field("Class Code"; Rec."Class Code")
                {
                }
                field("Portal ID"; Rec."Portal ID")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action(IssueTC)
            {
                Caption = 'Issue TC';
                ApplicationArea = All;
                Image = SendTo;
                ToolTip = 'Issues a Transfer Certificate for the selected student.';

                trigger OnAction()
                var
                    withdrawl: Codeunit Withdrawal;
                begin
                    Withdrawl."Issue TC"(Rec."TC No.", Rec."Withdrawl No.", Rec."Student No.");
                    CurrPage.Update();
                end;
            }
            action(TCReport)
            {
                Caption = 'TC Report';
                ApplicationArea = All;
                Image = Print;
                ToolTip = 'Prints the Transfer Certificate report for the selected record.';

                trigger OnAction()
                var
                    TransferCertificate: Record "Transfer Certificate";
                begin
                    TransferCertificate.Reset();
                    TransferCertificate.SetRange("TC No.", Rec."TC No.");
                    TransferCertificate.SetRange("Student No.", Rec."Student No.");

                    //if TransferCertificate.FindFirst() then
                    //Report.RunModal(Report::"Transfer Certificate Report", true, false, TransferCertificate);
                end;
            }
            action(PrePrintedTCReport)
            {
                Caption = 'Pre-Printed TC Report';
                ApplicationArea = All;
                Image = Print;
                ToolTip = 'Prints the pre-printed Transfer Certificate for the selected record.';

                trigger OnAction()
                var
                    TransferCertificate: Record "Transfer Certificate";
                begin
                    TransferCertificate.Reset();
                    TransferCertificate.SetRange("TC No.", Rec."TC No.");
                    TransferCertificate.SetRange("Student No.", Rec."Student No.");

                    // if TransferCertificate.FindFirst() then
                    //     Report.RunModal(Report::"Pre-Printed TC Report", true, false, TransferCertificate);
                end;
            }
        }
    }


}
