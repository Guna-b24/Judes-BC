page 72081 "Payroll GP Setup List"
{
    PageType = List;
    SourceTable = "Payroll General Posting Setup";
    ApplicationArea = All;
    Caption = 'Payroll General Posting Setup';
    UsageCategory = Administration;
    CardPageID = "Payroll GP Setup Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Pay Bus.Posting Group"; Rec."Pay Bus.Posting Group") { ApplicationArea = All; }
                field("Pay Prod. Posting Group"; Rec."Pay Prod. Posting Group") { ApplicationArea = All; }
                field("G/L Code"; Rec."G/L Code") { ApplicationArea = All; }
            }
        }
    }
}