tableextension 50100 "CustLedgerEntryExt" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50100; "Fee Code"; Code[20])
        {
            Caption = 'Fee Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fee code related to this customer ledger entry.';
        }

        field(50101; "Section"; Code[20])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the section associated with this ledger entry.';
        }

        field(50102; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year related to this ledger entry.';
        }
        field(50103; "Class"; Code[20])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Class associated with this ledger entry.';
        }
    }
}
