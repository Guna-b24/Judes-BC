table 72089 "Misc Add/Deductions"
{
    Caption = 'Misc Add/Deductions';
    DataClassification = CustomerContent;
    LookupPageID = "Misc Add/Deduction List";
    DrillDownPageID = "Misc Add/Deduction List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the location code for the employee.';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary plan code applicable to this record.';
        }
        field(3; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary cycle for which this record is valid.';
        }
        field(4; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
            DataClassification = CustomerContent;
            ToolTip = 'Start date of the payroll period.';
        }
        field(5; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
            DataClassification = CustomerContent;
            ToolTip = 'End date of the payroll period.';
        }
        field(6; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            ToolTip = 'Year of the payroll period.';
        }
        field(7; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
            ToolTip = 'Month of the payroll period.';
        }
        field(8; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = CustomerContent;
            ToolTip = 'Employee identifier.';
            TableRelation = Employee;
        }
        field(9; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            TableRelation = "Pay Elements" WHERE("Location Code" = FIELD("Location Code"),
                                                  "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(10; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            ToolTip = 'Name of the employee or pay element.';
        }
        field(11; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            DataClassification = CustomerContent;
            ToolTip = 'Category of the employee (Monthly/Yearly).';
            OptionCaption = 'Monthly,Yearly';
            OptionMembers = Monthly,Yearly;
        }
        field(12; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            DataClassification = CustomerContent;
            ToolTip = 'Type of payment (Addition, Deduction, Reimbursement).';
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Amount for this add/deduction record.';
        }
        field(14; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date this record was created.';
        }
        field(16; "Element Type"; Option)
        {
            Caption = 'Element Type';
            DataClassification = CustomerContent;
            ToolTip = 'Type of element, e.g., OT Calculation.';
            OptionCaption = ' ,OT Calculation';
            OptionMembers = " ","OT Calculation";
        }
        field(17; "Total OT Hours"; Decimal)
        {
            Caption = 'Total OT Hours';
            DataClassification = CustomerContent;
            ToolTip = 'Total number of overtime hours.';
        }
        field(18; "OT Type"; Option)
        {
            Caption = 'OT Type';
            DataClassification = CustomerContent;
            ToolTip = 'Type of overtime calculation.';
            OptionCaption = ' ,Fixed Amount,Hourly Based';
            OptionMembers = " ","Fixed Amount","Hourly Based";
        }
        field(19; "OT Fixed Amount"; Decimal)
        {
            Caption = 'OT Fixed Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Fixed amount for overtime, if applicable.';
        }
        field(20; "Paid Category"; Option)
        {
            Caption = 'Paid Category';
            DataClassification = CustomerContent;
            ToolTip = 'Category of payment (Monthly, Yearly, Daily).';
            OptionCaption = 'Monthly,Yearly,Daily';
            OptionMembers = Monthly,Yearly,Daily;
        }
        field(30; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
            ToolTip = 'Gender of the employee.';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(31; "Pay Category"; Option)
        {
            Caption = 'Pay Category';
            DataClassification = CustomerContent;
            ToolTip = 'Category of employee for payment purposes.';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary";
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Salary Cycle Code", "Employee No", "Pay Element Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

