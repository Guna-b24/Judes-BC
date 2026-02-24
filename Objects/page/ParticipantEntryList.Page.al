page 71198 "Participant Entry List"
{
    PageType = List;
    SourceTable = "Participant Entry Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Participant Entry Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { }
                field("Competition Name"; Rec."Competition Name") { }
                field("Student Division"; Rec."Student Division") { }
                field(House; Rec.House) { }
                field("Event Type"; Rec."Event Type") { }
                field("Competition Date"; Rec."Competition Date") { }
                field("Competition Status"; Rec."Competition Status") { }
            }
        }
    }
}