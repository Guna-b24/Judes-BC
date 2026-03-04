page 70025 Allocation
{
    ApplicationArea = All;
    Caption = 'Allocation';
    PageType = List;
    SourceTable = Allocation;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                }
                field("Type Of Payment"; Rec."Type Of Payment")
                {
                    ToolTip = 'Specifies the value of the Type Of Payment field.', Comment = '%';
                }
                field(Company; Rec.Company)
                {
                    ToolTip = 'Specifies the value of the Company field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            group(Account)
            {
                action(Card)
                {
                    ApplicationArea = All;
                    RunObject = Page "G/L Account Card";
                    Image = EditLines;
                    ToolTip = 'Open the G/L Account Card for the selected account.';
                }

                action("Ledger Entries")
                {
                    ApplicationArea = All;
                    RunObject = Page "General Ledger Entries";
                    Image = LedgerEntries;
                    ToolTip = 'View the general ledger entries for the selected account.';
                }
            }

            group(Line)
            {
                action(Dimensions)
                {
                    ApplicationArea = All;
                    RunObject = Page "Journal Line Dimension List";
                    Image = Dimensions;
                    ToolTip = 'View or edit dimensions for the selected journal line.';
                }
            }
        }
    }
}
