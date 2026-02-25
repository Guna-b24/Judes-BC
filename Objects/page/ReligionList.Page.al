page 71888 "Religion List"
{
    PageType = List;
    SourceTable = Religion;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Religion';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
            }
        }
    }
}