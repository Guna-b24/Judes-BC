table 72077 "Payroll Employee Posting Group"
{
    Caption = 'Payroll Employee Posting Group';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Code", Description;
    // DrillDownPageID = 72106;
    // LookupPageID = 72106;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(3; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = "Payroll Business Posting Group";

            trigger OnValidate()
            begin
                if PayrollBusinessPostingGroup.Get(Code, "Location Code", "Salary Plan Code") then
                    Description := PayrollBusinessPostingGroup.Description;
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Salary Payable1 A/c"; Code[20])
        {
            Caption = 'Salary Payable1 A/c';
            TableRelation = "G/L Account";
        }
        field(6; "ESI Payable A/c"; Code[20])
        {
            Caption = 'ESI Payable A/c';
            TableRelation = "G/L Account";
        }
        field(7; "PF Payable A/c"; Code[20])
        {
            Caption = 'PF Payable A/c';
            TableRelation = "G/L Account";
        }
        field(8; "EPS Payable A/c"; Code[20])
        {
            Caption = 'EPS Payable A/c';
            TableRelation = "G/L Account";
        }
        field(9; "PF Admin Charge Payable A/c"; Code[20])
        {
            Caption = 'PF Admin Charge Payable A/c';
            TableRelation = "G/L Account";
        }
        field(10; "EDLI Payable A/c"; Code[20])
        {
            Caption = 'EDLI Payable A/c';
            TableRelation = "G/L Account";
        }
        field(11; "RIFA Payable A/c"; Code[20])
        {
            Caption = 'RIFA Payable A/c';
            TableRelation = "G/L Account";
        }
        field(12; "PT Payable A/c"; Code[20])
        {
            Caption = 'PT Payable A/c';
            TableRelation = "G/L Account";
        }
        field(13; "TDS Payable A/c"; Code[20])
        {
            Caption = 'TDS Payable A/c';
            TableRelation = "G/L Account";
        }
        field(14; "Bonus Payable A/c"; Code[20])
        {
            Caption = 'Bonus Payable A/c';
            TableRelation = "G/L Account";
        }
        field(15; "Arrear Salary Payable A/c"; Code[20])
        {
            Caption = 'Arrear Salary Payable A/c';
            TableRelation = "G/L Account";
        }
        field(16; "Loan Refundable A/c"; Code[20])
        {
            Caption = 'Loan Refundable A/c';
            TableRelation = "G/L Account";
        }
        field(17; "Salary Payable2 A/c"; Code[20])
        {
            Caption = 'Salary Payable2 A/c';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Code", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PayrollBusinessPostingGroup: Record "Payroll Business Posting Group";
}

