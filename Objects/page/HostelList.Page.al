page 71680 "Hostel List"
{
    PageType = List;
    SourceTable = "Hostel1";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Hostel Card";
    Caption = 'Hostels';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Total Rooms"; Rec."Total Rooms")
                {
                    ApplicationArea = All;
                }
                field("No. of Occupied"; Rec."No. of Occupied")
                {
                    ApplicationArea = All;
                }
                field("Per Day Amount"; Rec."Per Day Amount")
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
