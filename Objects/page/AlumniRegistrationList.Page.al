page 70016 "Alumni Registration List"
{
    PageType = List;
    SourceTable = "Alumni Registration";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Alumni Registration Card";
    Caption = 'Alumni Registrations';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Year Of Graduation"; Rec."Year Of Graduation") { ApplicationArea = All; }
                field("Present Occupation"; Rec."Present Occupation") { ApplicationArea = All; }
                field("Mobile Number"; Rec."Mobile Number") { ApplicationArea = All; }
                field("E-mail"; Rec."E-mail") { ApplicationArea = All; }
                field(IsRegistered; Rec.IsRegistered) { ApplicationArea = All; }
            }
        }
    }
}
