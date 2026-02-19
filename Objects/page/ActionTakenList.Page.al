page 71919 "Action Taken List"
{
    PageType = List;
    SourceTable = "Action Taken";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Action Taken Card";
    Caption = 'Action Taken';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
