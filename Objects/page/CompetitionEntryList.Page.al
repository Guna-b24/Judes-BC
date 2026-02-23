page 71092 "Competition Entry List"
{
    PageType = List;
    SourceTable = "Competition Entry Header";
    Caption = 'Competition Entries';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Competition Entry Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Competition Name"; Rec."Competition Name") { ApplicationArea = All; }
                field("Competition Date"; Rec."Competition Date") { ApplicationArea = All; }
                field("Competition Status"; Rec."Competition Status") { ApplicationArea = All; }
                field("Event Type"; Rec."Event Type") { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
            }
        }
    }
}