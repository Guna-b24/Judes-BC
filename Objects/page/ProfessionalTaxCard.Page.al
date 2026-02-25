page 72286 "Professional Tax Card"
{
    PageType = Document;
    SourceTable = "Professional Tax Header";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Professional Tax Setup';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Effective Date"; Rec."Effective Date") { ApplicationArea = All; }
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Branch Code"; Rec."Branch Code") { ApplicationArea = All; }
                field("Branch Name"; Rec."Branch Name") { ApplicationArea = All; }
                field("Calculation Type"; Rec."Calculation Type") { ApplicationArea = All; }
                field("Salary Starting Date"; Rec."Salary Starting Date") { ApplicationArea = All; }
                field("Salary Ending Date"; Rec."Salary Ending Date") { ApplicationArea = All; }
            }

            part(Lines; "Professional Tax Subform")
            {
                SubPageLink =
                    "Effective Date" = field("Effective Date"),
                    "Location Code" = field("Location Code"),
                    "Salary Plan Code" = field("Salary Plan Code"),
                    "Branch Code" = field("Branch Code");
            }
        }
    }
}