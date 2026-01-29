table 72092 "Revision Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Revision Line';

    fields
    {
        field(1; "Pay Revision Id"; Code[20])
        {
            Caption = 'Pay Revision Id';
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(4; "Last Effective Date"; Date)
        {
            Caption = 'Last Effective Date';
        }
        field(5; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            TableRelation = "Pay Elements";
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(7; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;
        }
        field(8; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(9; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            Editable = false;
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
        }
        field(10; "Fixed/Percent"; Option)
        {
            Caption = 'Fixed/Percent';
            Editable = false;
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
        }
        field(11; "Amount Calculation Type"; Option)
        {
            Caption = 'Amount Calculation Type';
            Editable = false;
            OptionCaption = 'Pay Day,Full Amount';
            OptionMembers = "Pay Day","Full Amount";
        }
        field(12; "Base Pay Elements"; Text[250])
        {
            Caption = 'Base Pay Elements';
        }
        field(13; "Last Drawn Amount"; Decimal)
        {
            Caption = 'Last Drawn Amount';
        }
        field(14; "Last Drawn Percent (%)"; Decimal)
        {
            Caption = 'Last Drawn Percent (%)';
        }
        field(15; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
            Editable = false;
        }
        field(16; "New Effective Date"; Date)
        {
            Caption = 'New Effective Date';
        }
        field(17; "Revised Amount"; Decimal)
        {
            Caption = 'Revised Amount';

            trigger OnValidate()
            begin
                "Difference Amount" := "Revised Amount" - "Last Drawn Amount";
            end;
        }
        field(18; "Revised Percent (%)"; Decimal)
        {
            Caption = 'Revised Percent (%)';

            trigger OnValidate()
            begin
                "Difference Percent (%)" := "Revised Percent (%)" - "Last Drawn Percent (%)";
            end;
        }
        field(19; "Difference Amount"; Decimal)
        {
            Caption = 'Difference Amount';

            trigger OnValidate()
            begin
                "Revised Amount" := "Last Drawn Amount" + "Difference Amount";
            end;
        }
        field(20; "Difference Percent (%)"; Decimal)
        {
            Caption = 'Difference Percent (%)';
        }
        field(21; "Old Grade Code"; Code[20])
        {
            Caption = 'Old Grade Code';
            TableRelation = Grades;
        }
        field(22; "New Grade Code"; Code[20])
        {
            Caption = 'New Grade Code';
            TableRelation = Grades;
        }
        field(23; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(24; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
        }
        field(25; "Pay Revised"; Boolean)
        {
            Caption = 'Pay Revised';
        }
        field(26; "Excluded In Pay Slip"; Boolean)
        {
            Caption = 'Excluded In Pay Slip';
        }
        field(27; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary";
        }
    }

    keys
    {
        key(Key1; "Pay Revision Id", "Location Code", "Salary Plan Code", "Last Effective Date", "Pay Element Code", "Employee No")
        {
            Clustered = true;
        }
        key(Key2; "Employee No", "Sorting Order")
        {
        }
        key(Key3; "Last Drawn Amount", "Employee No")
        {
        }
    }

    fieldgroups
    {
    }
}

