table 72078 "Employee Pay Elements"
{
    Caption = 'Employee Pay Elements';
    DataClassification = CustomerContent;
    LookupPageId = "Employee Pay Elements List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }
        field(3; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;
        }
        field(4; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            TableRelation = "Pay Elements" WHERE("Location Code" = FIELD("Location Code"),
                                                  "Salary Plan Code" = FIELD("Salary Plan Code"));

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
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(6; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(7; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            Editable = false;
            DataClassification = CustomerContent;
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(8; "Fixed/Percent"; Option)
        {
            Caption = 'Fixed/Percent';
            DataClassification = CustomerContent;
            Editable = false;
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
            Editable = false;
        }
        field(11; "Percent (%)"; Decimal)
        {
            Caption = 'Percent (%)';
            DataClassification = CustomerContent;
            MaxValue = 100;
            MinValue = 0;
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
            Editable = false;
        }
        field(14; "Excluded In Pay Slip"; Boolean)
        {
            Caption = 'Excluded In Pay Slip';
            DataClassification = CustomerContent;
        }
        field(50000; "Designation Code"; Code[20])
        {
            Caption = 'Designation Code';
            DataClassification = CustomerContent;
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

