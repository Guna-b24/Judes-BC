page 71681 "Hostel Card"
{
    PageType = Card;
    SourceTable = "Hostel1";
    ApplicationArea = All;
    Caption = 'Hostel';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code) { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(Campus; Rec.Campus) { ApplicationArea = All; }
                field(Company; Rec.Company) { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
            }

            group(Location)
            {
                field(Address; Rec.Address) { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
            }

            group(Capacity)
            {
                field("No. of Floors"; Rec."No. of Floors") { ApplicationArea = All; }
                field("Total Rooms"; Rec."Total Rooms") { ApplicationArea = All; }
                field("No. of Accomodation"; Rec."No. of Accomodation") { ApplicationArea = All; }
                field("Alloted Nos Of Bed"; Rec."Alloted Nos Of Bed") { ApplicationArea = All; }
                field("No. of Occupied"; Rec."No. of Occupied") { ApplicationArea = All; }
                field("Total No. Of Students"; Rec."Total No. Of Students") { ApplicationArea = All; }
            }

            group(Charges)
            {
                field("Per Day Amount"; Rec."Per Day Amount") { ApplicationArea = All; }
                field(Mess; Rec.Mess) { ApplicationArea = All; }
            }

            group("Staff Details")
            {
                field(Warden; Rec.Warden) { ApplicationArea = All; }
                field("Dorm Mistress/Master"; Rec."Dorm Mistress/Master") { ApplicationArea = All; }
                field(Matron1; Rec.Matron1) { ApplicationArea = All; }
                field(Matorn2; Rec.Matorn2) { ApplicationArea = All; }
                field(Matron3; Rec.Matron3) { ApplicationArea = All; }
                field("Dorm Assistant1"; Rec."Dorm Assistant1") { ApplicationArea = All; }
                field("Dorm Assistant2"; Rec."Dorm Assistant2") { ApplicationArea = All; }
                field("Dorm Assistant3"; Rec."Dorm Assistant3") { ApplicationArea = All; }
            }

            group(Integration)
            {
                field("Portal ID"; Rec."Portal ID") { ApplicationArea = All; }
            }
        }
    }
}
