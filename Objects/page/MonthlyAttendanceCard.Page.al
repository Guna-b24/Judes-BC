page 72284 "Monthly Attendance Card"
{
    PageType = Card;
    SourceTable = "Monthly Attendance";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Employee No"; Rec."Employee No") { }
                field(Name; Rec.Name) { }
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Salary Cycle Code"; Rec."Salary Cycle Code") { }
                field("Payroll Start Date"; Rec."Payroll Start Date") { }
                field("Payroll End Date"; Rec."Payroll End Date") { }
            }

            group("Attendance Summary")
            {
                field(Present; Rec.Present) { }
                field(Absent; Rec.Absent) { }
                field(Leave; Rec.Leave) { }
                field("Weekly Off"; Rec."Weekly Off") { }
                field(Holiday; Rec.Holiday) { }
                field("Total Payable Days"; Rec."Total Payable Days") { }
            }

            group("Salary Summary")
            {
                field("Actual Gross Amount"; Rec."Actual Gross Amount") { }
                field("Actual Deduction Amount"; Rec."Actual Deduction Amount") { }
                field("Actual Net Amount"; Rec."Actual Net Amount") { }
            }

            group("Payment Details")
            {
                field("Payment Type"; Rec."Payment Type") { }
                field("Pay Method"; Rec."Pay Method") { }
                field("Account Type"; Rec."Account Type") { }
                field("Account No."; Rec."Account No.") { }
                field("Cheque No."; Rec."Cheque No.") { }
                field("Cheque Date"; Rec."Cheque Date") { }
                field(Paid; Rec.Paid) { }
            }
        }
    }
}