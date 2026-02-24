page 50011 "Fee Structure Card"
{
    PageType = Card;
    SourceTable = "Fee Structure";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group("General Information")
            {
                field("Academic Year"; rec."Academic Year") { ApplicationArea = All; }
                field("From Class"; rec."From Class") { ApplicationArea = All; }
                field("To Class"; rec."To Class") { ApplicationArea = All; }
                field(Company; rec.Company) { ApplicationArea = All; }
            }

            group("Fee Details")
            {
                field("Fee Code"; rec."Fee Code") { ApplicationArea = All; }
                field("Fee Description"; rec."Fee Description") { ApplicationArea = All; }
                field("Type Of Fees"; rec."Type Of Fees") { ApplicationArea = All; }
                field(Amount; rec.Amount) { ApplicationArea = All; }
                field("G/L Account"; rec."G/L Account") { ApplicationArea = All; }
            }

            group("Student Category")
            {
                field(Group; rec.Group) { ApplicationArea = All; }
                field(Thai; rec.Thai) { ApplicationArea = All; }
                field("Staff Child"; rec."Staff Child") { ApplicationArea = All; }
                field("Group Subject"; rec."Group Subject") { ApplicationArea = All; }
                field("Caution Depoit Select"; rec."Caution Depoit Select") { ApplicationArea = All; }
            }
        }
    }
}
