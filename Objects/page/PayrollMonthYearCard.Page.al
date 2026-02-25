page 72082 "Payroll Month & Year Card"
{
    PageType = Card;
    SourceTable = "Payroll Month & Year";
    ApplicationArea = All;
    Caption = 'Payroll Month & Year';
    UsageCategory = Administration;
    Editable = true;

    layout
    {
        area(content)
        {
            group("General Info")
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Salary Year Code"; Rec."Salary Year Code") { ApplicationArea = All; }
                field("Salary Cyclic Code"; Rec."Salary Cyclic Code") { ApplicationArea = All; }
                field("Salary Start Date"; Rec."Salary Start Date") { ApplicationArea = All; }
                field("Salary End Date"; Rec."Salary End Date") { ApplicationArea = All; }
                field("Salary Month"; Rec."Salary Month") { ApplicationArea = All; }
                field("Salary Year"; Rec."Salary Year") { ApplicationArea = All; }
                field(Closed; Rec.Closed) { ApplicationArea = All; }
            }

            group("Processing Status")
            {
                field("Attendance Generated"; Rec."Attendance Generated") { ApplicationArea = All; }
                field("Salary Processed"; Rec."Salary Processed") { ApplicationArea = All; }
                field("No of Employee Processed"; Rec."No of Employee Processed") { ApplicationArea = All; }
                field("Salary Posted"; Rec."Salary Posted") { ApplicationArea = All; }
                field("No of Employee Posted"; Rec."No of Employee Posted") { ApplicationArea = All; }
                field("Income Tax Salary Posted"; Rec."Income Tax Salary Posted") { ApplicationArea = All; }
            }

            group("VDA Details")
            {
                field("VDA Starting Points"; Rec."VDA Starting Points") { ApplicationArea = All; }
                field("VDA Ending Points"; Rec."VDA Ending Points") { ApplicationArea = All; }
                field("Total Points"; Rec."Total Points") { ApplicationArea = All; }
                field("Points Rate"; Rec."Points Rate") { ApplicationArea = All; }
                field("Total VDA Amount"; Rec."Total VDA Amount") { ApplicationArea = All; }
                field("Staff VDA Amount"; Rec."Staff VDA Amount") { ApplicationArea = All; }
                field("Workmen VDA Amount"; Rec."Workmen VDA Amount") { ApplicationArea = All; }
                field("VDA Minimum Daily Wages Range"; Rec."VDA Minimum Daily Wages Range") { ApplicationArea = All; }
                field("VDA Differance Amount"; Rec."VDA Differance Amount") { ApplicationArea = All; }
            }

            group("Challan Details")
            {
                field("PF Challan Date"; Rec."PF Challan Date") { ApplicationArea = All; }
                field("ESI Challan Date"; Rec."ESI Challan Date") { ApplicationArea = All; }
                field("Challan Bank Name"; Rec."Challan Bank Name") { ApplicationArea = All; }
            }
        }
    }
}