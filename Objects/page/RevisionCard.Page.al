page 72130 "Revision Card"
{
    PageType = Document;
    SourceTable = "Revision Header";
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Pay Revision';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Pay Revision Id"; Rec."Pay Revision Id")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                }
                field("Pay Revision Processing Date"; Rec."Pay Revision Processing Date") { ApplicationArea = All; }
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("New Effective Date"; Rec."New Effective Date") { ApplicationArea = All; }
                field("Based on"; Rec."Based on") { ApplicationArea = All; }
                field("Revision Amount"; Rec."Revision Amount") { ApplicationArea = All; }
                field("Revision Percent"; Rec."Revision Percent") { ApplicationArea = All; }
            }

            part(Lines; "Revision Subform")
            {
                SubPageLink = "Pay Revision Id" = FIELD("Pay Revision Id");
                ApplicationArea = All;
            }
        }
    }
}