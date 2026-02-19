page 72012 "Advertisement Card"
{
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = Advertisement;
    ApplicationArea = All;
    Caption = 'Advertisement';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                }
                field("No. Of Vacancy"; Rec."No. Of Vacancy")
                {
                    ApplicationArea = All;
                }
                field("Required Vacancy"; Rec."Required Vacancy")
                {
                    ApplicationArea = All;
                }
            }

            group(Address)
            {
                field("Address 1"; Rec."Address 1")
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Address 3"; Rec."Address 3")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
            }

            group(Contact)
            {
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field(Mobile; Rec.Mobile)
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
            }

            group("Vacancy Details")
            {
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = All;
                }
                field(Prefrence; Rec.Prefrence)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Skill; Rec.Skill)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Certification; Rec.Certification)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Experience(In Yrs)"; Rec."Experience(In Yrs)")
                {
                    ApplicationArea = All;
                }
                field("Age From"; Rec."Age From")
                {
                    ApplicationArea = All;
                }
                field("Age To"; Rec."Age To")
                {
                    ApplicationArea = All;
                }
                field("Age Ability"; Rec."Age Ability")
                {
                    ApplicationArea = All;
                }
                field("Advertisement Type"; Rec."Advertisement Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
