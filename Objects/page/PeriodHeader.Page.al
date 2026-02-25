page 70225 "Period Header"
{
    PageType = Document;
    SourceTable = "Period Header";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Period Header';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field("Portal ID"; Rec."Portal ID") { ApplicationArea = All; }
            }

            group("Timing Details")
            {
                field("Starting time"; Rec."Starting time") { ApplicationArea = All; }
                field("End time"; Rec."End time") { ApplicationArea = All; }
                field("No.Of Periods/Day"; Rec."No.Of Periods/Day") { ApplicationArea = All; }
                field("Minutes/Period"; Rec."Minutes/Period") { ApplicationArea = All; }
                field("No.Of Periods/Half Day"; Rec."No.Of Periods/Half Day") { ApplicationArea = All; }
                field("Max Lab Hours/Day"; Rec."Max Lab Hours/Day") { ApplicationArea = All; }
            }

            group("Break Details")
            {
                field("Interval Start Time"; Rec."Interval Start Time") { ApplicationArea = All; }
                field("Interval End Time"; Rec."Interval End Time") { ApplicationArea = All; }
                field("Lunch Start Time"; Rec."Lunch Start Time") { ApplicationArea = All; }
                field("Lunch End Time"; Rec."Lunch End Time") { ApplicationArea = All; }
                field("Working Days Per Week"; Rec."Working Days Per Week") { ApplicationArea = All; }
            }

            part(PeriodLines; "Period Line ListPart")
            {
                ApplicationArea = All;
                SubPageLink = "Code" = field("Code");
            }
        }
    }
}