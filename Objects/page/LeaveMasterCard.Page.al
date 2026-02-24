page 72097 "Leave Master Card"
{
    PageType = Card;
    SourceTable = "Leave Master";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Leave Code"; Rec."Leave Code") { }
                field(Description; Rec.Description) { }
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
            }

            group("Regular Leave")
            {
                field(Regular; Rec.Regular) { }
                field("Credit Interval Regular"; Rec."Credit Interval Regular") { }
                field("Leave in a Credit Int. Regular"; Rec."Leave in a Credit Int. Regular") { }
                field("Total Leaves in a Year Regular"; Rec."Total Leaves in a Year Regular") { }
            }

            group("Probationary Leave")
            {
                field(Probationary; Rec.Probationary) { }
                field("Credit Interval Prob."; Rec."Credit Interval Prob.") { }
                field("Leave in a Credit Int. Prob."; Rec."Leave in a Credit Int. Prob.") { }
                field("Total Leaves in a Year Prob."; Rec."Total Leaves in a Year Prob.") { }
            }

            group(Settings)
            {
                field("Paid Leave"; Rec."Paid Leave") { }
                field("UnPaid Leave"; Rec."UnPaid Leave") { }
                field("Encash Leave"; Rec."Encash Leave") { }
                field("Maximum Encash Leave"; Rec."Maximum Encash Leave") { }
                field("Carry Forward"; Rec."Carry Forward") { }
                field("Create Leave Balance"; Rec."Create Leave Balance") { }
            }

            group("Day Rules")
            {
                field("Full Day"; Rec."Full Day") { }
                field("Mark As Full Day First Half"; Rec."Mark As Full Day First Half") { }
                field("Mark As Full Day Secod Half"; Rec."Mark As Full Day Secod Half") { }

                field("First Half Day"; Rec."First Half Day") { }
                field("I'st Mark As First Half Day"; Rec."I'st Mark As First Half Day") { }
                field("I'st Mark As Second Half Day"; Rec."I'st Mark As Second Half Day") { }

                field("Second Half Day"; Rec."Second Half Day") { }
                field("II'nd Mark As First Half Day"; Rec."II'nd Mark As First Half Day") { }
                field("II'nd Mark As Second Half Day"; Rec."II'nd Mark As Second Half Day") { }
            }
        }
    }
}