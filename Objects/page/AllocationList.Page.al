page 70014 "Allocation List"
{
    PageType = List;
    SourceTable = Allocation;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Allocations';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                }

                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }

                field("Type Of Payment"; Rec."Type Of Payment")
                {
                    ApplicationArea = All;
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }

                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
