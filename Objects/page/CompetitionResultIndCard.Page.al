page 71085 "Competition Result Ind Card"
{
    PageType = Card;
    SourceTable = "Competition Result Individual";
    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'Competition Result Individual';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                }

                field("Competition Entry No."; Rec."Competition Entry No.")
                {
                    ApplicationArea = All;
                }

                field("Competition Name"; Rec."Competition Name")
                {
                    ApplicationArea = All;
                }

                field("Competition Type"; Rec."Competition Type")
                {
                    ApplicationArea = All;
                }

                field("Event Type"; Rec."Event Type")
                {
                    ApplicationArea = All;
                }

                field("Student Division"; Rec."Student Division")
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field("Competition Date"; Rec."Competition Date")
                {
                    ApplicationArea = All;
                }

                field("Competition Status"; Rec."Competition Status")
                {
                    ApplicationArea = All;
                }

                field("Update Results"; Rec."Update Results")
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
        area(Processing)
        {
            action(GetStudents)
            {
                Caption = 'Get Students';
                ApplicationArea = All;
                Image = GetSourceDoc;
                ToolTip = 'Fetches students for this competition result.';

                trigger OnAction()
                var
                    CoCurricularMgt: Codeunit "Co-Curricular";
                begin
                    CoCurricularMgt.GetStudentsIndividual(Rec."No.");
                end;
            }
            action(UpdatePoints)
            {
                Caption = 'Update Points';
                ApplicationArea = All;
                Image = Calculate;
                ToolTip = 'Checks positions and updates points for students.';

                trigger OnAction()
                var
                    CoCurricularMgt: Codeunit "Co-Curricular";
                begin
                    CoCurricularMgt.UpdatePointsIndividual(Rec."No.", true);
                end;
            }
        }
    }
}