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
                field("Selection No."; Rec."Selection No.") { }
                field(Class; Rec.Class) { }
                field(Curriculum; Rec.Curriculum) { }
                field("Academic Year"; Rec."Academic Year") { }
                field("Interview Date"; Rec."Interview Date") { }
                field("Seats Vacant"; Rec."Seats Vacant") { }
                field("Total Selected"; Rec."Total Selected") { }
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