page 71042 "Curriculum List"
{
    PageType = List;
    SourceTable = Curriculum;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Curriculum';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
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