table 72092 "Revision Line"
{

    Caption = 'Revision Line';
    DataClassification = CustomerContent;
    LookupPageId = "Revision Line List";

    fields
    {
        field(1; "Pay Revision Id"; Code[20])
        {
            Caption = 'Pay Revision Id';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the pay revision document ID.';
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the location where the revision is applicable.';
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary plan code.';
        }
        field(4; "Last Effective Date"; Date)
        {
            Caption = 'Last Effective Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the previous effective date of the pay element.';
        }
        field(5; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            TableRelation = "Pay Elements";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the pay element being revised.';
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the pay element.';
        }
        field(7; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee number.';
        }
        field(8; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee name.';
        }
        field(9; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            Editable = false;
            OptionCaption = 'Addition,Deduction,Reimbursement';
            OptionMembers = Addition,Deduction,Reimbursement;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the pay element is addition, deduction, or reimbursement.';
        }
        field(10; "Fixed/Percent"; Option)
        {
            Caption = 'Fixed/Percent';
            Editable = false;
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the value is fixed amount or percentage.';
        }
        field(11; "Amount Calculation Type"; Option)
        {
            Caption = 'Amount Calculation Type';
            Editable = false;
            OptionCaption = 'Pay Day,Full Amount';
            OptionMembers = "Pay Day","Full Amount";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies how the amount is calculated.';
        }
        field(12; "Base Pay Elements"; Text[250])
        {
            Caption = 'Base Pay Elements';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the base pay elements used for calculation.';
        }
        field(13; "Last Drawn Amount"; Decimal)
        {
            Caption = 'Last Drawn Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the last drawn amount of the pay element.';
        }
        field(14; "Last Drawn Percent (%)"; Decimal)
        {
            Caption = 'Last Drawn Percent (%)';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the last drawn percentage.';
        }
        field(15; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the sorting order of the pay element.';
        }
        field(16; "New Effective Date"; Date)
        {
            Caption = 'New Effective Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the new effective date of the revision.';
        }
        field(17; "Revised Amount"; Decimal)
        {
            Caption = 'Revised Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the revised amount.';

            trigger OnValidate()
            begin
                "Difference Amount" := "Revised Amount" - "Last Drawn Amount";
            end;
        }
        field(18; "Revised Percent (%)"; Decimal)
        {
            Caption = 'Revised Percent (%)';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the revised percentage.';

            trigger OnValidate()
            begin
                "Difference Percent (%)" := "Revised Percent (%)" - "Last Drawn Percent (%)";
            end;
        }
        field(19; "Difference Amount"; Decimal)
        {
            Caption = 'Difference Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the difference between revised and last drawn amount.';

            trigger OnValidate()
            begin
                "Revised Amount" := "Last Drawn Amount" + "Difference Amount";
            end;
        }
        field(20; "Difference Percent (%)"; Decimal)
        {
            Caption = 'Difference Percent (%)';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the difference between revised and last drawn percentage.';
        }
        field(21; "Old Grade Code"; Code[20])
        {
            Caption = 'Old Grade Code';
            TableRelation = Grades;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the previous grade code of the employee.';
        }
        field(22; "New Grade Code"; Code[20])
        {
            Caption = 'New Grade Code';
            TableRelation = Grades;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the new grade code after revision.';
        }
        field(23; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the revision line is posted.';
        }
        field(24; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date when the revision was posted.';
        }
        field(25; "Pay Revised"; Boolean)
        {
            Caption = 'Pay Revised';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the pay has been revised.';
        }
        field(26; "Excluded In Pay Slip"; Boolean)
        {
            Caption = 'Excluded In Pay Slip';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the pay element is excluded in pay slip.';
        }
        field(27; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the category of the employee.';
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

