table 72025 "Training Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Training Line';

    fields
    {
        field(1; "Training No."; Code[20])
        {
            Caption = 'Training No.';
        }
        field(2; "Employee No"; Code[20])
        {
            Caption = 'Employee  No';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "First Name" := Employee."First Name";
                    "Middle Name" := Employee."Middle Name";
                    "Last Name" := Employee."Last Name";
                    Initial := Employee.Initials;
                    "Department Code" := Employee."Designation Code";
                    "Department Description" := Employee."Job Title";
                    ;
                    "Designation Code" := Employee."Global Dimension 1 Code";

                    if Department.Get("Designation Code") then
                        "Designation Description" := Department.Name;
                    "E-Mail" := Employee."E-Mail";
                end;
            end;
        }
        field(3; "First Name"; Text[30])
        {
            Caption = 'First Name';
            Editable = false;
        }
        field(4; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            Editable = false;
        }
        field(5; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
            Editable = false;
        }
        field(6; Initial; Text[30])
        {
            Caption = 'Initial';
            Editable = false;
        }
        field(7; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
            Editable = false;
        }
        field(8; "Department Description"; Text[30])
        {
            Caption = 'Department Description';
            Editable = false;
        }
        field(9; "Designation Code"; Code[10])
        {
            Caption = 'Designation Code';
            Editable = false;
        }
        field(10; "Designation Description"; Text[30])
        {
            Caption = 'Designation Description';
            Editable = false;
        }
        field(11; "E-Mail"; Text[30])
        {
            Caption = 'E-Mail';
            Editable = false;
        }
        field(12; "Send Mail"; Boolean)
        {
            Caption = 'Send Mail';
        }
        field(13; Notes; Text[30])
        {
            Caption = 'Notes';
        }
    }

    keys
    {
        key(Key1; "Training No.", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
        Department: Record "Dimension Value";
}

