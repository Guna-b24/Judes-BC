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
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the unique number assigned to the enquiry.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the applicant.';
                }
                field("Enquiry Gender"; Rec."Enquiry Gender")
                {
                    ToolTip = 'Specifies the gender of the applicant.';
                }
                field("Type Of Enquiry"; Rec."Type Of Enquiry")
                {
                    ToolTip = 'Specifies the type of enquiry.';
                }
                field("Enquiry Source"; Rec."Enquiry Source")
                {
                    ToolTip = 'Specifies how the enquiry was received.';
                }
                field("Enquirer Name"; Rec."Enquirer Name")
                {
                    ToolTip = 'Specifies the name of the person making the enquiry.';
                }
                field("Relationship with Applicant"; Rec."Relationship with Applicant")
                {
                    ToolTip = 'Specifies the relationship of the enquirer to the applicant.';
                }
                field("Media Vehicle"; Rec."Media Vehicle")
                {
                    ToolTip = 'Specifies the media through which the enquiry was received.';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the applicant''s date of birth.';
                }
                field("Father's Name"; Rec."Father's Name")
                {
                    ToolTip = 'Specifies the name of the applicant''s father.';
                }
                field("Mother's Name"; Rec."Mother's Name")
                {
                    ToolTip = 'Specifies the name of the applicant''s mother.';
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ToolTip = 'Specifies the citizenship of the applicant.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the academic year for the enquiry.';
                }
                field("Enquiry Date"; Rec."Enquiry Date")
                {
                    ToolTip = 'Specifies the date when the enquiry was created.';
                }
                field("Class Applied"; Rec."Class Applied")
                {
                    ToolTip = 'Specifies the class the applicant is applying for.';
                }
                field("Hostel Accomodation"; Rec."Hostel Accomodation")
                {
                    ToolTip = 'Specifies whether hostel accommodation is required.';
                }
                field("Name Of The Previous Institute"; Rec."Name Of The Previous Institute")
                {
                    ToolTip = 'Specifies the name of the applicant''s previous institution.';
                }
                field("Medium Of Instruction"; Rec."Medium Of Instruction")
                {
                    ToolTip = 'Specifies the medium of instruction preferred or followed.';
                }
                field("Curriculum Intrested"; Rec."Curriculum Intrested")
                {
                    ToolTip = 'Specifies the curriculum the applicant is interested in.';
                }
                field("Class Last Attended"; Rec."Class Last Attended")
                {
                    ToolTip = 'Specifies the last class attended by the applicant.';
                }
                field("Curriculum Followed"; Rec."Curriculum Followed")
                {
                    ToolTip = 'Specifies the curriculum previously followed by the applicant.';
                }
                field("Address To"; Rec."Address To")
                {
                    ToolTip = 'Specifies to whom the address is directed.';
                }
                field(Addressee; Rec.Addressee)
                {
                    ToolTip = 'Specifies the name of the addressee.';
                }
                field("Address 1"; Rec."Address 1")
                {
                    ToolTip = 'Specifies the primary address line.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the secondary address line.';
                }
                field("Address 3"; Rec."Address 3")
                {
                    ToolTip = 'Specifies additional address details.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the city of the applicant.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field("Country Code"; Rec."Country Code")
                {
                    ToolTip = 'Specifies the country/region code.';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the state of the applicant.';
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ToolTip = 'Specifies the email address for communication.';
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ToolTip = 'Specifies the mobile contact number.';
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the phone number.';
                }
                field("Enquiry No Series"; Rec."Enquiry No Series")
                {
                    ToolTip = 'Specifies the number series used for enquiry numbering.';
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the age of the applicant.';
                }
                field(Months; Rec.Months)
                {
                    ToolTip = 'Specifies additional months in the applicant''s age.';
                }
                field(Campaign; Rec.Campaign)
                {
                    ToolTip = 'Specifies the campaign associated with the enquiry.';
                }
                field("Enquiry Closed"; Rec."Enquiry Closed")
                {
                    ToolTip = 'Specifies whether the enquiry has been closed.';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ToolTip = 'Specifies the portal identifier linked to the enquiry.';
                }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}