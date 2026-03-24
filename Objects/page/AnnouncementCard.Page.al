page 70017 "Announcement Card"
{
    PageType = Card;
    SourceTable = Announcement;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Announcement';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Announcement No."; Rec."Announcement No.")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;

                }

                field("Document Type"; Rec."Document Type") { ApplicationArea = All; }
                field("Announcement Type"; Rec."Announcement Type") { ApplicationArea = All; }
                field("No."; Rec."No.") { ApplicationArea = All; }

                field(Subject; Rec.Subject) { ApplicationArea = All; }
                field(Priority; Rec.Priority) { ApplicationArea = All; }

                field("Date Created"; Rec."Date Created") { ApplicationArea = All; }
                field("Start Date"; Rec."Start Date") { ApplicationArea = All; }
                field("End Date"; Rec."End Date") { ApplicationArea = All; }
            }

            group(Description)
            {
                field("Description-1"; Rec."Description-1") { ApplicationArea = All; MultiLine = true; }
                field("Description-2"; Rec."Description-2") { ApplicationArea = All; MultiLine = true; }
                field("Description-3"; Rec."Description-3") { ApplicationArea = All; MultiLine = true; }
            }

            group(Status)
            {
                field(Closed; Rec.Closed) { ApplicationArea = All; }
                field("Date Closed"; Rec."Date Closed") { ApplicationArea = All; }
                field(Canceled; Rec.Canceled) { ApplicationArea = All; }
            }

            group(System)
            {
                field("No. Series"; Rec."No. Series") { ApplicationArea = All; Editable = false; }
                field("User ID"; Rec."User ID") { ApplicationArea = All; Editable = false; }
                field("Portal ID"; Rec."Portal ID") { ApplicationArea = All; }
            }
        }
    }
}
