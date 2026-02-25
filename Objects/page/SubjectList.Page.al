page 71005 "Subject List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Subject';
    SourceTable = Subject;
    CardPageID = "Subject Card";
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
                field(Type; Rec.Type)
                {
                }
                field("Subject Group"; Rec."Subject Group")
                {
                }
                field(Compulsory; Rec.Compulsory)
                {
                }
                field("Period Length"; Rec."Period Length")
                {
                }
            }
        }
    }
}