page 71039 "Department List"
{
    Caption = 'Departments';
    PageType = List;
    SourceTable = Department;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Department Card";

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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Head of the Department"; Rec."Head of the Department")
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}