table 72077 "Payroll Employee Posting Group"
{
    Caption = 'Payroll Employee Posting Group';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Code", Description;
    DataClassification = ToBeClassified;
    // DrillDownPageID = 72106;
    // LookupPageID = 72106;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = ToBeClassified;
            ToolTip = 'Location to which this payroll employee posting group applies.';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = ToBeClassified;
            ToolTip = 'Salary plan associated with this payroll employee posting group.';
        }
        field(3; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = "Payroll Business Posting Group";
            DataClassification = ToBeClassified;
            ToolTip = 'Unique code for the payroll employee posting group.';
            trigger OnValidate()
            begin
                if PayrollBusinessPostingGroup.Get(Code, "Location Code", "Salary Plan Code") then
                    Description := PayrollBusinessPostingGroup.Description;
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            ToolTip = 'Description of the payroll employee posting group.';
        }
        field(5; "Salary Payable1 A/c"; Code[20])
        {
            Caption = 'Salary Payable1 A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
            ToolTip = 'G/L account for Salary Payable 1.';
        }
        field(6; "ESI Payable A/c"; Code[20])
        {
            Caption = 'ESI Payable A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(7; "PF Payable A/c"; Code[20])
        {
            Caption = 'PF Payable A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(8; "EPS Payable A/c"; Code[20])
        {
            Caption = 'EPS Payable A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(9; "PF Admin Charge Payable A/c"; Code[20])
        {
            Caption = 'PF Admin Charge Payable A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(10; "EDLI Payable A/c"; Code[20])
        {
            Caption = 'EDLI Payable A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(11; "RIFA Payable A/c"; Code[20])
        {
            Caption = 'RIFA Payable A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(12; "PT Payable A/c"; Code[20])
        {
            Caption = 'PT Payable A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(13; "TDS Payable A/c"; Code[20])
        {
            Caption = 'TDS Payable A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(14; "Bonus Payable A/c"; Code[20])
        {
            Caption = 'Bonus Payable A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(15; "Arrear Salary Payable A/c"; Code[20])
        {
            Caption = 'Arrear Salary Payable A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(16; "Loan Refundable A/c"; Code[20])
        {
            Caption = 'Loan Refundable A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(17; "Salary Payable2 A/c"; Code[20])
        {
            Caption = 'Salary Payable2 A/c';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
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

