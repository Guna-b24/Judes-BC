table 72078 "Employee Pay Elements"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Employee Pay Elements';

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
        field(4; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            TableRelation = "Pay Elements" WHERE ("Location Code" = FIELD ("Location Code"),
                                                  "Salary Plan Code" = FIELD ("Salary Plan Code"));

            trigger OnValidate()
            begin
                PayElements.Get("Pay Element Code", "Location Code", "Salary Plan Code");
                Description := PayElements.Description;
                "Pay Type" := PayElements."Pay Type";
                "Fixed/Percent" := PayElements."Fixed/Percent";
                "Amount Calculation Type" := PayElements."Amount Calculation Type";
                "Base Pay Elements" := PayElements."Base Pay Elements";
                "Percent (%)" := PayElements."Percent (%)";
                "Sorting Order" := PayElements."Sorting Order";
                "Excluded In Pay Slip" := PayElements."Excluded In Pay Slip";
            end;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
            Editable = true;
        }
        field(6; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;
        }
        field(7; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            Editable = false;
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(8; "Fixed/Percent"; Option)
        {
            Caption = 'Fixed/Percent';
            Editable = false;
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
            Editable = false;
        }
        field(11; "Percent (%)"; Decimal)
        {
            Caption = 'Percent (%)';
            MaxValue = 100;
            MinValue = 0;
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(13; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
            Editable = false;
        }
        field(14; "Excluded In Pay Slip"; Boolean)
        {
            Caption = 'Excluded In Pay Slip';
        }
        field(50000; "Designation Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Effective Date", "Pay Element Code", "Location Code", "Salary Plan Code", "Employee No")
        {
            Clustered = true;
        }
        key(Key2; "Effective Date", "Sorting Order", "Pay Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PayElements: Record "Pay Elements";
}

