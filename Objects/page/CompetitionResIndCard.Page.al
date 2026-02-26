page 71097 "Competition Res Ind Card"
{
    PageType = Card;
    SourceTable = "Competition Res Indvu Line";
    ApplicationArea = All;
    Caption = 'Competition Individual Result';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.") { ApplicationArea = All; }
                field("Competition Name"; Rec."Competition Name") { ApplicationArea = All; }
                field("Competition Type"; Rec."Competition Type") { ApplicationArea = All; }
                field("Event Type"; Rec."Event Type") { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
            }

            group(Student)
            {
                field("Student No."; Rec."Student No.") { ApplicationArea = All; }
                field("Student Name"; Rec."Student Name") { ApplicationArea = All; }
                field(Class; Rec.Class) { ApplicationArea = All; }
                field(Section; Rec.Section) { ApplicationArea = All; }
                field(House; Rec.House) { ApplicationArea = All; }
                field("Student Division"; Rec."Student Division") { ApplicationArea = All; }
                field(Age; Rec.Age) { ApplicationArea = All; }
            }

            group(Result)
            {
                field("Participant Type"; Rec."Participant Type") { ApplicationArea = All; }
                field(Position; Rec.Position) { ApplicationArea = All; }
                field(Points; Rec.Points) { ApplicationArea = All; }
                field("Details NUM"; Rec."Details NUM") { ApplicationArea = All; }
                field("Details TXT"; Rec."Details TXT") { ApplicationArea = All; }
            }
        }
    }
}