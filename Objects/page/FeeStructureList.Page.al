page 50010 "Fee Structure List"
{
    PageType = List;
    SourceTable = "Fee Structure";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Fee Structure Card";

    layout
    {
        area(content)
        {
            repeater(Groups)
            {
                field("Academic Year"; rec."Academic Year") { ApplicationArea = All; }
                field("From Class"; rec."From Class") { ApplicationArea = All; }
                field("To Class"; rec."To Class") { ApplicationArea = All; }
                field("Fee Code"; rec."Fee Code") { ApplicationArea = All; }
                field("Fee Description"; rec."Fee Description") { ApplicationArea = All; }
                field(Amount; rec.Amount) { ApplicationArea = All; }
                field("Type Of Fees"; rec."Type Of Fees") { ApplicationArea = All; }
                field(Company; rec.Company) { ApplicationArea = All; }
                field("Group"; rec."Group") { ApplicationArea = All; }
                field(Thai; rec.Thai) { ApplicationArea = All; }
                field("Staff Child"; rec."Staff Child") { ApplicationArea = All; }
            }
        }
    }
}
