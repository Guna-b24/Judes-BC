page 71901 "Unit Master List"
{
    PageType = List;
    SourceTable = "Unit Master";
    Caption = 'Unit Master List';
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageID = "Unit Master Card";

    layout
    {
        area(content)
        {
            repeater(Group)
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