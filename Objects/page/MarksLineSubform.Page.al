page 71057 "Marks Line Subform"
{
    PageType = ListPart;
    SourceTable = "Marks Line";
    ApplicationArea = All;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.") { }
                field("Student Name"; Rec."Student Name") { }
                field("Max Mark"; Rec."Max Mark") { }
                field("Pass Mark"; Rec."Pass Mark") { }
                field("Marks Obtained"; Rec."Marks Obtained") { }
                field(Percentage; Rec.Percentage) { Editable = false; }
                field(Result; Rec.Result) { Editable = false; }
                field(Grade; Rec.Grade) { Editable = false; }
                field(Points; Rec.Points) { Editable = false; }
                field(Published; Rec.Published) { }
            }
        }
    }
}