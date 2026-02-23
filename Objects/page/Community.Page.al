page 71891 "Community"
{
    PageType = List;
    SourceTable = Community;
    Caption = 'Community';
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;

    SourceTableView = sorting("Code");

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

                field("Academic Year"; Rec."Academic Year")
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