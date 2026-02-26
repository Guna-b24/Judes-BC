table 72093 "Arrears Header"
{
    Caption = 'Arrears Header';
    // DrillDownPageID = 72141;
    LookupPageID = "Arrears Header List";

    fields
    {
        field(1; "Arrears Id"; Code[20])
        {
            Caption = 'Arrears Id';
            DataClassification = CustomerContent;

        }
        field(2; "Arrears Process Date"; Date)
        {
            Caption = 'Arrears Process Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
        }
        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            Editable = false;
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }
        field(5; "Pay Revision Id"; Code[20])
        {
            Caption = 'Pay Revision Id';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Arrears Id", "Arrears Process Date", "Location Code", "Salary Plan Code", "Pay Revision Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Confirm('Are Sure to Delete the Records <Yes/No> Delete All Lines..!!') then begin
            ArrearsLine.Reset();
            ArrearsLine.SetRange("Arrears Id", "Arrears Id");
            if ArrearsLine.FindFirst() then begin
                ArrearsLine.LockTable();
                ArrearsLine.DeleteAll();
            end;
        end;
    end;

    var
        ArrearsLine: Record "Arrears Line";
}

