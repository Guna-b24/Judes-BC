page 72122 "Salary Posting1 Worksheet"
{
    PageType = Worksheet;
    SourceTable = "Salary Posting-1";
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Salary Posting';

    layout
    {
        area(content)
        {
            group(Filter)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Salary Cycle Code"; Rec."Salary Cycle Code") { ApplicationArea = All; }
                field("Employee Category"; Rec."Employee Category") { ApplicationArea = All; }
                field(Year; Rec.Year) { ApplicationArea = All; }
                field(Month; Rec.Month) { ApplicationArea = All; }
            }

            repeater(Lines)
            {
                field("Pay Element Code"; Rec."Pay Element Code") { ApplicationArea = All; }
                field("Pay Type"; Rec."Pay Type") { ApplicationArea = All; }
                field("Actual Amount"; Rec."Actual Amount") { ApplicationArea = All; }
                field("Payable Amount"; Rec."Payable Amount") { ApplicationArea = All; }
                field("Account Type"; Rec."Account Type") { ApplicationArea = All; }
                field("Account No."; Rec."Account No.") { ApplicationArea = All; }
                field(Posted; Rec.Posted) { ApplicationArea = All; Editable = false; }
            }
        }
    }


}