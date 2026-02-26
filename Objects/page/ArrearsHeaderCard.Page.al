page 70036 "Arrears Header Card"
{
    PageType = Document;
    SourceTable = "Arrears Header";
    ApplicationArea = All;
    Caption = 'Arrears Card';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Arrears Id"; Rec."Arrears Id")
                {
                    ApplicationArea = All;
                }
                field("Arrears Process Date"; Rec."Arrears Process Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Pay Revision Id"; Rec."Pay Revision Id")
                {
                    ApplicationArea = All;
                }
            }
            part(ArrearsLines; "Arrears Header Line SubPage")
            {
                ApplicationArea = All;
                SubPageLink = "Arrears Id" = field("Arrears Id"),
                  "Location Code" = field("Location Code"),
                  "Salary Plan Code" = field("Salary Plan Code");
            }
        }

    }
}
