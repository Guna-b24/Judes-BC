table 72068 "Income Tax Line"
{
    Caption = 'Income Tax Line';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Assessment Year"; Code[20])
        {
            Caption = 'Assessment Year';
            ToolTip = 'Specifies the assessment year for which the income tax slab is defined.';
            DataClassification = CustomerContent;
        }

        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the location for which the income tax slab applies.';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
        }

        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            ToolTip = 'Specifies the salary plan applicable for this income tax slab.';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }

        field(4; Gender; Option)
        {
            Caption = 'Gender';
            ToolTip = 'Specifies the gender category applicable for the income tax slab.';
            OptionMembers = Male,Female,"Sr.Citizen";
            OptionCaption = 'Male,Female,Senior Citizen';
            DataClassification = CustomerContent;
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the line number of the income tax slab.';
            DataClassification = SystemMetadata;
        }

        field(6; "Income From"; Decimal)
        {
            Caption = 'Income From';
            ToolTip = 'Specifies the starting income amount for this tax slab.';
            DataClassification = CustomerContent;
        }

        field(7; "Income To"; Decimal)
        {
            Caption = 'Income To';
            ToolTip = 'Specifies the ending income amount for this tax slab.';
            DataClassification = CustomerContent;
        }

        field(8; "Tax %"; Decimal)
        {
            Caption = 'Tax %';
            ToolTip = 'Specifies the percentage of income tax applicable for this slab.';
            MinValue = 0;
            MaxValue = 100;
            DataClassification = CustomerContent;
        }
        field(9; "Surcharge %"; Decimal)
        {
            Caption = 'Surcharge %';
            ToolTip = 'Specifies the surcharge percentage applicable on the income tax.';
            MinValue = 0;
            MaxValue = 100;
            DataClassification = CustomerContent;
        }

        field(10; "E-CESS %"; Decimal)
        {
            Caption = 'E-CESS %';
            ToolTip = 'Specifies the education cess percentage applicable on the tax.';
            MinValue = 0;
            MaxValue = 100;
            DataClassification = CustomerContent;
        }

        field(11; "SHE-CESS %"; Decimal)
        {
            Caption = 'SHE-CESS %';
            ToolTip = 'Specifies the secondary and higher education cess percentage applicable on the tax.';
            MinValue = 0;
            MaxValue = 100;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Assessment Year", "Location Code", "Salary Plan Code", Gender, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

