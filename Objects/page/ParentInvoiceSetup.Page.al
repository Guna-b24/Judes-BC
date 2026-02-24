page 60009 "Parent Invoice Setup"
{
    PageType = List;
    SourceTable = ParentInvoiceSetup;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(StartDate; Rec.StartDate) { }
                field(EndDate; Rec.EndDate) { }
                field(Amount; Rec.Amount) { }
                field(IsGreaterThan; Rec.IsGreaterThan) { }
            }
        }
    }
}