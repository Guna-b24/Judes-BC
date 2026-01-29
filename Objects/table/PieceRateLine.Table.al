table 72111 "Piece Rate Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Piece Rate Line';

    fields
    {
        field(1; "Piece Rate ID No."; Code[20])
        {
            Caption = 'Piece Rate ID No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(5; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then
                    Name := Employee."First Name";
            end;
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(7; "Work Order Date"; Date)
        {
            Caption = 'Work Order Date';
            NotBlank = true;
        }
        field(8; "Work Order No."; Text[30])
        {
            Caption = 'Work Order No.';
            NotBlank = true;
        }
        field(9; "Item Code"; Code[20])
        {
            Caption = 'Item Code';
            NotBlank = true;
            TableRelation = "Item Piece Rate Master";

            trigger OnValidate()
            begin
                ItemPieceRateMaster.Get("Item Code", "Location Code", "Salary Plan Code");
                Description := ItemPieceRateMaster.Description;
                Rate := ItemPieceRateMaster.Rate;
                Amount := "No. Of Pieces" * Rate;
            end;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(11; "No. Of Pieces"; Integer)
        {
            Caption = 'No. Of Pieces';
            MaxValue = 9999;
            MinValue = 1;

            trigger OnValidate()
            begin
                Amount := "No. Of Pieces" * Rate;
            end;
        }
        field(12; Rate; Decimal)
        {
            Caption = 'Rate';
            MaxValue = 9.999.99;
            MinValue = 1;

            trigger OnValidate()
            begin
                Amount := "No. Of Pieces" * Rate;
            end;
        }
        field(13;Amount;Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(14;Remarks;Text[50])
        {
            Caption = 'Remarks';
        }
        field(15;Posted;Boolean)
        {
            Caption = 'Posted';
        }
    }

    keys
    {
        key(Key1;"Piece Rate ID No.","Location Code","Salary Plan Code","Line No.")
        {
            Clustered = true;
        }
        key(Key2;"Employee No.","Work Order Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
        ItemPieceRateMaster: Record "Item Piece Rate Master";
}

