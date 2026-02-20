page 70045 "Calendar List"
{
    PageType = List;
    SourceTable = Calendar;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Payroll Calendar';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }

                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }

                field("Calendar Year"; Rec."Calendar Year")
                {
                    ApplicationArea = All;
                }

                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Day No."; Rec."Day No.")
                {
                    ApplicationArea = All;
                }

                field("Week No."; Rec."Week No.")
                {
                    ApplicationArea = All;
                }

                field("Non-Working Days"; Rec."Non-Working Days")
                {
                    ApplicationArea = All;
                }

                field(Holiday; Rec.Holiday)
                {
                    ApplicationArea = All;
                }

                field("First Half (Holiday)"; Rec."First Half (Holiday)")
                {
                    ApplicationArea = All;
                }

                field("Second Half (Holiday)"; Rec."Second Half (Holiday)")
                {
                    ApplicationArea = All;
                }

                field(WeeklyOff; Rec.WeeklyOff)
                {
                    ApplicationArea = All;
                }

                field("First Half (Weekly Off)"; Rec."First Half (Weekly Off)")
                {
                    ApplicationArea = All;
                }

                field("Second Half (Weekly Off)"; Rec."Second Half (Weekly Off)")
                {
                    ApplicationArea = All;
                }

                field("OT Applicable for the Day"; Rec."OT Applicable for the Day")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
