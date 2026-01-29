table 60008 ParentInvoiceSetup
{

    fields
    {
        field(1; StartDate; Date)
        {
        }
        field(2; EndDate; Date)
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; IsGreaterThan; Boolean)
        {
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

