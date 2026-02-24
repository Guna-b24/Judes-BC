page 72091 "Insurance Header Card"
{
    PageType = Card;
    SourceTable = "Insurance Header";
    ApplicationArea = All;
    Caption = 'Insurance Header';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Pay Element Code"; Rec."Pay Element Code")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
            }

            group(Statistics)
            {
                field("No. of Policy"; Rec."No. of Policy")
                {
                    ApplicationArea = All;
                }
                field("Total Premium Amount"; Rec."Total Premium Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Value Insured"; Rec."Total Value Insured")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Insurance Line Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No." = FIELD("Employee No."),
                                "Pay Element Code" = FIELD("Pay Element Code"),
                                "Location Code" = FIELD("Location Code"),
                                "Salary Plan Code" = FIELD("Salary Plan Code");
            }
        }
    }
}