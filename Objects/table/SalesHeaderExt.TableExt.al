tableextension 50101 "SalesHeaderExt" extends "Sales Header"
{
    fields
    {
        field(50100; "Fee Code"; Code[20])
        {
            Caption = 'Fee Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fee code associated with this sales document.';
        }

        field(50101; "Section"; Code[20])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the section related to this sales document.';
        }

        field(50102; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year for this sales document.';
        }

        field(50103; "Class"; Code[20])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class associated with this sales document.';
        }
    }
}
