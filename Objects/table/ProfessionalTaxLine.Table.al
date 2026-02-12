table 72066 "Professional Tax Line"
{
    Caption = 'Professional Tax Line';

    fields
    {
        field(1; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the effective date of the professional tax setup.';
        }

        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll location to which this professional tax line applies.';
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary plan associated with this professional tax line.';
        }
        field(4; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the branch for which this professional tax slab is defined.';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the line number of the professional tax slab.';
        }

        field(6; "Income From"; Decimal)
        {
            Caption = 'Income From';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the minimum income amount for this professional tax slab.';
        }

        field(7; "Income To"; Decimal)
        {
            Caption = 'Income To';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the maximum income amount for this professional tax slab.';
        }

        field(8; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the professional tax amount applicable for the defined income range.';
        }
    }

    keys
    {
        key(Key1; "Effective Date", "Location Code", "Salary Plan Code", "Branch Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

