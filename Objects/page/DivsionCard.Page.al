page 70148 "Divsion Card"
{
    Caption = 'Division Card';
    PageType = Card;
    SourceTable = Divsion;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
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