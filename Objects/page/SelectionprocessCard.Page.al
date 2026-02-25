page 71050 "Selection Process Card"
{
    PageType = Card;
    SourceTable = "Selection process";
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Selection No."; Rec."Selection No.") { }
                field(Class; Rec.Class) { }
                field(Curriculum; Rec.Curriculum) { }
                field("Academic Year"; Rec."Academic Year") { }
                field("Interview Date"; Rec."Interview Date") { }
                field("Seats Vacant"; Rec."Seats Vacant") { }
                field("Total Selected"; Rec."Total Selected") { }
            }

            part(Lines; "Selection Process Subpage")
            {
                SubPageLink = "Selection No." = FIELD("Selection No.");
                ApplicationArea = All;
            }
        }
    }
}