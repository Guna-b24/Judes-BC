page 72130 "Revision Card"
{
    PageType = Document;
    SourceTable = "Revision Header";
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Pay Revision';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Pay Revision Id"; Rec."Pay Revision Id")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;

                }

                field("Pay Revision Processing Date"; Rec."Pay Revision Processing Date")
                {
                    ApplicationArea = All;
                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }

                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }

                field("New Effective Date"; Rec."New Effective Date")
                {
                    ApplicationArea = All;
                }

                field("Based on"; Rec."Based on")
                {
                    ApplicationArea = All;
                }

                field("Revision Amount"; Rec."Revision Amount")
                {
                    ApplicationArea = All;
                }

                field("Revision Percent"; Rec."Revision Percent")
                {
                    ApplicationArea = All;
                }

                field("VDA Increase Amount"; Rec."VDA Increase Amount")
                {
                    ApplicationArea = All;
                }

                field("VDA Eligible Max Amount"; Rec."VDA Eligible Max Amount")
                {
                    ApplicationArea = All;
                }
            }
            group(Arrears)
            {
                field("Arrears Starting Date"; Rec."Arrears Starting Date")
                {
                    ApplicationArea = All;
                }

                field("Arrears Ending Date"; Rec."Arrears Ending Date")
                {
                    ApplicationArea = All;
                }

                field("Arrears Generated"; Rec."Arrears Generated")
                {
                    ApplicationArea = All;
                }
            }

            part(Lines; "Revision Subform")
            {
                SubPageLink = "Pay Revision Id" = FIELD("Pay Revision Id");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Pay Elements")
            {
                ApplicationArea = All;
                Caption = 'Get Pay Elements';
                Image = Calculate;
                ToolTip = 'Retrieves and processes the pay elements for the selected pay revision based on the new effective date.';

                trigger OnAction()
                var
                    CUPayRevision: Codeunit "Pay Revision";
                begin
                    if Rec."New Effective Date" = 0D then
                        Error('New Effective Date Cannot be Blank..!!');

                    if not Confirm('Do you want to get pay elements?', false) then
                        exit;

                    CUPayRevision."Process Monthly Salary"(
                        Rec."Pay Revision Id",
                        Today,
                        '',
                        Rec."New Effective Date");
                end;
            }
            action(Update)
            {
                ApplicationArea = All;
                Caption = 'Update';
                Image = UpdateDescription;
                ToolTip = 'Updates all revision lines based on the revision header details.';

                trigger OnAction()
                var
                    PayRevisionMgt: Codeunit "Pay Revision";
                begin
                    PayRevisionMgt.UpdateRevisionLines(Rec);

                    CurrPage.Update();
                    Message('Records Updated..!!');
                end;
            }
            action(UpdateArrears)
            {
                ApplicationArea = All;
                Caption = 'Process Arrears';
                Image = UpdateDescription;
                ToolTip = 'Generate arrears for employees based on the pay revision header.';

                trigger OnAction()
                var
                    ArrearsMgt: Codeunit "Pay Revision";
                begin
                    ArrearsMgt.ProcessArrears(Rec);
                    CurrPage.Update();
                end;
            }
            action(PostRevision)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = Approve;
                ToolTip = 'Post the pay revision and transfer to Employee Pay Elements.';

                trigger OnAction()
                var
                    PostingMgt: Codeunit "Pay Revision";
                begin
                    PostingMgt.PostRevision(Rec);
                    CurrPage.Update();
                end;
            }
        }
    }
}