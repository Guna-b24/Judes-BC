page 71083 "House Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "House";
    Editable = true;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                }
                field("House Name"; Rec."House Name")
                {
                }
                field(Color; Rec.Color)
                {
                }
                field("No Incharge"; Rec."No Incharge")
                {
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Editable = false;
                }
                field("No. of Students Allotted"; Rec."No. of Students Allotted")
                {
                    Editable = false;
                }
                field(Points; Rec.Points)
                {
                    Editable = false;
                }
                field("Orig. Point"; Rec."Orig. Point")
                {
                    Editable = false;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                }
            }
        }
    }
}
