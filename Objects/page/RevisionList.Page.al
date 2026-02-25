page 72132 "Revision List"
{
    PageType = List;
    SourceTable = "Revision Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Revision Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Pay Revision Id"; Rec."Pay Revision Id") { ApplicationArea = All; }
                field("Pay Revision Processing Date"; Rec."Pay Revision Processing Date") { ApplicationArea = All; }
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("New Effective Date"; Rec."New Effective Date") { ApplicationArea = All; }
            }
        }
    }
}