page 71173 "Faculty Class Plan List"
{
    PageType = List;
    SourceTable = "Faculty Class Plan Header";
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageId = "Faculty Class Plan Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Class; Rec.Class) { ApplicationArea = All; }
                field(Curriculum; Rec.Curriculum) { ApplicationArea = All; }
                field("Subject Code"; Rec."Subject Code") { ApplicationArea = All; }
                field("Faculty Code"; Rec."Faculty Code") { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field("Plan Status"; Rec."Plan Status") { ApplicationArea = All; }
            }
        }
    }
}