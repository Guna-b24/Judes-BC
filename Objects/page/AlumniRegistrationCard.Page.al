page 70015 "Alumni Registration Card"
{
    PageType = Card;
    SourceTable = "Alumni Registration";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Alumni Registration';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(Gender; Rec.Gender) { ApplicationArea = All; }
                field("Date of Birth"; Rec."Date of Birth") { ApplicationArea = All; }
                field("Year Of Joining"; Rec."Year Of Joining") { ApplicationArea = All; }
                field("Year Of Graduation"; Rec."Year Of Graduation") { ApplicationArea = All; }
                field("Class Of Graduation"; Rec."Class Of Graduation") { ApplicationArea = All; }
                field("Present Occupation"; Rec."Present Occupation") { ApplicationArea = All; }
            }

            group(Education)
            {
                field("Bachelor Degree"; Rec."Bachelor Degree") { ApplicationArea = All; }
                field(BachelorInstitute; Rec.BachelorInstitute) { ApplicationArea = All; }

                field("Master Degree"; Rec."Master Degree") { ApplicationArea = All; }
                field(MasterInstitute; Rec.MasterInstitute) { ApplicationArea = All; }

                field(PhD; Rec.PhD) { ApplicationArea = All; }
                field(PhDInstitute; Rec.PhDInstitute) { ApplicationArea = All; }

                field("Medical Courses"; Rec."Medical Courses") { ApplicationArea = All; }
                field(MedicalInstitute; Rec.MedicalInstitute) { ApplicationArea = All; }

                field("Doctor of Medicine"; Rec."Doctor of Medicine") { ApplicationArea = All; }
                field(MDInstitute; Rec.MDInstitute) { ApplicationArea = All; }

                field(MS; Rec.MS) { ApplicationArea = All; }
                field(MSInstitute; Rec.MSInstitute) { ApplicationArea = All; }
            }

            group(Employment)
            {
                field("Name of the Company"; Rec."Name of the Company") { ApplicationArea = All; }
                field(Designation; Rec.Designation) { ApplicationArea = All; }
                field("Type of Business"; Rec."Type of Business") { ApplicationArea = All; }
            }

            group(Contact)
            {
                field("Mobile Number"; Rec."Mobile Number") { ApplicationArea = All; }
                field(Mobile2; Rec.Mobile2) { ApplicationArea = All; }
                field(Telephone; Rec.Telephone) { ApplicationArea = All; }
                field("E-mail"; Rec."E-mail") { ApplicationArea = All; }
            }

            group("Present Address")
            {
                field("Present-Address"; Rec."Present-Address") { ApplicationArea = All; }
                field("Persent-City"; Rec."Persent-City") { ApplicationArea = All; }
                field("Present-PostCode"; Rec."Present-PostCode") { ApplicationArea = All; }
                field("Present-State"; Rec."Present-State") { ApplicationArea = All; }
                field("Present-Country"; Rec."Present-Country") { ApplicationArea = All; }
            }

            group("Permanent Address")
            {
                field("Permanent-Address"; Rec."Permanent-Address") { ApplicationArea = All; }
                field("Permanent-City"; Rec."Permanent-City") { ApplicationArea = All; }
                field("Permanent-PostCode"; Rec."Permanent-PostCode") { ApplicationArea = All; }
                field("Permanent-State"; Rec."Permanent-State") { ApplicationArea = All; }
                field("Permanent-Country"; Rec."Permanent-Country") { ApplicationArea = All; }
            }

            group(Additional)
            {
                field(Achievements; Rec.Achievements) { ApplicationArea = All; }
                field(Hobbies; Rec.Hobbies) { ApplicationArea = All; }
                field(Comments; Rec.Comments) { ApplicationArea = All; }
                field(AgreeToUseComment; Rec.AgreeToUseComment) { ApplicationArea = All; }
                field(IsRegistered; Rec.IsRegistered) { ApplicationArea = All; }
                field(Event1; Rec.Event1) { ApplicationArea = All; }
                field(Event1Desc; Rec.Event1Desc) { ApplicationArea = All; }
                field(Event2; Rec.Event2) { ApplicationArea = All; }
                field(Event2Desc; Rec.Event2Desc) { ApplicationArea = All; }
            }
        }
    }
}
