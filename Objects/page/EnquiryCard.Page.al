page 71001 "Enquiry Card"
{
    PageType = Card;
    SourceTable = Enquiry;
    ApplicationArea = All;
    Caption = 'Enquiry Card';
    Editable = true;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.") { }
                field(Name; Rec.Name) { }
                field("Enquiry Gender"; Rec."Enquiry Gender") { }
                field("Type Of Enquiry"; Rec."Type Of Enquiry") { }
                field("Enquiry Source"; Rec."Enquiry Source") { }
                field("Enquirer Name"; Rec."Enquirer Name") { }
                field("Relationship with Applicant"; Rec."Relationship with Applicant") { }
                field("Media Vehicle"; Rec."Media Vehicle") { }
                field("Date of Birth"; Rec."Date of Birth") { }
                field("Father's Name"; Rec."Father's Name") { }
                field("Mother's Name"; Rec."Mother's Name") { }
                field(Citizenship; Rec.Citizenship) { }
                field("Academic Year"; Rec."Academic Year") { }
                field("Enquiry Date"; Rec."Enquiry Date") { }
                field("Class Applied"; Rec."Class Applied") { }
                field("Hostel Accomodation"; Rec."Hostel Accomodation") { }
                field("Name Of The Previous Institute"; Rec."Name Of The Previous Institute") { }
                field("Medium Of Instruction"; Rec."Medium Of Instruction") { }
                field("Curriculum Intrested"; Rec."Curriculum Intrested") { }
                field("Class Last Attended"; Rec."Class Last Attended") { }
                field("Curriculum Followed"; Rec."Curriculum Followed") { }
                field("Address To"; Rec."Address To") { }
                field(Addressee; Rec.Addressee) { }
                field("Address 1"; Rec."Address 1") { }
                field("Address 2"; Rec."Address 2") { }
                field(City; Rec.City) { }
                field("Post Code"; Rec."Post Code") { }
                field("Country Code"; Rec."Country Code") { }
                field("E-Mail Address"; Rec."E-Mail Address") { }
                field("Mobile Number"; Rec."Mobile Number") { }
                field("Phone Number"; Rec."Phone Number") { }
                field(State; Rec.State) { }
                field("Enquiry No Series"; Rec."Enquiry No Series") { }
                field(Age; Rec.Age) { }
                field(Months; Rec.Months) { }
                field(Campaign; Rec.Campaign) { }
                field("Address 3"; Rec."Address 3") { }
                field("Enquiry Closed"; Rec."Enquiry Closed") { }
                field("Portal ID"; Rec."Portal ID") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}