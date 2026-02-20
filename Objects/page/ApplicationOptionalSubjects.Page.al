page 70030 "Application Optional Subjects"
{
    PageType = List;
    SourceTable = "Application Optional Subjects";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Application Optional Subjects';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Subject Group"; Rec."Subject Group")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

    actions
    {
        area(Processing)
        {
            action(ViewCard)
            {
                Caption = 'View';
                ApplicationArea = All;
                ToolTip = 'Can View the card';
                Image = View;

                trigger OnAction()
                begin
                    Page.Run(Page::"Application Optional Card", Rec);
                end;
            }
        }
    }
}
