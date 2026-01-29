table 72018 "HR Pay Elements"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'HR Pay Elements';
    DataCaptionFields = "Interview No";
    DrillDownPageID = 72026;
    LookupPageID = 72026;

    fields
    {
        field(1; "Interview No"; Code[20])
        {
            Caption = 'Interview No';
        }
        field(2; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            NotBlank = true;
            TableRelation = "Pay Elements";

            trigger OnValidate()
            begin
                PayElements.Reset;
                PayElements.SetRange("Pay Element Code", "Pay Element Code");
                if PayElements.FindFirst then
                    repeat
                        Description := PayElements.Description;
                    until PayElements.Next = 0;
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(5; "Fixed / Percent"; Option)
        {
            Caption = 'Fixed / Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
        }
        field(6; "Amount Calculation Type"; Option)
        {
            Caption = 'Amount Calculation Type';
            OptionCaption = 'Pay Day,Full Amount';
            OptionMembers = "Pay Day","Full Amount";
        }
        field(7; "Amount / Percent (%)"; Decimal)
        {
            Caption = 'Amount / Percent (%)';
        }
        field(8; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
        }
    }

    keys
    {
        key(Key1; "Interview No", "Pay Element Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PayElements: Record "Pay Elements";
}

