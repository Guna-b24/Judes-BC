page 71897 "User Groups List"
{
    PageType = List;
    SourceTable = "User Groups";
    Caption = 'User Groups';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Group"; Rec."User Group")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(SID; Rec.SID)
                {
                }
                field("Windows Login"; Rec."Windows Login")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }
}