page 71087 "Co-Curricular Points Setup"
{
    PageType = List;
    SourceTable = "Co-Curricular Points Setup";
    Caption = 'Co-Curricular Points Setup';
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Competition type"; Rec."Competition type")
                {
                    ApplicationArea = All;
                }

                field("1st Place"; Rec."1st Place") { ApplicationArea = All; }
                field("2nd Place"; Rec."2nd Place") { ApplicationArea = All; }
                field("3rd Place"; Rec."3rd Place") { ApplicationArea = All; }
                field("4th Place"; Rec."4th Place") { ApplicationArea = All; }
                field("5th Place"; Rec."5th Place") { ApplicationArea = All; }
                field("6th Place"; Rec."6th Place") { ApplicationArea = All; }
                field(Participation; Rec.Participation) { ApplicationArea = All; }

                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}