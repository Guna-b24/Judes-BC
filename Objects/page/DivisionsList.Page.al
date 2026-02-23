page 70145 "Divisions List"
{
    Caption = 'Divisions';
    PageType = List;
    SourceTable = Divisions;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Divisions Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
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