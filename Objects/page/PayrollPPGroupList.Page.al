page 72185 "Payroll PP Group List"
{
    PageType = List;
    SourceTable = "Payroll Product Posting Group";
    ApplicationArea = All;
    Caption = 'Payroll Product Posting Group';
    UsageCategory = Administration;
    CardPageID = "Payroll PP Group Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
            }
        }
    }
}