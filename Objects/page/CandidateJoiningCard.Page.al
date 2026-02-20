page 70047 "Candidate Joining Card"
{
    PageType = Card;
    SourceTable = "Candidate Joining";
    ApplicationArea = All;
    Caption = 'Candidate Joining Card';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                }

                field("First Name"; Rec."First Name") { ApplicationArea = All; }
                field("Middle Name"; Rec."Middle Name") { ApplicationArea = All; }
                field("Last Name"; Rec."Last Name") { ApplicationArea = All; }
                field(Initials; Rec.Initials) { ApplicationArea = All; }
                field("Search Name"; Rec."Search Name") { ApplicationArea = All; }
                field("Job Title"; Rec."Job Title") { ApplicationArea = All; }
                field(Designation; Rec.Designation) { ApplicationArea = All; }
            }

            group("Contact Details")
            {
                field(Address; Rec.Address) { ApplicationArea = All; }
                field("Address 2"; Rec."Address 2") { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field("Post Code"; Rec."Post Code") { ApplicationArea = All; }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field("Mobile Phone No."; Rec."Mobile Phone No.") { ApplicationArea = All; }
                field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
                field("Company E-Mail"; Rec."Company E-Mail") { ApplicationArea = All; }
            }

            group("Employment Details")
            {
                field("Date of Joining"; Rec."Date of Joining") { ApplicationArea = All; }
                field("Date of Confirmation"; Rec."Date of Confirmation") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Grade Code"; Rec."Grade Code") { ApplicationArea = All; }
                field("Working Shift Code"; Rec."Working Shift Code") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field("Current Status"; Rec."Current Status") { ApplicationArea = All; }
                field(Blocked; Rec.Blocked) { ApplicationArea = All; }
            }

            group("Statutory Details")
            {
                field("PAN No"; Rec."PAN No") { ApplicationArea = All; }
                field("PF No"; Rec."PF No") { ApplicationArea = All; }
                field("ESI No"; Rec."ESI No") { ApplicationArea = All; }
                field("PF Applicable"; Rec."PF Applicable") { ApplicationArea = All; }
                field("ESI Applicable"; Rec."ESI Applicable") { ApplicationArea = All; }
                field("PT Applicable"; Rec."PT Applicable") { ApplicationArea = All; }
                field("Bonus Applicable"; Rec."Bonus Applicable") { ApplicationArea = All; }
                field("Gratuity Applicable"; Rec."Gratuity Applicable") { ApplicationArea = All; }
            }

            group("Bank Details")
            {
                field("Payment Method"; Rec."Payment Method") { ApplicationArea = All; }
                field("Bank Name"; Rec."Bank Name") { ApplicationArea = All; }
                field("Bank Branch"; Rec."Bank Branch") { ApplicationArea = All; }
                field("Account No"; Rec."Account No") { ApplicationArea = All; }
            }
        }

        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }

            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }
}
