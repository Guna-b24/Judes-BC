page 70018 "Announcement List"
{
    PageType = List;
    SourceTable = Announcement;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Announcement Card";
    Caption = 'Announcements';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Announcement No."; Rec."Announcement No.") { ApplicationArea = All; }
                field("Document Type"; Rec."Document Type") { ApplicationArea = All; }
                field("Announcement Type"; Rec."Announcement Type") { ApplicationArea = All; }
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Subject; Rec.Subject) { ApplicationArea = All; }
                field(Priority; Rec.Priority) { ApplicationArea = All; }
                field("Start Date"; Rec."Start Date") { ApplicationArea = All; }
                field("End Date"; Rec."End Date") { ApplicationArea = All; }
                field(Closed; Rec.Closed) { ApplicationArea = All; }
                field(Canceled; Rec.Canceled) { ApplicationArea = All; }
            }
        }
    }
}
