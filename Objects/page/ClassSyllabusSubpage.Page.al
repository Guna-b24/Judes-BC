page 71176 "Class Syllabus Subpage"
{
    PageType = ListPart;
    SourceTable = "Class Syllabus Line";
    Caption = 'Syllabus Lines';
    ApplicationArea = All;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }

                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                }

                field("Chapter Code"; Rec."Chapter Code")
                {
                    ApplicationArea = All;
                }

                field("Chapter Name"; Rec."Chapter Name")
                {
                    ApplicationArea = All;
                }

                field("No of Hours"; Rec."No of Hours")
                {
                    ApplicationArea = All;
                }

                field("Teaching Aids"; Rec."Teaching Aids")
                {
                    ApplicationArea = All;
                }

                field(Aim; Rec.Aim)
                {
                    ApplicationArea = All;
                }

                field(Explaination; Rec.Explaination)
                {
                    ApplicationArea = All;
                }

                field(Assignment; Rec.Assignment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}