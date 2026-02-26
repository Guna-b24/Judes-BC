page 71183 "Competition Entry Line List"
{
    PageType = List;
    SourceTable = "Competition Entry Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Competition Entry Lines';
    Editable = true;
    CardPageId = "Competition Entry Subform";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Student Division"; Rec."Student Division")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Min Age"; Rec."Min Age")
                {
                    ApplicationArea = All;
                }
                field("Max Age"; Rec."Max Age")
                {
                    ApplicationArea = All;
                }
                field("Cut Off Date"; Rec."Cut Off Date")
                {
                    ApplicationArea = All;
                }
                field("Temp Cut off Date"; Rec."Temp Cut off Date")
                {
                    ApplicationArea = All;
                }
                field("Team Size"; Rec."Team Size")
                {
                    ApplicationArea = All;
                }
                field(Substitute; Rec.Substitute)
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}