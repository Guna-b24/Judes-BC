page 71885 "Enquiry Type List"
{
    PageType = List;
    SourceTable = "Enquiry Type";
    ApplicationArea = All;
    Caption = 'Enquiry Type List';
    Editable = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { }
                field(Description; Rec.Description) { }
                field("Portal ID"; Rec."Portal ID") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}