page 72087 "Payroll Year List"
{
    PageType = List;
    SourceTable = "Payroll Year";
    ApplicationArea = All;
    Caption = 'Payroll Year';
    UsageCategory = Administration;
    CardPageID = "Payroll Year Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Year Code"; Rec."Year Code") { ApplicationArea = All; }
                field("Year Type"; Rec."Year Type") { ApplicationArea = All; }
                field("Year Start Date"; Rec."Year Start Date") { ApplicationArea = All; }
                field("Year End Date"; Rec."Year End Date") { ApplicationArea = All; }
                field(Closed; Rec.Closed) { ApplicationArea = All; }
            }
        }
    }
}