page 60001 "Menu List"
{
    PageType = List;
    SourceTable = Menu;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date) { }
                field(Campus; Rec.Campus) { }
                field("Food Time"; Rec."Food Time") { }
                field(Menu; Rec.Menu) { }
            }
        }
    }
}