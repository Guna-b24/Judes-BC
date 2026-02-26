table 72094 "Arrears Line"
{
    Caption = 'Arrears Line';
    DataClassification = CustomerContent;
    // DrillDownPageID = 72136;
    LookupPageID = "Arrears Line List";

    fields
    {
        field(1; "Arrears Id"; Code[20])
        {
            Caption = 'Arrears Id';
            ToolTip = 'Specifies the arrears document identifier.';
            DataClassification = CustomerContent;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the line number in the arrears document.';
            DataClassification = SystemMetadata;
        }

        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the location related to this arrears line.';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
        }
        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            ToolTip = 'Specifies the salary plan for which arrears are calculated.';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }

        field(5; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            ToolTip = 'Specifies the salary cycle related to the arrears.';
            DataClassification = CustomerContent;
        }

        field(6; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
            ToolTip = 'Specifies the start date of the payroll period.';
            DataClassification = CustomerContent;
        }
        field(7; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
            ToolTip = 'Specifies the end date of the payroll period.';
            DataClassification = CustomerContent;
        }

        field(8; Year; Integer)
        {
            Caption = 'Year';
            ToolTip = 'Specifies the payroll year.';
            DataClassification = CustomerContent;
        }

        field(9; Month; Integer)
        {
            Caption = 'Month';
            ToolTip = 'Specifies the payroll month.';
            DataClassification = CustomerContent;
        }
        field(10; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            ToolTip = 'Specifies the employee number.';
            NotBlank = true;
            TableRelation = Employee;
            DataClassification = CustomerContent;
        }

        field(11; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            ToolTip = 'Specifies the pay element associated with the arrears.';
            NotBlank = true;
            TableRelation = "Professional Tax Line";
            DataClassification = CustomerContent;
        }

        field(12; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
            ToolTip = 'Specifies the sorting order for pay elements.';
            DataClassification = SystemMetadata;
        }
        field(13; "Total Days in a Month"; Integer)
        {
            Caption = 'Total Days in a Month';
            ToolTip = 'Specifies the total number of days in the payroll month.';
            DataClassification = CustomerContent;
        }

        field(14; "Paid Days"; Decimal)
        {
            Caption = 'Paid Days';
            ToolTip = 'Specifies the number of paid days considered for arrears.';
            DataClassification = CustomerContent;
        }

        field(15; "Actual Amount"; Decimal)
        {
            Caption = 'Actual Amount';
            ToolTip = 'Specifies the actual salary amount.';
            DataClassification = CustomerContent;
        }

        field(16; "Payable Amount"; Decimal)
        {
            Caption = 'Payable Amount';
            ToolTip = 'Specifies the payable salary amount.';
            DataClassification = CustomerContent;
        }
        field(17; "Difference Amount / Percent(%)"; Decimal)
        {
            Caption = 'Difference Amount / Percent(%)';
            ToolTip = 'Specifies the difference amount or percentage.';
            DataClassification = CustomerContent;
        }

        field(18; "Arrear Amount"; Decimal)
        {
            Caption = 'Arrear Amount';
            ToolTip = 'Specifies the calculated arrear amount for this line.';
            DataClassification = CustomerContent;
        }

        field(19; "PF Gross Earnings"; Decimal)
        {
            Caption = 'PF Gross Earnings';
            ToolTip = 'Specifies the gross earnings considered for PF calculation.';
            DataClassification = CustomerContent;
        }
        field(20; "Employee PF Amount"; Decimal)
        {
            Caption = 'Employee PF Amount';
            ToolTip = 'Specifies the employee PF contribution amount.';
            DataClassification = CustomerContent;
        }

        field(21; "Employer PF Amount"; Decimal)
        {
            Caption = 'Employer PF Amount';
            ToolTip = 'Specifies the employer PF contribution amount.';
            DataClassification = CustomerContent;
        }

        field(22; "Employer EPS Amount"; Decimal)
        {
            Caption = 'Employer EPS Amount';
            ToolTip = 'Specifies the employer EPS contribution amount.';
            DataClassification = CustomerContent;
        }
        field(23; "PF Admin Charges Amount"; Decimal)
        {
            Caption = 'PF Admin Charges Amount';
            ToolTip = 'Specifies the PF administrative charges amount.';
            DataClassification = CustomerContent;
        }

        field(24; "PF EDLI Amount"; Decimal)
        {
            Caption = 'PF EDLI Amount';
            ToolTip = 'Specifies the PF EDLI contribution amount.';
            DataClassification = CustomerContent;
        }

        field(25; "PF RIFA Amount"; Decimal)
        {
            Caption = 'PF RIFA Amount';
            ToolTip = 'Specifies the PF RIFA contribution amount.';
            DataClassification = CustomerContent;
        }
        field(26; "Fixed/Percent"; Option)
        {
            Caption = 'Fixed/Percent';
            ToolTip = 'Specifies whether the value is fixed or percentage based.';
            Editable = false;
            OptionCaption = 'Fixed,Percent';
            OptionMembers = Fixed,Percent;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Arrears Id", "Line No.")
        {
            Clustered = true;
        }
        key(Key_ArrearsSum; "Arrears Id", "Employee No")
        {
            SumIndexFields = "Arrear Amount";
        }
        key(Key3; "Salary Cycle Code", "Employee No", "Sorting Order")
        {
        }
    }

    fieldgroups
    {
    }
}

