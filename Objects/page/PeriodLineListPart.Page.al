page 70226 "Period Line ListPart"
{
    PageType = ListPart;
    SourceTable = "Period Line";
    ApplicationArea = All;
    Caption = 'Period Lines';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Period Time"; Rec."Period Time") { ApplicationArea = All; }
                field(Period; Rec.Period) { ApplicationArea = All; }
                field("Interval Check"; Rec."Interval Check") { ApplicationArea = All; }
                field("Lab Start Hour"; Rec."Lab Start Hour") { ApplicationArea = All; }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PeriodLine: Record "Period Line";
    begin
        Rec."Line No." := 0;

        PeriodLine.SetRange("Code", Rec."Code");

        if PeriodLine.FindLast() then
            Rec."Line No." := PeriodLine."Line No." + 10000
        else
            Rec."Line No." := 10000;
    end;
}