table 60008 ParentInvoiceSetup
{
    Caption = 'Parent Invoice Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; StartDate; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
            ToolTip = 'The start date for the parent invoice setup period.';
        }
        field(2; EndDate; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
            ToolTip = 'The end date for the parent invoice setup period.';
        }
        field(3; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
            ToolTip = 'The amount configured for the parent invoice.';
        }
        field(4; IsGreaterThan; Boolean)
        {
            Caption = 'Is Greater Than';
            DataClassification = ToBeClassified;
            ToolTip = 'Indicates whether the amount is greater than the configured value.';
        }
    }

    keys
    {
        key(Key1; StartDate)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

