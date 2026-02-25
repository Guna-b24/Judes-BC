page 71061 "Promotion History List"
{
    PageType = List;
    SourceTable = "Promotion History";
    ApplicationArea = All;
    UsageCategory = History;
    Caption = 'Promotion History';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.") { ApplicationArea = All; }
                field("Student Name"; Rec."Student Name") { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field(Class; Rec.Class) { ApplicationArea = All; }
                field(Section; Rec.Section) { ApplicationArea = All; }
                field(Curriculum; Rec.Curriculum) { ApplicationArea = All; }
                field("Marks Obtained"; Rec."Marks Obtained") { ApplicationArea = All; }
                field("Pass %"; Rec."Pass %") { ApplicationArea = All; }
                field(Result; Rec.Result) { ApplicationArea = All; }
                field("Promoted Academic Year"; Rec."Promoted Academic Year") { ApplicationArea = All; }
                field("Promoted Class"; Rec."Promoted Class") { ApplicationArea = All; }
            }
        }
    }
}