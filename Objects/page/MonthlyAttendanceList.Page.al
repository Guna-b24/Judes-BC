page 72083 "Monthly Attendance List"
{
    PageType = List;
    SourceTable = "Monthly Attendance";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Monthly Attendance Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No") { }
                field(Name; Rec.Name) { }
                field(Month; Rec.Month) { }
                field(Year; Rec.Year) { }
                field("Salary Cycle Code"; Rec."Salary Cycle Code") { }
                field("Total Payable Days"; Rec."Total Payable Days") { }
                field("Actual Net Amount"; Rec."Actual Net Amount") { }
                field("Payable Net Amount"; Rec."Payable Net Amount") { }
                field("Salary Processed"; Rec."Salary Processed") { }
                field(Posted; Rec.Posted) { }
                field(Paid; Rec.Paid) { }
            }
        }
    }
}