table 72063 "ESI Setup"
{
    Caption = 'ESI Setup';
    DataCaptionFields = "Effective Date", "Location Code", "Salary Plan Code";
    DataClassification = CustomerContent;
    // DrillDownPageID = 72081;
    // LookupPageID = 72081;

    fields
    {
        field(1; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = "Location HR & Payroll Setup";
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
            TableRelation = "Salary Plan";
        }
        field(4; "ESI Gross Salary Amount"; Decimal)
        {
            Caption = 'ESI Gross Salary Amount';
            ToolTip = 'Specifies the maximum gross salary amount applicable for ESI calculation.';
            DataClassification = CustomerContent;
        }
        field(5; "ESI % ( Employee )"; Decimal)
        {
            Caption = 'ESI % ( Employee )';
            ToolTip = 'Specifies the ESI contribution percentage deducted from the employee salary.';
            DataClassification = CustomerContent;
        }
        field(6; "ESI % ( Company )"; Decimal)
        {
            Caption = 'ESI % ( Company )';
            ToolTip = 'Specifies the ESI contribution percentage paid by the company.';
            DataClassification = CustomerContent;
        }
        field(7; "ESI Rounding Amount"; Decimal)
        {
            Caption = 'ESI Rounding Amount';
            ToolTip = 'Specifies the rounding value applied to ESI calculation.';
            DataClassification = CustomerContent;
        }
        field(8; "ESI Rounding Type"; Option)
        {
            Caption = 'ESI Rounding Type';
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
            ToolTip = 'Specifies how the ESI amount should be rounded.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Effective Date", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

