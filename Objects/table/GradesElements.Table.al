table 72062 "Grades Elements"
{
    Caption = 'Grades Elements';
    DataClassification = CustomerContent;
    DataCaptionFields = "Location Code", "Salary Plan Code", "Effective Date", "Grade Code";
    // DrillDownPageID = "Grades Elements List";
    LookupPageID = "Grades Elements List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
            TableRelation = "Salary Plan";
        }
        field(3; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;
        }
        field(4; "Grade Code"; Code[20])
        {
            Caption = 'Grade Code';
            DataClassification = CustomerContent;
        }
        field(5; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(8; "Fixed / Percent"; Option)
        {
            Caption = 'Fixed / Percent';
            DataClassification = CustomerContent;
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
        }
        field(9; "Amount Calculation Type"; Option)
        {
            Caption = 'Amount Calculation Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Pay Day,Full Amount';
            OptionMembers = "Pay Day","Full Amount";
        }
        field(10; "Base Pay Elements"; Text[250])
        {
            Caption = 'Base Pay Elements';
            DataClassification = CustomerContent;
        }
        field(11; "Percent (%)"; Decimal)
        {
            Caption = 'Percent (%)';
            DataClassification = CustomerContent;
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(13; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
            DataClassification = CustomerContent;
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

