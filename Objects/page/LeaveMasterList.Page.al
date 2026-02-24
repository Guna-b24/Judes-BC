page 72196 "Leave Master List"
{
    PageType = List;
    SourceTable = "Leave Master";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Leave Master Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Leave Code"; Rec."Leave Code") { }
                field(Description; Rec.Description) { }
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field(Regular; Rec.Regular) { }
                field(Probationary; Rec.Probationary) { }
                field("Total Leaves in a Year Regular"; Rec."Total Leaves in a Year Regular") { }
                field("Total Leaves in a Year Prob."; Rec."Total Leaves in a Year Prob.") { }
                field("Paid Leave"; Rec."Paid Leave") { }
                field("UnPaid Leave"; Rec."UnPaid Leave") { }
                field("Encash Leave"; Rec."Encash Leave") { }
                field("Carry Forward"; Rec."Carry Forward") { }
            }
        }
    }
}