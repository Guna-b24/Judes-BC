page 71094 "Competition Entry Subform"
{
    PageType = ListPart;
    SourceTable = "Competition Entry Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Student Division"; Rec."Student Division") { ApplicationArea = All; }
                field("Min Age"; Rec."Min Age") { ApplicationArea = All; }
                field("Max Age"; Rec."Max Age") { ApplicationArea = All; }
                field("Cut Off Date"; Rec."Cut Off Date") { ApplicationArea = All; }
                field("Team Size"; Rec."Team Size") { ApplicationArea = All; }
                field(Substitute; Rec.Substitute) { ApplicationArea = All; }
                field(Gender; Rec.Gender) { ApplicationArea = All; }
            }
        }
    }
}