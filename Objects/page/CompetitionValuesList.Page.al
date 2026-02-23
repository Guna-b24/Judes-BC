page 50035 "Competition Values List"
{
    PageType = List;
    SourceTable = "Competition Values";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Competition Values';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }

                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }

                field("Student Division"; Rec."Student Division")
                {
                    ApplicationArea = All;
                }

                field(Points; Rec.Points)
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}