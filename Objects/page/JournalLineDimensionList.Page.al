page 50120 "Journal Line Dimension List"
{
    PageType = List;
    SourceTable = "Journal Line Dimension";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Journal Line Dimensions';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Journal Line No."; Rec."Journal Line No.")
                {
                    ApplicationArea = All;
                }
                field("Allocation Line No."; Rec."Allocation Line No.")
                {
                    ApplicationArea = All;
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ApplicationArea = All;
                }
                field("New Dimension Value Code"; Rec."New Dimension Value Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}