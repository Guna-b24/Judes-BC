page 72080 "Employee Leave Attachment"
{
    Caption = 'Employee Leaves';
    PageType = ListPart;
    SourceTable = "Employee Leave Attachment";
    ApplicationArea = All;

    layout
    {
        area(Content)
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

                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}