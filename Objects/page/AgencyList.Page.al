page 70013 "Agency List"
{
    PageType = List;
    SourceTable = Agency;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Agency Card";
    Caption = 'Agencies';

    layout
    {
        area(Content)
        {
            repeater(Group)
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
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
