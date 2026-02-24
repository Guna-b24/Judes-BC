page 71150 "Faculty Subject List"
{
    PageType = List;
    SourceTable = "Faculty Subject";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Faculty Subject Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Faculty Code"; rec."Faculty Code") { ApplicationArea = All; }
                field("Faculty Name"; rec."Faculty Name") { ApplicationArea = All; }
                field(Class; rec.Class) { ApplicationArea = All; }
                field(Curriculum; rec.Curriculum) { ApplicationArea = All; }
                field("Section Code"; rec."Section Code") { ApplicationArea = All; }
                field("Subject Code"; rec."Subject Code") { ApplicationArea = All; }
                field("Subject Description"; rec."Subject Description") { ApplicationArea = All; }
                field("Alloted Hours"; rec."Alloted Hours") { ApplicationArea = All; }
                field("Weekly Hours"; rec."Weekly Hours") { ApplicationArea = All; }
                field(Available; rec.Available) { ApplicationArea = All; }
                field("Academic Year"; rec."Academic Year") { ApplicationArea = All; }
            }
        }
    }
}
