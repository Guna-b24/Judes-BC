table 72064 "PF Setup"
{

    Caption = 'PF Setup';
    DataClassification = CustomerContent;
    DataCaptionFields = "Effective Date", "Location Code", "Salary Plan Code", "PF Gross Salary Limit";
    // DrillDownPageID = 72083;
    LookupPageID = "PF Setup";

    fields
    {
        field(1; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date from which this PF setup becomes effective.';
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the location for which this PF setup applies.';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary plan for which this PF setup applies.';
            TableRelation = "Salary Plan";
        }
        field(4; "PF Gross Salary Limit"; Decimal)
        {
            Caption = 'PF Gross Salary Limit';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the maximum gross salary amount eligible for PF calculation.';
        }
        field(5; "EPS Gross Salary Limit"; Decimal)
        {
            Caption = 'EPS Gross Salary Limit';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the maximum gross salary amount eligible for EPS calculation.';
        }
        field(6; "Employee PF (Employee) %"; Decimal)
        {
            Caption = 'Employee PF (Employee) %';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF contribution percentage deducted from the employee.';
        }
        field(7; "Employer PF (Company) %"; Decimal)
        {
            Caption = 'Employer PF (Company) %';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF contribution percentage contributed by the employer.';
        }
        field(8; "Employer EPS (Company) %"; Decimal)
        {
            Caption = 'Employer EPS (Company) %';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the EPS contribution percentage contributed by the employer.';
        }
        field(9; "Employee VPF (Employee) %"; Decimal)
        {
            Caption = 'Employee VPF (Employee) %';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the voluntary PF percentage contributed by the employee.';
        }
        field(10; "PF Admin Charges %"; Decimal)
        {
            Caption = 'PF Admin Charges %';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the PF administrative charges percentage payable by the employer.';
        }
        field(11; "PF EDLI %"; Decimal)
        {
            Caption = 'PF EDLI %';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the EDLI contribution percentage under PF scheme.';
        }
        field(12; "PF RIFA %"; Decimal)
        {
            Caption = 'PF RIFA %';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the RIFA contribution percentage under PF scheme.';
        }
        field(13; "PF Rounding Amount"; Decimal)
        {
            Caption = 'PF Rounding Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the rounding precision used for PF calculation.';
        }
        field(14; "PF Rounding Type"; Option)
        {
            Caption = 'PF Rounding Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies how PF amounts are rounded during calculation.';
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
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

