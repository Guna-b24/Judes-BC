page 70230 "Portal Users List"
{
    PageType = List;
    SourceTable = "Portal Users";
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageID = "Portal User Card";
    Caption = 'Portal Users';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Login ID"; Rec."Login ID") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("User Groups"; Rec."User Groups") { ApplicationArea = All; }
                field(PwdReset; Rec.PwdReset) { ApplicationArea = All; }
            }
        }
    }
}