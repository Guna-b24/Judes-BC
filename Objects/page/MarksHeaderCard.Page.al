page 71056 "Marks Header Card"
{
    PageType = Document;
    SourceTable = "Marks Header";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    AssistEdit = true;
                }
                field("Class Code"; Rec."Class Code") { }
                field(Class; Rec.Class) { }
                field(Section; Rec.Section) { }
                field(Curriculum; Rec.Curriculum) { }
                field("Academic Year"; Rec."Academic Year") { }
                field("Exam Type"; Rec."Exam Type") { }
                field("Exam Description"; Rec."Exam Description") { }
                field(Teacher; Rec.Teacher) { }
                field("Teacher Name"; Rec."Teacher Name") { }
                field(Subject; Rec.Subject) { }
                field("Subject Description"; Rec."Subject Description") { }
            }

            group(Marks)
            {
                field("Max Mark"; Rec."Max Mark") { }
                field("Pass Mark"; Rec."Pass Mark") { }
                field("Entry Completed"; Rec."Entry Completed") { }
            }

            group(System)
            {
                field("No. Series"; Rec."No. Series") { Editable = false; }
                field("Created Date"; Rec."Created Date") { Editable = false; }
                field("Portal ID"; Rec."Portal ID") { }
            }
            part(Lines; "Marks Line Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              Class = FIELD(Class),
                              Section = FIELD(Section),
                              Curriculum = FIELD(Curriculum),
                              "Academic Year" = FIELD("Academic Year"),
                              Subject = FIELD(Subject),
                              "Exam Type" = FIELD("Exam Type");
            }
        }
    }
}