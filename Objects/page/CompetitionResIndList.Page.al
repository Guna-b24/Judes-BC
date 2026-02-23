page 71096 "Competition Res Ind List"
{
    PageType = List;
    SourceTable = "Competition Res Indvu Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Competition Res Ind Card";
    Caption = 'Competition Individual Results';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                field("Student No."; Rec."Student No.") { ApplicationArea = All; }
                field("Student Name"; Rec."Student Name") { ApplicationArea = All; }
                field("Competition Name"; Rec."Competition Name") { ApplicationArea = All; }
                field("Competition Type"; Rec."Competition Type") { ApplicationArea = All; }
                field(Position; Rec.Position) { ApplicationArea = All; }
                field(Points; Rec.Points) { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
            }
        }
    }
}