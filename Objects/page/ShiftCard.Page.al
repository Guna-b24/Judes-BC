page 72175 "Shift Card"
{
    PageType = Card;
    SourceTable = Shift;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Code"; Rec."Code") { }
                field(Description; Rec.Description) { }
            }

            group("First Half")
            {
                field("First Half Starting Time"; Rec."First Half Starting Time") { }
                field("First Half Ending Time"; Rec."First Half Ending Time") { }
                field("First Half Total Hours"; Rec."First Half Total Hours") { }
            }

            group("Second Half")
            {
                field("Second Half Starting Time"; Rec."Second Half Starting Time") { }
                field("Second Half Ending Time"; Rec."Second Half Ending Time") { }
                field("Second Half Total Hours"; Rec."Second Half Total Hours") { }
            }

            group("Break")
            {
                field("Break Start Time"; Rec."Break Start Time") { }
                field("Break End Time"; Rec."Break End Time") { }
                field("Break Total Hours"; Rec."Break Total Hours") { }
            }

            group("Overtime & Rules")
            {
                field("Morning OT Applicable"; Rec."Morning OT Applicable") { }
                field("Morning OT Starts From"; Rec."Morning OT Starts From") { }
                field("Evening OT Applicable"; Rec."Evening OT Applicable") { }
                field("Evening OT Starts From"; Rec."Evening OT Starts From") { }
            }
        }
    }
}