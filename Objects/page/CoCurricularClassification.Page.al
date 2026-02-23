page 71903 "Co-Curricular Classification"
{
    PageType = List;
    SourceTable = "Co-Curricular Classification";
    Caption = 'Co-Curricular Classification';
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Co-Curricular Code"; Rec."Co-Curricular Code")
                {
                    ApplicationArea = All;
                }

                field("Classification Code"; Rec."Classification Code")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}