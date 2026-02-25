page 72089 "Performance Appraisal List"
{
    PageType = List;
    SourceTable = "Performance Appraisal";
    ApplicationArea = All;
    Caption = 'Performance Appraisal';
    UsageCategory = Administration;
    CardPageID = "Performance Appraisal Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
            }
        }
    }
}