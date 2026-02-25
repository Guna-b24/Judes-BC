page 70227 "Period Header List"
{
    PageType = List;
    SourceTable = "Period Header";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Period Header List';
    CardPageID = "Period Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field("No.Of Periods/Day"; Rec."No.Of Periods/Day") { ApplicationArea = All; }
                field("Minutes/Period"; Rec."Minutes/Period") { ApplicationArea = All; }
            }
        }
    }
}