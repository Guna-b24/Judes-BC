page 71058 "Marks Line List"
{
    PageType = List;
    SourceTable = "Marks Line";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.") { }
                field("Student No."; Rec."Student No.") { }
                field("Student Name"; Rec."Student Name") { }
                field(Class; Rec.Class) { }
                field(Section; Rec.Section) { }
                field("Academic Year"; Rec."Academic Year") { }
                field(Curriculum; Rec.Curriculum) { }
                field(Subject; Rec.Subject) { }
                field("Exam Type"; Rec."Exam Type") { }
                field("Max Mark"; Rec."Max Mark") { }
                field("Pass Mark"; Rec."Pass Mark") { }
                field("Marks Obtained"; Rec."Marks Obtained") { }
                field(Percentage; Rec.Percentage) { }
                field(Result; Rec.Result) { }
                field(Grade; Rec.Grade) { }
                field(Points; Rec.Points) { }
                field(Published; Rec.Published) { }
            }
        }
    }
}