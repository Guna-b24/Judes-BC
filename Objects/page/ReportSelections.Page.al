page 71900 "Report Selections"
{
    PageType = List;
    SourceTable = "Report Selections1";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Report Selections';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Usage; Rec.Usage) { ApplicationArea = All; }
                field(Sequence; Rec.Sequence) { ApplicationArea = All; }
                field("Report ID"; Rec."Report ID") { ApplicationArea = All; }
                field("Report Name"; Rec."Report Name") { ApplicationArea = All; }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.NewRecord();
    end;
}