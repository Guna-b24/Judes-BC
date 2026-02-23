page 72078 "Employee Pay Elements Card"
{
    PageType = Card;
    SourceTable = "Employee Pay Elements";
    ApplicationArea = All;
    Caption = 'Employee Pay Elements Card';
    Editable = true;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Employee No"; Rec."Employee No") { }
                field("Effective Date"; Rec."Effective Date") { }
                field("Pay Element Code"; Rec."Pay Element Code") { }
                field(Description; Rec.Description) { }
                field("Pay Type"; Rec."Pay Type") { }
                field("Fixed/Percent"; Rec."Fixed/Percent") { }
                field("Amount Calculation Type"; Rec."Amount Calculation Type") { }
                field("Base Pay Elements"; Rec."Base Pay Elements") { }
                field("Percent (%)"; Rec."Percent (%)") { }
                field(Amount; Rec.Amount) { }
                field("Sorting Order"; Rec."Sorting Order") { }
                field("Excluded In Pay Slip"; Rec."Excluded In Pay Slip") { }
                field("Designation Code"; Rec."Designation Code") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}