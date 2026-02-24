page 72093 "Insurance Line List"
{
    PageType = List;
    SourceTable = "Insurance Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Insurance Lines';

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
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Pay Element Code"; Rec."Pay Element Code")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }
                field("Policy No."; Rec."Policy No.")
                {
                    ApplicationArea = All;
                }
                field("Policy Date"; Rec."Policy Date")
                {
                    ApplicationArea = All;
                }
                field("Premium Amount"; Rec."Premium Amount")
                {
                    ApplicationArea = All;
                }
                field("Insured Amount"; Rec."Insured Amount")
                {
                    ApplicationArea = All;
                }
                field("Matured Date"; Rec."Matured Date")
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