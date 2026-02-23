page 71002 "Enquiry List"
{
    PageType = List;
    SourceTable = Enquiry;
    ApplicationArea = All;
    Caption = 'Enquiry List';
    Editable = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { }
                field(Name; Rec.Name) { }
                field("Enquiry Date"; Rec."Enquiry Date") { }
                field("Class Applied"; Rec."Class Applied") { }
                field("Academic Year"; Rec."Academic Year") { }
                field("Enquiry Gender"; Rec."Enquiry Gender") { }
                field("Enquirer Name"; Rec."Enquirer Name") { }
                field(City; Rec.City) { }
                field("Mobile Number"; Rec."Mobile Number") { }
                field("E-Mail Address"; Rec."E-Mail Address") { }
                field("Enquiry Closed"; Rec."Enquiry Closed") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}