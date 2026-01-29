table 72053 "Salary Plan"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.

    Caption = 'Salary Plan';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = 72064;
    LookupPageID = 72064;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Date Interval"; DateFormula)
        {
            Caption = 'Date Interval';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Monthly,Daily,Weekly,FortNight,Quarterly,Half Yearly,Yearly';
            OptionMembers = Monthly,Daily,Weekly,FortNight,Quarterly,"Half Yearly",Yearly;
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

