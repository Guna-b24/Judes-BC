page 71163 "Promotion Weightage"
{
    PageType = List;
    SourceTable = "Promotion Weightage";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Promotion Weightage Setup';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Class Code"; Rec."Class Code") { ApplicationArea = All; }
                field("Curriculum Code"; Rec."Curriculum Code") { ApplicationArea = All; }
                field("Academic Year Code"; Rec."Academic Year Code") { ApplicationArea = All; }
                field("Exam Type Code"; Rec."Exam Type Code") { ApplicationArea = All; }
                field(Weightage; Rec.Weightage) { ApplicationArea = All; }
            }
        }
    }
}