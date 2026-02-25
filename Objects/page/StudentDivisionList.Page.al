page 71132 "Student Division List"
{
    PageType = List;
    SourceTable = "Student Division";
    ApplicationArea = All;
    Caption = 'Student Division List';
    UsageCategory = Lists;
    CardPageId = "Student Division Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
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