page 71884 "Education Setup"
{
    Caption = 'Education Setup';
    PageType = Card;
    SourceTable = "Education Setup";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }

                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }

            group("Number Series")
            {
                field("Rank Generation No."; Rec."Rank Generation No.")
                {
                    ApplicationArea = All;
                }

                field("Task No."; Rec."Task No.")
                {
                    ApplicationArea = All;
                }

                field("Announcement No."; Rec."Announcement No.")
                {
                    ApplicationArea = All;
                }

                field("Assignment No."; Rec."Assignment No.")
                {
                    ApplicationArea = All;
                }
            }

            group("Promotion")
            {
                field("Admission Posting Date"; Rec."Admission Posting Date")
                {
                    ApplicationArea = All;
                }

                field("Promotion Academic Year"; Rec."Promotion Academic Year")
                {
                    ApplicationArea = All;
                }
            }

            group("Integration")
            {
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }

                field("Image File Path"; Rec."Image File Path")
                {
                    ApplicationArea = All;
                }

                field("XML File Path"; Rec."XML File Path")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Primary Key" := 'SETUP';
            Rec.Insert();
        end;
    end;
}