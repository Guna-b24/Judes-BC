table 72053 "Salary Plan"
{
    Caption = 'Salary Plan';
    DataCaptionFields = "Code", Description;
    DataClassification = CustomerContent;
    // DrillDownPageID = 72064;
    // LookupPageID = 72064;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            ToolTip = 'Specifies the unique code for the salary plan.';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the salary plan.';
        }
        field(3; "Date Interval"; DateFormula)
        {
            Caption = 'Date Interval';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date interval used to calculate the salary period.';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Monthly,Daily,Weekly,FortNight,Quarterly,Half Yearly,Yearly';
            OptionMembers = Monthly,Daily,Weekly,FortNight,Quarterly,"Half Yearly",Yearly;
            ToolTip = 'Specifies the salary calculation type.';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField(Code);
    end;
}

