page 72084 "Leave Entitlement List"
{
    PageType = List;
    SourceTable = "Leave Entitlement";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Leave Entitlement Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Leave Year Code"; Rec."Leave Year Code") { }
                field("Employee No"; Rec."Employee No") { }
                field(Name; Rec.Name) { }
                field("Leave Code"; Rec."Leave Code") { }
                field("Leave Opening Balance"; Rec."Leave Opening Balance") { }
                field("Total Leave Eligible for Year"; Rec."Total Leave Eligible for Year") { }
                field("Total Leave Availed"; Rec."Total Leave Availed") { }
                field("Total Leave Encashed"; Rec."Total Leave Encashed") { }
                field("Leave Closing Balance"; Rec."Leave Closing Balance") { }
                field(Synchronize; Rec.Synchronize) { }
            }
        }
    }
}