page 72094 "Medical Reimbu. Card"
{
    PageType = Card;
    SourceTable = "Medical Reimbu. Header";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Pay Element Code"; Rec."Pay Element Code") { }
                field("Employee No."; Rec."Employee No.") { }
                field(Name; Rec.Name) { }
            }

            part(Lines; "Medical Reimbu. Line Subform")
            {
                SubPageLink =
                        "Employee No." = FIELD("Employee No."),
                        "Pay Element Code" = FIELD("Pay Element Code"),
                        "Location Code" = FIELD("Location Code"),
                        "Salary Plan Code" = FIELD("Salary Plan Code");
            }
        }
    }
}