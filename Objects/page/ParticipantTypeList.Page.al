page 71126 "Participant Type List"
{
    PageType = List;
    SourceTable = "Participant Type";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Participant Type List';
    CardPageId = "Participant Type Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    Caption = 'Portal ID';
                }
            }
        }
    }
}