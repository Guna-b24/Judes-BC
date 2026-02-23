page 71088 "Co-Curricular Points"
{
    PageType = List;
    SourceTable = "Co-Curricular Academic Points";
    Caption = 'Co-Curricular Academic Points';
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }

                field(Points; Rec.Points)
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
}