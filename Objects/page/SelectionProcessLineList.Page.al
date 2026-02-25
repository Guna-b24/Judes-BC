page 71053 "Selection Process Line List"
{
    PageType = List;
    SourceTable = "Selection Process Line";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Selection No."; Rec."Selection No.") { }
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