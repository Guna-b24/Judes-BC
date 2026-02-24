page 71633 "Library Setup"
{
    PageType = Card;
    SourceTable = "Library Setup Table";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Company; Rec.Company) { }
                field("Location Code"; Rec."Location Code") { }
                field("Base Unit of Measure"; Rec."Base Unit of Measure") { }
                field("Item Category Code"; Rec."Item Category Code") { }
                field("Fine Code"; Rec."Fine Code") { }
                field("G/L Account"; Rec."G/L Account") { }
            }

            group("Staff Rules")
            {
                field("No. of Books - Staffs"; Rec."No. of Books - Staffs") { }
                field("No. of Days - Staffs"; Rec."No. of Days - Staffs") { }
                field("No. of Renewal - Staffs"; Rec."No. of Renewal - Staffs") { }
                field("Fine - Staffs"; Rec."Fine - Staffs") { }
            }

            group("Student Rules")
            {
                field("No. of Books - Student"; Rec."No. of Books - Student") { }
                field("No. of Days - Student"; Rec."No. of Days - Student") { }
                field("No Of Renewal"; Rec."No Of Renewal") { }
                field("Fine - Students"; Rec."Fine - Students") { }
            }

            group("Number Series")
            {
                field("Book No"; Rec."Book No") { }
                field("Book No. - WB"; Rec."Book No. - WB") { }
                field("Advance Booking No."; Rec."Advance Booking No.") { }
                field("Book Purch Req No."; Rec."Book Purch Req No.") { }
                field("Fee Invoice No."; Rec."Fee Invoice No.") { }
                field("Accession No. - MF"; Rec."Accession No. - MF") { }
                field("Accession No. - WB"; Rec."Accession No. - WB") { }
            }

            group("Posting Setup")
            {
                field("Journal Template Name"; Rec."Journal Template Name") { }
                field("Journal Batch Name"; Rec."Journal Batch Name") { }
            }

            group("Users")
            {
                field("Library MF User ID"; Rec."Library MF User ID") { }
                field("Library WB User ID"; Rec."Library WB User ID") { }
                field("Portal ID"; Rec."Portal ID") { }
            }
        }
    }


}