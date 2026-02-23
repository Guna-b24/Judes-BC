page 71098 "Competition Res Team List"
{
    PageType = List;
    SourceTable = "Competition Res Team Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Competition Team Results';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                field("Team No."; Rec."Team No.") { ApplicationArea = All; }
                field(House; Rec.House) { ApplicationArea = All; }
                field("Competition Name"; Rec."Competition Name") { ApplicationArea = All; }
                field("Competition Type"; Rec."Competition Type") { ApplicationArea = All; }
                field(Position; Rec.Position) { ApplicationArea = All; }
                field(Points; Rec.Points) { ApplicationArea = All; }
                field("Team Total Points"; Rec."Team Total Points") { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
            }
        }
    }
}