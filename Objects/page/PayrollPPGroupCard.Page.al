page 72184 "Payroll PP Group Card"
{
    PageType = Card;
    SourceTable = "Payroll Product Posting Group";
    ApplicationArea = All;
    Caption = 'Payroll Product Posting Group';
    UsageCategory = Administration;
    Editable = true;

    layout
    {
        area(content)
        {
            group("General")
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
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
                Image = GetEntries;
                ToolTip = 'Retrieve pay elements based on the selected location and salary plan and insert them into the payroll group.';

                trigger OnAction()
                var
                    PayrollMgmt: Codeunit "Payroll Data Creation";
                begin
                    PayrollMgmt.PayRollPPGroup(Rec."Location Code", Rec."Salary Plan Code");
                    CurrPage.Update(false);
                end;
            }
        }
    }

}