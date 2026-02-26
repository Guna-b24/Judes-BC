page 71082 "House List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "House";
    UsageCategory = Lists;
    CardPageId = "House Card";

    layout
    {
        area(content)
        {
            repeater(Group)
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
                }
                field("No. of Students Allotted"; Rec."No. of Students Allotted")
                {
                }
                field(Points; Rec.Points)
                {
                }
                field("Orig. Point"; Rec."Orig. Point")
                {
                }
            }
        }
    }
}
