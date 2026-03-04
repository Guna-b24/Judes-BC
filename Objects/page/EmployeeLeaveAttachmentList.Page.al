page 72080 "Employee Leave Attachment List"
{
    PageType = List;
    SourceTable = "Employee Leave Attachment";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Employee Leave Attachments';
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
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

    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Attach Leave Code")
    //         {
    //             ApplicationArea = All;
    //             Image = Attach;
    //             ToolTip = 'Run the Employee Leave Attachments report for the selected record.';

    //             RunObject = Report "Employee Leave Attachments";
    //             RunPageLink = "Employee No" = field("Employee No");
    //         }
    //     }
    // }
}