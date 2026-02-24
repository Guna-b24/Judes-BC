page 72264 "LocationHR & PayrollSetup Card"
{
    PageType = Card;
    SourceTable = "Location HR & Payroll Setup";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Location Code"; Rec."Location Code") { }
                field("Location Name"; Rec."Location Name") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Salary Cyclic Code"; Rec."Salary Cyclic Code") { }
                field("Salary Date Interval"; Rec."Salary Date Interval") { }
                field("Processing Payroll Date"; Rec."Processing Payroll Date") { }
            }

            group("Attendance Setup")
            {
                field("Default Attendance Type"; Rec."Default Attendance Type") { }
                field("No of Hours Per Day"; Rec."No of Hours Per Day") { }
                field("No of Hours in Half Day"; Rec."No of Hours in Half Day") { }
                field("Minimum Attendance Credit Days"; Rec."Minimum Attendance Credit Days") { }
                field("Eligible Days for Credit Days"; Rec."Eligible Days for Credit Days") { }
                field("Attendance Bonus (%)"; Rec."Attendance Bonus (%)") { }
            }

            group("Over Time Setup")
            {
                field("Over Time Applicable"; Rec."Over Time Applicable") { }
                field("Over Time Approval Check"; Rec."Over Time Approval Check") { }
                field("Over Time Min Minutes"; Rec."Over Time Min Minutes") { }
                field("Over Time Max Minutes"; Rec."Over Time Max Minutes") { }
                field("Over Time Multiplier"; Rec."Over Time Multiplier") { }
                field("Over Time Hours Round Off"; Rec."Over Time Hours Round Off") { }
            }

            group("Statutory Setup")
            {
                field("PF Establishment No"; Rec."PF Establishment No") { }
                field("ESI Establishment No"; Rec."ESI Establishment No") { }
                field("Factory Establishment No"; Rec."Factory Establishment No") { }
                field("ESI to All"; Rec."ESI to All") { }
                field("PF to All"; Rec."PF to All") { }
                field("EPS to All"; Rec."EPS to All") { }
                field("VPF to All"; Rec."VPF to All") { }
                field("PT to All"; Rec."PT to All") { }
                field("LWF to All"; Rec."LWF to All") { }
            }

            group("Bonus & Gratuity")
            {
                field("Bonus Applicable"; Rec."Bonus Applicable") { }
                field("Bonus (%)"; Rec."Bonus (%)") { }
                field("Ex-Gratia (%)"; Rec."Ex-Gratia (%)") { }
                field("Gratuity Applicable"; Rec."Gratuity Applicable") { }
                field("Gratuity No. of Days Salary"; Rec."Gratuity No. of Days Salary") { }
            }

            group("Number Series")
            {
                field("Employee No."; Rec."Employee No.") { }
                field("Loan No."; Rec."Loan No.") { }
                field("Pay Revision No."; Rec."Pay Revision No.") { }
                field("Pay Arrear No."; Rec."Pay Arrear No.") { }
                field("Bonus No."; Rec."Bonus No.") { }
                field("Leave No."; Rec."Leave No.") { }
                field("Hourly Rate No."; Rec."Hourly Rate No.") { }
            }

            group("External Database Setup")
            {
                field("Database Type"; Rec."Database Type") { }
                field(Provider; Rec.Provider) { }
                field("Presist Security Info"; Rec."Presist Security Info") { }
                field("User ID"; Rec."User ID") { }
                field(Password; Rec.Password) { }
                field("Initial Catalog"; Rec."Initial Catalog") { }
                field("Data Source"; Rec."Data Source") { }
                field("Extended Properties"; Rec."Extended Properties") { }
                field("Connection String"; Rec."Connection String") { Editable = false; }
            }
        }
    }
}