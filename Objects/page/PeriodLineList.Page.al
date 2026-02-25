page 70228 "Period Line List"
{
    PageType = List;
    SourceTable = "Period Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Period Line List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }

                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }

                field("Period Time"; Rec."Period Time")
                {
                    ApplicationArea = All;
                }

                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }

                field("Interval Check"; Rec."Interval Check")
                {
                    ApplicationArea = All;
                }

                field("Lab Start Hour"; Rec."Lab Start Hour")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}