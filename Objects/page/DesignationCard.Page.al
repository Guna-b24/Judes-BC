page 70144 "Designation Card"
{
    Caption = 'Designation Card';
    PageType = Card;
    SourceTable = Designation;
    ApplicationArea = All;
    UsageCategory = Lists;

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

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Active Employees", "Inactive Employees");
    end;
}