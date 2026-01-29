table 72107 "Arrears Header Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Arrears Header Line';

    fields
    {
        field(1; "Arrears Id"; Code[20])
        {
            Caption = 'Arrears Id';
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(4; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(5; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(6; "Total Arrear Amount"; Decimal)
        {
            CalcFormula = Sum ("Arrears Line"."Arrear Amount" WHERE ("Arrears Id" = FIELD ("Arrears Id"),
                                                                    "Employee No" = FIELD ("Employee No")));
            Caption = 'Total Arrear Amount';
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
        /*
        IF CONFIRM('Are Sure to Delete the Records <Yes/No> Delete All Lines..!!') THEN BEGIN
          ArrearsLine.RESET;
          ArrearsLine.SETRANGE("Arrears Id", "Arrears Id");
          IF ArrearsLine.FINDFIRST THEN BEGIN
            ArrearsLine.LOCKTABLE;
            ArrearsLine.DELETEALL;
          END;
        END;
        */

    end;

    var
        ArrearsLine: Record "Final Settlement Line";
}

