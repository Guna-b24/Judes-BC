page 71086 "Competition Result Ind List"
{
    PageType = List;
    SourceTable = "Competition Result Individual";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Competition Result Individual';

    CardPageId = "Competition Result Ind Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Competition Entry No."; Rec."Competition Entry No.") { ApplicationArea = All; }
                field("Competition Name"; Rec."Competition Name") { ApplicationArea = All; }
                field("Competition Type"; Rec."Competition Type") { ApplicationArea = All; }
                field("Event Type"; Rec."Event Type") { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field("Competition Date"; Rec."Competition Date") { ApplicationArea = All; }
                field("Competition Status"; Rec."Competition Status") { ApplicationArea = All; }
                field("Update Results"; Rec."Update Results") { ApplicationArea = All; }
            }
        }
    }
}