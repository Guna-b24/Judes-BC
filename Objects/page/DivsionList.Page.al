page 70147 "Divsion List"
{
    Caption = 'Divisions';
    PageType = List;
    SourceTable = Divsion;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Divsion Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Division Code"; Rec."Division Code")
                {
                    ApplicationArea = All;
                }

                field("Division Description"; Rec."Division Description")
                {
                    ApplicationArea = All;
                }

                field("Created Academic Year"; Rec."Created Academic Year")
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