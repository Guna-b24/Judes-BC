page 71197 "Participant Entry Card"
{
    PageType = Card;
    SourceTable = "Participant Entry Header";
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.") { }
                field("Competition Entry No."; Rec."Competition Entry No.") { }
                field("Competition Name"; Rec."Competition Name") { }
                field("Academic Year"; Rec."Academic Year") { }
                field("Competition Date"; Rec."Competition Date") { }
                field("Competition Status"; Rec."Competition Status") { }
            }

            group("Event Details")
            {
                field("Student Division"; Rec."Student Division") { }
                field(House; Rec.House) { }
                field("Event Type"; Rec."Event Type") { }
                field("Team No."; Rec."Team No.") { }
                field("Team Size"; Rec."Team Size") { }
                field(Substitute; Rec.Substitute) { }
            }

            group("Additional Info")
            {
                field(Gender; Rec.Gender) { }
                field(Class; Rec.Class) { }
                field(Section; Rec.Section) { }
                field("Update Entry"; Rec."Update Entry") { }
                field("Update Results"; Rec."Update Results") { }
            }
            part(Lines; "Participant Entry Line Subform")
            {
                Caption = 'Participant Entry Lines';
                SubPageLink = "Document No." = FIELD("No.");

            }
        }
    }
}