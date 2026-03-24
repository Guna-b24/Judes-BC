page 71050 "Selection Process Card"
{
    PageType = Card;
    SourceTable = "Selection process";
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Selection No."; Rec."Selection No.")
                {
                    ToolTip = 'Specifies the unique number assigned to the selection process.';
                }
                field(Class; Rec.Class)
                {
                    ToolTip = 'Specifies the class for which the selection is conducted.';
                }
                field(Curriculum; Rec.Curriculum)
                {
                    ToolTip = 'Specifies the curriculum associated with the selection process.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the academic year for the selection process.';
                }
                field("Interview Date"; Rec."Interview Date")
                {
                    ToolTip = 'Specifies the date on which the interview is scheduled.';
                }
                field("Seats Vacant"; Rec."Seats Vacant")
                {
                    ToolTip = 'Specifies the number of available seats.';
                }
                field("Total Selected"; Rec."Total Selected")
                {
                    ToolTip = 'Specifies the total number of candidates selected.';
                }
            }

            part(Lines; "Selection Process Subpage")
            {
                SubPageLink = "Selection No." = FIELD("Selection No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("&Get Applicants")
            {
                ApplicationArea = All;
                Caption = 'Get Applicants';
                ToolTip = 'Fetches all applicants for the selected selection number.';
                Image = New;
                trigger OnAction()
                begin
                    Evaluate."Selection Process"(Rec."Selection No.");
                end;
            }

            action("&Update Status")
            {
                ApplicationArea = All;
                Caption = 'Update Status';
                ToolTip = 'Updates the status of the selection process for the selected selection number.';
                Image = Edit;
                trigger OnAction()
                begin
                    Evaluate.UpdateStatus(Rec."Selection No.");
                end;
            }
        }
    }
    var
        Evaluate: Codeunit Evaluation;

}