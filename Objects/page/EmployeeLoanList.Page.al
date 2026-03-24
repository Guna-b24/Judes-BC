page 72119 "Employee Loan List"
{
    Caption = 'Employee Loans';
    PageType = List;
    SourceTable = "Employee Loan";
    ApplicationArea = All;
    UsageCategory = Documents;
    CardPageId = "Employee Loan Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Loan Id"; Rec."Loan Id")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;

                }

                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }

                field("Loan Code"; Rec."Loan Code")
                {
                    ApplicationArea = All;
                }

                field("Total Loan Amount"; Rec."Total Loan Amount")
                {
                    ApplicationArea = All;
                }

                field("Loan Balance Amount"; Rec."Loan Balance Amount")
                {
                    ApplicationArea = All;
                }

                field(Completed; Rec.Completed)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}