page 72062 "Grades Card"
{
    PageType = Card;
    SourceTable = Grades;
    ApplicationArea = All;
    Caption = 'Grade';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Grade Code"; Rec."Grade Code") { ApplicationArea = All; }
                field("Grade Name"; Rec."Grade Name") { ApplicationArea = All; }
                field("Scale of Pay"; Rec."Scale of Pay") { ApplicationArea = All; }
                field(Probationary; Rec.Probationary) { ApplicationArea = All; }
            }

            group("Statutory Applicability")
            {
                field("PF Applicable"; Rec."PF Applicable") { ApplicationArea = All; }
                field("EPS Applicable"; Rec."EPS Applicable") { ApplicationArea = All; }
                field("VPF Applicable"; Rec."VPF Applicable") { ApplicationArea = All; }
                field("ESI Applicable"; Rec."ESI Applicable") { ApplicationArea = All; }
                field("PT Applicable"; Rec."PT Applicable") { ApplicationArea = All; }
                field("LWF Applicable"; Rec."LWF Applicable") { ApplicationArea = All; }
                field("Bonus Applicable"; Rec."Bonus Applicable") { ApplicationArea = All; }
                field("Gratuity Applicable"; Rec."Gratuity Applicable") { ApplicationArea = All; }
                field("Leave Encashment Applicable"; Rec."Leave Encashment Applicable") { ApplicationArea = All; }
                field("OT Applicable"; Rec."OT Applicable") { ApplicationArea = All; }
            }

            group("Additional Settings")
            {
                field("PT Branch Code"; Rec."PT Branch Code") { ApplicationArea = All; }
                field("Over Time Multiplier"; Rec."Over Time Multiplier") { ApplicationArea = All; }
                field("Employee VPF ( Employee) %"; Rec."Employee VPF ( Employee) %") { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Card)
            {
                Caption = '&Card';
                ToolTip = ' ToolTip = Opens the selected grade record in the Grades Card page';
                Image = EditLines;
                ShortCutKey = 'Shift+F5';
                ApplicationArea = All;

                RunObject = page "Pay Elements Card";
                RunPageLink = "Salary Plan Code" = field("Salary Plan Code");
            }
        }
    }
}
