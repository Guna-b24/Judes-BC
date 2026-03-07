page 72290 "Misc Add/Deduction List"
{
    PageType = List;
    SourceTable = "Misc Add/Deductions";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
    Caption = 'Misc Add/Deductions';
    CardPageId = "Misc Add/Deductions Worksheet";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Salary Cycle Code"; Rec."Salary Cycle Code") { }
                field(Year; Rec.Year) { }
                field(Month; Rec.Month) { }
                field("Employee No"; Rec."Employee No") { }
                field(Name; Rec.Name) { }
                field("Pay Element Code"; Rec."Pay Element Code") { }
                field("Pay Type"; Rec."Pay Type") { }
                field(Amount; Rec.Amount) { }
                field("Employee Category"; Rec."Employee Category") { }
                field("Created Date"; Rec."Created Date") { }
            }
        }
    }
}