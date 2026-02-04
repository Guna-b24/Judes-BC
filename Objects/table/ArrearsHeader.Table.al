table 72093 "Arrears Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Arrears Header';
    // DrillDownPageID = 72141;
    // LookupPageID = 72141;

    fields
    {
        field(1; "Arrears Id"; Code[20])
        {
            Caption = 'Arrears Id';
        }
        field(2; "Arrears Process Date"; Date)
        {
            Caption = 'Arrears Process Date';
            Editable = false;
        }
        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = "Location HR & Payroll Setup";
        }
        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            Editable = false;
            TableRelation = "Salary Plan";
        }
        field(5; "Pay Revision Id"; Code[20])
        {
            Caption = 'Pay Revision Id';
            Editable = false;
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
            ArrearsLine.Reset;
            ArrearsLine.SetRange("Arrears Id", "Arrears Id");
            if ArrearsLine.FindFirst then begin
                ArrearsLine.LockTable;
                ArrearsLine.DeleteAll;
            end;
        end;
    end;

    var
        ArrearsLine: Record "Arrears Line";
}

