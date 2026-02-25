page 71131 "Student Division Card"
{
    PageType = Card;
    SourceTable = "Student Division";
    ApplicationArea = All;
    Caption = 'Student Division Card';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field(IsAcademicDivision; Rec.IsAcademicDivision)
                {
                    ApplicationArea = All;
                }

                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }

                field(Section; Rec.Section)
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