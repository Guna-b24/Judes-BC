page 70142 "Departments Card"
{
    Caption = 'Department Card';
    PageType = Card;
    SourceTable = Departments;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }

            group("Employee Statistics")
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