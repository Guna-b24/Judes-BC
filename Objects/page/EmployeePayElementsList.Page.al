page 72079 "Employee Pay Elements List"
{
    PageType = List;
    SourceTable = "Employee Pay Elements";
    ApplicationArea = All;
    Caption = 'Employee Pay Elements';
    Editable = true;
    UsageCategory = Lists;
    CardPageId = "Employee Pay Elements Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Employee No"; Rec."Employee No") { }
                field("Effective Date"; Rec."Effective Date") { }
                field("Pay Element Code"; Rec."Pay Element Code") { }
                field(Description; Rec.Description) { }
                field(Amount; Rec.Amount) { }
                field("Percent (%)"; Rec."Percent (%)") { }
                field("Pay Type"; Rec."Pay Type") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}