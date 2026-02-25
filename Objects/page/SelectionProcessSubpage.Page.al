page 71051 "Selection Process Subpage"
{
    PageType = ListPart;
    SourceTable = "Selection Process Line";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No") { }
                field(Name; Rec.Name) { }
                field(Gender; Rec.Gender) { }
                field("Evaluation Total"; Rec."Evaluation Total") { }
                field(Rank; Rec.Rank) { }
                field(Select; Rec.Select) { }
            }
        }
    }
}