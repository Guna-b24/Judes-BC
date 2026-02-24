page 71889 "Grade List"
{
    PageType = List;
    SourceTable = Grade;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Grades';
    CardPageId = "Grade Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Min Percentage"; Rec."Min Percentage") { ApplicationArea = All; }
                field("Max Percentage"; Rec."Max Percentage") { ApplicationArea = All; }
                field(Points; Rec.Points) { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field("Portal ID"; Rec."Portal ID") { ApplicationArea = All; }
            }
        }
    }
}
