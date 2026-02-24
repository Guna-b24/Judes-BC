page 71055 "Marks Header List"
{
    PageType = List;
    SourceTable = "Marks Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Marks Header Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { }
                field(Class; Rec.Class) { }
                field(Section; Rec.Section) { }
                field("Academic Year"; Rec."Academic Year") { }
                field("Exam Type"; Rec."Exam Type") { }
                field(Subject; Rec.Subject) { }
                field("Teacher Name"; Rec."Teacher Name") { }
                field("Entry Completed"; Rec."Entry Completed") { }
            }
        }
    }
}