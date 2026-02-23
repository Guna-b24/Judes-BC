page 71172 "Class Syllabus Card"
{
    PageType = Card;
    SourceTable = "Class Syllabus Header";
    Caption = 'Class Syllabus';
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
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
                part(SyllabusLines; "Class Syllabus Subpage")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No." = field("No.");
                }
            }

            group(Numbering)
            {
                field("No.Series"; Rec."No.Series")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}