page 71171 "Class Syllabus List"
{
    PageType = List;
    SourceTable = "Class Syllabus Header";
    Caption = 'Class Syllabus';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Class Syllabus Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                }
                field(Curriculam; Rec.Curriculam)
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}