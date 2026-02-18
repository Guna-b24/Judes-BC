tableextension 50000 "GenJournalLine Ext" extends "Gen. Journal Line"
{
    fields
    {
        field(50001; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cheque date for the journal line.';
        }

        field(50002; "Cheque No."; Code[50])
        {
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cheque number for the journal line.';
        }
        field(50003; "Class"; Code[10])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cheque number for the journal line.';
        }
        field(50004; "Section"; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cheque number for the journal line.';
        }
        field(50005; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cheque number for the journal line.';
        }
        field(50006; "Fee Code"; Code[10])
        {
            Caption = 'Fee Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cheque number for the journal line.';
        }
        field(50007; "Type of Fees"; Option)
        {
            Caption = 'Type Of Fees';
            OptionCaption = ' ,Initial,Term1,Term2';
            OptionMembers = " ",Initial,Term1,Term2;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fee type such as Initial or Term fees.';
        }
        field(50008; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Employee No.';
        }
    }
}
