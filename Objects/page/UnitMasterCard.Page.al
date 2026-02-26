page 71910 "Unit Master Card"
{
    PageType = Card;
    SourceTable = "Unit Master";
    Caption = 'Unit Master';
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
                }
                field(Description; Rec.Description)
                {
                }
                field("Academic Year"; Rec."Academic Year")
                {
                }
            }
        }
    }
}