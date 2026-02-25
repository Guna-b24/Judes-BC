page 71152 "Subject Group List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Subject Group';
    SourceTable = "Subject Group";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}