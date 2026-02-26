page 70050 "Chapter Master Card"
{
    Caption = 'Chapter Master Card';
    PageType = Card;
    SourceTable = "Chapter Master";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
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