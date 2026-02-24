page 71683 "Hostel Setup"
{
    PageType = Card;
    SourceTable = "Hostel Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Hostel Setup';



    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Company; Rec.Company) { ApplicationArea = All; }
                field("Hostel Allocation"; Rec."Hostel Allocation") { ApplicationArea = All; }
                field("Hostel Fee No."; Rec."Hostel Fee No.") { ApplicationArea = All; }
                field("Room Change No."; Rec."Room Change No.") { ApplicationArea = All; }
                field("Hostel Attendance No."; Rec."Hostel Attendance No.") { ApplicationArea = All; }
            }

            group("Fee Setup")
            {
                field("Hostel Fee Code"; Rec."Hostel Fee Code") { ApplicationArea = All; }
                field("Mess Fee"; Rec."Mess Fee") { ApplicationArea = All; }
                field("Mess Fee Code"; Rec."Mess Fee Code") { ApplicationArea = All; }
                field("Room Rent Charging"; Rec."Room Rent Charging") { ApplicationArea = All; }
                field("Room Rent"; Rec."Room Rent") { ApplicationArea = All; }
            }

            group("Expense Setup")
            {
                field("Consumption Code"; Rec."Consumption Code") { ApplicationArea = All; }
                field("Electricity Expense Code"; Rec."Electricity Expense Code") { ApplicationArea = All; }
            }

            group("Company Batch Setup")
            {
                field("MontFord Issue Batch"; Rec."MontFord Issue Batch") { ApplicationArea = All; }
                field("WestBrook Issue Batch"; Rec."WestBrook Issue Batch") { ApplicationArea = All; }
            }

            group(Integration)
            {
                field("User ID"; Rec."User ID") { ApplicationArea = All; }
                field("Portal ID"; Rec."Portal ID") { ApplicationArea = All; }
            }
        }
    }


}
