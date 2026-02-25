page 70231 "Portal User Card"
{
    PageType = Card;
    SourceTable = "Portal Users";
    ApplicationArea = All;
    Caption = 'Portal User';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Login ID"; Rec."Login ID") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("User Groups"; Rec."User Groups") { ApplicationArea = All; }
                field(Password; Rec.Password) { ApplicationArea = All; }
                field(PwdReset; Rec.PwdReset) { ApplicationArea = All; }
            }
        }
    }
}