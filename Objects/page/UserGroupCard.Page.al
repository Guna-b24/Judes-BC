page 71227 "User Group Card"
{
    Caption = 'User Group Card';
    PageType = Card;
    SourceTable = "User Groups";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("User Group"; Rec."User Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for the user group.';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the user group.';
                }

                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Business Central user assigned to this user group.';
                }

                field("Windows Login"; Rec."Windows Login")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Windows login associated with the user group.';
                }

                field(SID; Rec.SID)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the security identifier (SID) associated with the user or group.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Company)
            {
                Caption = 'Company';
                ApplicationArea = All;
                Image = Company;
                ToolTip = 'Opens the company assignment page for this user group.';

                RunObject = Page "User Group Company List";
                RunPageLink = "User Group" = field("User Group");
            }
        }
    }
}