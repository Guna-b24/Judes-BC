page 70048 "Certificate_List"
{
    PageType = List;
    SourceTable = Certificate;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Certificates';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
