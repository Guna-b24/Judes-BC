table 72107 "Arrears Header Line"
{
    Caption = 'Arrears Header Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Arrears Id"; Code[20])
        {
            Caption = 'Arrears Id';
            ToolTip = 'Specifies the unique identifier for the arrears document.';
            DataClassification = CustomerContent;
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the location associated with the arrears.';
            DataClassification = CustomerContent;
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            ToolTip = 'Specifies the salary plan applicable for the arrears.';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }
        field(4; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            ToolTip = 'Specifies the employee number for whom the arrears are calculated.';
            NotBlank = true;
            TableRelation = Employee;
            DataClassification = CustomerContent;
        }
        field(5; Name; Text[50])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the name of the employee.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Total Arrear Amount"; Decimal)
        {
            Caption = 'Total Arrear Amount';
            ToolTip = 'Shows the total arrear amount calculated from arrears lines.';
            CalcFormula = sum("Arrears Line"."Arrear Amount" where("Arrears Id" = field("Arrears Id"),
                                                                    "Employee No" = field("Employee No")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Arrears Id", "Location Code", "Salary Plan Code", "Employee No")
        {
            Clustered = true;

        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

    end;

    var
    //ArrearsLine: Record "Final Settlement Line";
}

