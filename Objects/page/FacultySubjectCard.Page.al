page 71151 "Faculty Subject Card"
{
    PageType = Card;
    SourceTable = "Faculty Subject";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Faculty Code"; rec."Faculty Code") { ApplicationArea = All; }
                field("Faculty Name"; rec."Faculty Name") { ApplicationArea = All; }
                field(Available; rec.Available) { ApplicationArea = All; }
                field("Class Master"; rec."Class Master") { ApplicationArea = All; }
            }

            group("Class Details")
            {
                field("Class Code"; rec."Class Code") { ApplicationArea = All; }
                field(Class; rec.Class) { ApplicationArea = All; }
                field("Section Code"; rec."Section Code") { ApplicationArea = All; }
                field(Curriculum; rec.Curriculum) { ApplicationArea = All; }
                field("Academic Year"; rec."Academic Year") { ApplicationArea = All; }
            }

            group("Subject Details")
            {
                field("Subject Code"; rec."Subject Code") { ApplicationArea = All; }
                field("Subject Description"; rec."Subject Description") { ApplicationArea = All; }
                field("Subject Type"; rec."Subject Type") { ApplicationArea = All; }
            }

            group(Hours)
            {
                field("Alloted Hours"; rec."Alloted Hours") { ApplicationArea = All; }
                field("Weekly Hours"; rec."Weekly Hours") { ApplicationArea = All; }
            }
        }
    }
}
