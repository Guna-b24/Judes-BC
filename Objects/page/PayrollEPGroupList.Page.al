page 72179 "Payroll EP Group List"
{
    PageType = List;
    SourceTable = "Payroll Employee Posting Group";
    ApplicationArea = All;
    Caption = 'Payroll Employee Posting Group';
    UsageCategory = Administration;
    CardPageID = "Payroll EP Group Card";

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