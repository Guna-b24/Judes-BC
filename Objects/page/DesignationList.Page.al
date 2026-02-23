page 70143 "Designation List"
{
    Caption = 'Designations';
    PageType = List;
    SourceTable = Designation;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Designation Card";

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