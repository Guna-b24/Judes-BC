page 71162 "Promotion Suggestion"
{
    PageType = Worksheet;
    SourceTable = "Promotion Suggestion";
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Promotion Suggestion';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.") { ApplicationArea = All; }
                field("Student Name"; Rec."Student Name") { ApplicationArea = All; }
                field(Class; Rec.Class) { ApplicationArea = All; }
                field(Section; Rec.Section) { ApplicationArea = All; }
                field(Curriculum; Rec.Curriculum) { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field("Marks Obtained"; Rec."Marks Obtained") { ApplicationArea = All; }
                field("Pass %"; Rec."Pass %") { ApplicationArea = All; }
                field(Result; Rec.Result) { ApplicationArea = All; }
            }
        }
    }


}