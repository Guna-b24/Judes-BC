page 71052 "Selection Process List"
{
    PageType = List;
    SourceTable = "Selection process";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Selection Process Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Selection No."; Rec."Selection No.")
                {
                    ToolTip = 'Specifies the unique number assigned to the selection process.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;

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
        }
    }
}