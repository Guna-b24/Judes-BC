page 71090 "Competition Result Team List"
{
    PageType = List;
    SourceTable = "Competition Result Team";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Competition Result Team';
    CardPageId = "Competition Result Team Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Competition Entry No."; Rec."Competition Entry No.") { ApplicationArea = All; }
                field("Competition Name"; Rec."Competition Name") { ApplicationArea = All; }
                field("Event Type"; Rec."Event Type") { ApplicationArea = All; }
                field("Student Division"; Rec."Student Division") { ApplicationArea = All; }
                field("Team Size"; Rec."Team Size") { ApplicationArea = All; }
                field("Competition Status"; Rec."Competition Status") { ApplicationArea = All; }
                field("Update Results"; Rec."Update Results") { ApplicationArea = All; }
            }
        }
    }
}