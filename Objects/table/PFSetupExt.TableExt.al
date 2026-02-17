tableextension 51002 "PF Setup Ext" extends "PF Setup"
{
    fields
    {
        field(50100; "Employer EPS ( Company) %"; Decimal)
        {
            Caption = 'Employer EPS ( Company) %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
            ToolTip = 'Specifies the percentage of EPS contribution paid by the employer.';
        }

        field(50101; "Employee VPF ( Employee) %"; Decimal)
        {
            Caption = 'Employee VPF ( Employee) %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
            ToolTip = 'Specifies the voluntary PF percentage contributed by the employee.';
        }
    }
}
