page 71041 "Departments List"
{
    Caption = 'Departments';
    PageType = List;
    SourceTable = Departments;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Departments Card";

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