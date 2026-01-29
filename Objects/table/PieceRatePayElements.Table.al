table 72109 "Piece Rate Pay Elements"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Piece Rate Pay Elements';

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
        field(3; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            TableRelation = "Pay Elements" WHERE ("Location Code" = FIELD ("Location Code"),
                                                  "Salary Plan Code" = FIELD ("Salary Plan Code"));

            trigger OnValidate()
            begin
                if PayElements.Get("Pay Element Code", "Location Code", "Salary Plan Code") then
                    Description := PayElements.Description;
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(5; "Percent(%)"; Decimal)
        {
            Caption = 'Percent(%)';
        }
        field(6; "Rate Type"; Option)
        {
            Caption = 'Rate Type';
            OptionCaption = 'Hourly Rate,Piece Rate';
            OptionMembers = "Hourly Rate","Piece Rate";
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Pay Element Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PayElements: Record "Pay Elements";
}

