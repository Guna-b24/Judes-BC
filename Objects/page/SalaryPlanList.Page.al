page 72055 "Salary Plan List"
{
    PageType = List;
    SourceTable = "Salary Plan";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Salary Plan Card";
    Caption = 'Salary Plans';

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
                field("Date Interval"; Rec."Date Interval")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}