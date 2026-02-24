page 72092 "Insurance Line Subpage"
{
    PageType = ListPart;
    SourceTable = "Insurance Line";
    ApplicationArea = All;
    Caption = 'Insurance Lines';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field(Description; Rec.Description)
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