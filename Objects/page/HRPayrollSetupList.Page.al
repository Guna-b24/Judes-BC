page 70126 "HR & Payroll Setup List"
{
    PageType = List;
    SourceTable = "HR & Payroll Setup";
    ApplicationArea = All;
    Caption = 'HR & Payroll Setup';
    UsageCategory = Administration;
    CardPageId = "HR & Payroll Setup Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Cyclic Code"; Rec."Salary Cyclic Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Year Code"; Rec."Salary Year Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}