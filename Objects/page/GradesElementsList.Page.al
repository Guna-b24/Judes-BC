page 72164 "Grades Elements List"
{
    PageType = List;
    SourceTable = "Grades Elements";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Grades Elements';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Grade Code"; Rec."Grade Code") { ApplicationArea = All; }
                field("Effective Date"; Rec."Effective Date") { ApplicationArea = All; }
                field("Pay Element Code"; Rec."Pay Element Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Pay Type"; Rec."Pay Type") { ApplicationArea = All; }
                field("Fixed / Percent"; Rec."Fixed / Percent") { ApplicationArea = All; }
                field("Amount Calculation Type"; Rec."Amount Calculation Type") { ApplicationArea = All; }
                field("Base Pay Elements"; Rec."Base Pay Elements") { ApplicationArea = All; }
                field("Percent (%)"; Rec."Percent (%)") { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field("Sorting Order"; Rec."Sorting Order") { ApplicationArea = All; }
            }
        }
    }
}
