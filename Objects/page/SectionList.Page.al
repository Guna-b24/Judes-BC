page 71917 "Section List"
{
    PageType = List;
    SourceTable = Section;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Section Card";
    Caption = 'Sections';

    layout
    {
        area(content)
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
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}