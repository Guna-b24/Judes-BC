page 71192 "Participant Entry Line Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Participant Entry Line";
    Caption = 'Participant Entry Lines';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.") { }
                field("Student Name"; Rec."Student Name") { }
                field(Age; Rec.Age) { }
                field(House; Rec.House) { }
                field("Participant Type"; Rec."Participant Type") { }
                field(Points; Rec.Points) { }
            }
        }
    }
}