table 72079 "Employee Leave Attachment"
{
    Caption = 'Employee Leave Attachment';

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the location associated with the employee leave.';
        }

        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the salary plan applicable for the employee.';
        }

        field(3; "Employee No"; Code[20])
        {
            Caption = 'Employee No.';
            Editable = false;
            TableRelation = Employee;
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the employee number.';
        }

        field(4; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            TableRelation = "Leave Master"
                WHERE(
                    "Location Code" = FIELD("Location Code"),
                    "Salary Plan Code" = FIELD("Salary Plan Code")
                );
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the leave type assigned to the employee.';
        }
    }



    keys
    {
        key(Key1; "Employee No", "Location Code", "Salary Plan Code", "Leave Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

