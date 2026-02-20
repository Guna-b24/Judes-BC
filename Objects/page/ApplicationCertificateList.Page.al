page 70021 "Application Certificate List"
{
    PageType = List;
    SourceTable = "Application Certificate";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Application Certificates';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }

                field("Certificate"; Rec."Certificate")
                {
                    ApplicationArea = All;
                }

                field("Certificate Status"; Rec."Certificate Status")
                {
                    ApplicationArea = All;
                }

                field("Receipt Date / Submission Date"; Rec."Receipt Date / Submission Date")
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
}
