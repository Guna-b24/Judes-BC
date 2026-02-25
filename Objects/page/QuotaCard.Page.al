page 71887 "Quota Card"
{
    PageType = Card;
    SourceTable = Quota;
    ApplicationArea = All;
    Caption = 'Quota';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field(Reserve; Rec.Reserve) { ApplicationArea = All; }
            }
        }
    }
}