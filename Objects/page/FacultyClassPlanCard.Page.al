page 71072 "Faculty Class Plan Card"
{
    PageType = Document;
    SourceTable = "Faculty Class Plan Header";
    ApplicationArea = All;
    Editable = true;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Faculty Class Plan Number.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;

                }
                field("No.Series"; Rec."No.Series")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the number series used to assign plan numbers.';
                }
                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the class.';
                }
                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the class associated with the plan.';
                }
                field(Curriculum; Rec.Curriculum)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the curriculum for the class.';
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the subject assigned to the plan.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the academic year for the plan.';
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the faculty assigned to the class plan.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department responsible for the class plan.';
                }
                field("Plan Status"; Rec."Plan Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the class plan.';
                }
                field("Total Week Hours"; Rec."Total Week Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total number of hours planned per week.';
                }
                field("Perc Completed"; Rec."Perc Completed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the percentage of the plan that has been completed.';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional comments or notes related to the plan.';
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the section of the class.';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the portal identifier linked to the class plan.';
                }
            }
            part(Lines; "Faculty Class Plan Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Apply)
            {
                Caption = 'Apply';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Applies the faculty plan for the current record.';

                trigger OnAction()
                begin
                    SchemeOfWork.ApplyFacultyPlan(Rec."No.");
                end;
            }
            action(Approve)
            {
                Caption = 'A&pprove';
                ApplicationArea = All;
                Image = Approve;
                ToolTip = 'Approves the faculty plan for the current record.';

                trigger OnAction()
                begin
                    SchemeOfWork.ApproveFacultyPlan(Rec."No.");
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Reject;
                ToolTip = 'Rejects the faculty plan for the current record.';

                trigger OnAction()
                begin
                    SchemeOfWork.RejectFacultyPlan(Rec."No.");
                end;
            }
        }
    }
    var
        SchemeOfWork: Codeunit "Scheme Of Work";
}