page 72085 "Leave Entitlement Card"
{
    PageType = Card;
    SourceTable = "Leave Entitlement";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Leave Year Code"; Rec."Leave Year Code") { }
                field("Employee No"; Rec."Employee No") { }
                field(Name; Rec.Name) { }
                field("Leave Code"; Rec."Leave Code") { }
                field(Probationary; Rec.Probationary) { }
                field("Leave Opening Balance"; Rec."Leave Opening Balance") { }
                field("Total Leave Eligible for Year"; Rec."Total Leave Eligible for Year") { }
                field("Total Leave Balance"; Rec."Total Leave Balance") { }
                field("Total Leave Availed"; Rec."Total Leave Availed") { }
                field("Total Leave Encashed"; Rec."Total Leave Encashed") { }
                field("Leave Closing Balance"; Rec."Leave Closing Balance") { }
                field(Synchronize; Rec.Synchronize) { }
            }
        }
    }
}