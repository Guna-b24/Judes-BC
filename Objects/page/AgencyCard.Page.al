page 70012 "Agency Card"
{
    PageType = Card;
    SourceTable = Agency;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Agency';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Indenting No"; Rec."Indenting No")
                {
                    ApplicationArea = All;
                }
                field("Agency Code"; Rec."Agency Code")
                {
                    ApplicationArea = All;
                }
                field("Agency Name"; Rec."Agency Name")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
            }

            group(Address)
            {
                field("Address 1"; Rec."Address 1") { ApplicationArea = All; }
                field("Address 2"; Rec."Address 2") { ApplicationArea = All; }
                field("Address 3"; Rec."Address 3") { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field("Postal Code"; Rec."Postal Code") { ApplicationArea = All; }
                field(Country; Rec.Country) { ApplicationArea = All; }
            }

            group(Contact)
            {
                field("Contact Person"; Rec."Contact Person") { ApplicationArea = All; }
                field(Phone; Rec.Phone) { ApplicationArea = All; }
                field(Mobile; Rec.Mobile) { ApplicationArea = All; }
                field(Fax; Rec.Fax) { ApplicationArea = All; }
                field("E-mail"; Rec."E-mail") { ApplicationArea = All; }
            }

            group(AttachmentGroup)
            {
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
