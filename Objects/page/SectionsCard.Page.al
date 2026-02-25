page 72040 "Sections Card"
{
    PageType = Card;
    SourceTable = Sections;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Sections';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }

            group(Statistics)
            {
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