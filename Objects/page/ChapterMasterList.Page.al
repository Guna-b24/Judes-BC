page 70051 "Chapter Master List"
{
    Caption = 'Chapter Master List';
    PageType = List;
    SourceTable = "Chapter Master";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Chapter Master Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for the chapter.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description or name of the chapter.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic year to which the chapter belongs.';
                }
            }
        }
    }
}