page 71065 "Exam Schedule Head Card"
{
    PageType = Document;
    SourceTable = "Exam Schedule Head - SCH";
    ApplicationArea = All;
    Caption = 'Exam Schedule Head Card';
    Editable = true;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the unique number assigned to the exam schedule.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;

                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the date of the exam.';
                }
                field("Exam Code"; Rec."Exam Code")
                {
                    ToolTip = 'Specifies the code that identifies the exam.';
                }
                field("Exam Slot"; Rec."Exam Slot")
                {
                    ToolTip = 'Specifies the time slot assigned for the exam.';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the start time of the exam.';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the end time of the exam.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the academic year for the exam schedule.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the number series used to assign schedule numbers.';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ToolTip = 'Specifies the portal identifier linked to the exam schedule.';
                }
            }
            part(ExamScheduleLines; "Exam Schedule Line Part")
            {
                SubPageLink = "Document No." = field("No.");
            }

        }
    }

    actions
    {
        area(Navigation) { }
    }
}