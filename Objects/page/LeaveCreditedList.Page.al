page 72117 "Leave Credited List"
{
    PageType = List;
    SourceTable = "Leave Credited";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Leave Credited';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                }
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    ApplicationArea = All;
                }
                field("Leave End Date"; Rec."Leave End Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Leaves"; Rec."No. of Leaves")
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
                field("Leave Year Code"; Rec."Leave Year Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}