page 72172 "Class Syllabus Line List"
{
    PageType = List;
    SourceTable = "Class Syllabus Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Class Syllabus Lines';
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
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
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                }
                field("Chapter Code"; Rec."Chapter Code")
                {
                    ApplicationArea = All;
                }
                field("Chapter Name"; Rec."Chapter Name")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("No of Hours"; Rec."No of Hours")
                {
                    ApplicationArea = All;
                }
                field("Teaching Aids"; Rec."Teaching Aids")
                {
                    ApplicationArea = All;
                }
                field(Aim; Rec.Aim)
                {
                    ApplicationArea = All;
                }
                field(Explaination; Rec.Explaination)
                {
                    ApplicationArea = All;
                }
                field(Assignment; Rec.Assignment)
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

    actions
    {
        area(processing)
        {
        }
    }
}