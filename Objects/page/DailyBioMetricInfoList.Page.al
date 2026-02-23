page 71037 "Daily BioMetric Info List"
{
    Caption = 'Daily BioMetric Info';
    PageType = List;
    SourceTable = "Daily BioMetric Info";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(StaffId; Rec.StaffId)
                {
                    ApplicationArea = All;
                }
                field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = All;
                }
                field("Attendance Time"; Rec."Attendance Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}