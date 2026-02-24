page 72061 "Grades List"
{
    PageType = List;
    SourceTable = Grades;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Grades';
    CardPageId = "Grades Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Grade Code"; Rec."Grade Code") { ApplicationArea = All; }
                field("Grade Name"; Rec."Grade Name") { ApplicationArea = All; }
                field(Probationary; Rec.Probationary) { ApplicationArea = All; }
                field("Scale of Pay"; Rec."Scale of Pay") { ApplicationArea = All; }
                field("PF Applicable"; Rec."PF Applicable") { ApplicationArea = All; }
                field("ESI Applicable"; Rec."ESI Applicable") { ApplicationArea = All; }
                field("PT Applicable"; Rec."PT Applicable") { ApplicationArea = All; }
                field("Bonus Applicable"; Rec."Bonus Applicable") { ApplicationArea = All; }
                field("Gratuity Applicable"; Rec."Gratuity Applicable") { ApplicationArea = All; }
            }
        }
    }
}
