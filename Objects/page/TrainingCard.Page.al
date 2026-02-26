page 72008 "Training Card"
{
    PageType = Card;
    SourceTable = Training;
    Caption = 'Training';
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
            }
        }
    }


}