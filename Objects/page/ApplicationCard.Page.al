page 70020 "Application Card"
{
    PageType = Card;
    SourceTable = Application;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Application';

    layout
    {
        area(content)
        {

            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Name of the pupil"; Rec."Name of the pupil")
                {
                    ApplicationArea = All;
                }

                field("Applicant Gender"; Rec."Applicant Gender")
                {
                    ApplicationArea = All;
                }

                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }

                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                }

                field(Months; Rec.Months)
                {
                    ApplicationArea = All;
                }

                field("Application Status"; Rec."Application Status")
                {
                    ApplicationArea = All;
                }
            }

            group(Academic)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }

                field("Curriculum Intrested"; Rec."Curriculum Intrested")
                {
                    ApplicationArea = All;
                }

                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
            }

            group(Contact)
            {
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                }

                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }

                field(Address1; Rec.Address1)
                {
                    ApplicationArea = All;
                }

                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }

                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }

                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
            }

            group(Financial)
            {
                field("Application Cost"; Rec."Application Cost")
                {
                    ApplicationArea = All;
                }

                field("Registration Cost"; Rec."Registration Cost")
                {
                    ApplicationArea = All;
                }

                field("Mode of Payment"; Rec."Mode of Payment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
