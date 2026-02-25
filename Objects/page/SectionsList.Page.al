page 72041 "Sections List"
{
    PageType = List;
    SourceTable = Sections;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Sections Card";
    Caption = 'Sections';

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Active Employees"; Rec."Active Employees")
                {
                    ApplicationArea = All;
                }
                field("Inactive Employees"; Rec."Inactive Employees")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}