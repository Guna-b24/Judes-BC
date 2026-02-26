page 72009 "Training List"
{
    PageType = List;
    SourceTable = Training;
    Caption = 'Training List';
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageID = "Training Card";

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
            }
        }
    }
}