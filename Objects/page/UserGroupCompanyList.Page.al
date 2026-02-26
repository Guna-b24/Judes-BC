page 71896 "User Group Company List"
{
    PageType = List;
    SourceTable = "User Group Company";
    Caption = 'User Group Company';
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
                field("Company Access"; Rec."Company Access")
                {
                }
            }
        }
    }
}