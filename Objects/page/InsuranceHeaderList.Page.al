page 72090 "Insurance Header List"
{
    PageType = List;
    SourceTable = "Insurance Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Insurance Header';
    CardPageId = "Insurance Header Card";

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}