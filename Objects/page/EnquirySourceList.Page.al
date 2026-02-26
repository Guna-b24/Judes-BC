page 70884 "Enquiry Source List"
{
    PageType = List;
    SourceTable = "Enquiry Source";
    ApplicationArea = All;
    Caption = 'Enquiry Source List';
    Editable = true;
    UsageCategory = Lists;
    CardPageId = "Enquiry Source Card";

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