page 71052 "Selection Process List"
{
    PageType = List;
    SourceTable = "Selection process";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Selection Process Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Selection No."; Rec."Selection No.") { }
                field(Class; Rec.Class) { }
                field(Curriculum; Rec.Curriculum) { }
                field("Academic Year"; Rec."Academic Year") { }
                field("Interview Date"; Rec."Interview Date") { }
                field("Total Selected"; Rec."Total Selected") { }
            }
        }
    }
}