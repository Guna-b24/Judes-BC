table 72062 "Grades Elements"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Grades Elements';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Effective Date", "Grade Code";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(3; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
        }
        field(4; "Grade Code"; Code[20])
        {
            Caption = 'Grade Code';
        }
        field(5; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(8; "Fixed / Percent"; Option)
        {
            Caption = 'Fixed / Percent';
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
        }
        field(9; "Amount Calculation Type"; Option)
        {
            Caption = 'Amount Calculation Type';
            OptionCaption = 'Pay Day,Full Amount';
            OptionMembers = "Pay Day","Full Amount";
        }
        field(10; "Base Pay Elements"; Text[250])
        {
            Caption = 'Base Pay Elements';
        }
        field(11; "Percent (%)"; Decimal)
        {
            Caption = 'Percent (%)';
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(13; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
        }
    }

    keys
    {
        key(Key1; "Pay Element Code", "Grade Code", "Effective Date", "Salary Plan Code", "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

