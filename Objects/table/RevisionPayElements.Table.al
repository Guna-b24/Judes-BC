table 72106 "Revision Pay Elements"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Revision Pay Elements';

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
        field(4; "Pay Element Code"; Code[20])
        {
            Caption = 'Pay Element Code';
            TableRelation = "Pay Elements" WHERE ("Location Code" = FIELD ("Location Code"),
                                                  "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                  "Pay Type" = CONST (Addition),
                                                  "Regular Element" = CONST (true));

            trigger OnValidate()
            begin
                if PayElements.Get("Pay Element Code", "Location Code", "Salary Plan Code") then begin
                    Description := PayElements.Description;
                    "Fixed / Percent" := PayElements."Fixed/Percent";

                    if "Fixed / Percent" = "Fixed / Percent"::Percent then begin
                        "Old Amount / Percent(%)" := PayElements."Percent (%)";
                        "Revised Amount / Percent(%)" := PayElements."Percent (%)";
                    end;

                    if "Fixed / Percent" = "Fixed / Percent"::Fixed then begin
                        "Old Amount / Percent(%)" := PayElements.Amount;
                        "Revised Amount / Percent(%)" := PayElements.Amount;
                    end;

                end;
            end;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(6; "Fixed / Percent"; Option)
        {
            Caption = 'Fixed / Percent';
            Editable = false;
            OptionCaption = 'Fixed,Percent';
            OptionMembers = "Fixed",Percent;
        }
        field(7; "Old Amount / Percent(%)"; Decimal)
        {
            Caption = 'Old Amount / Percent(%)';
        }
        field(8; "Revised Amount / Percent(%)"; Decimal)
        {
            Caption = 'Revised Amount / Percent(%)';

            trigger OnValidate()
            begin
                "Difference Amount / Percent(%)" := "Revised Amount / Percent(%)" - "Old Amount / Percent(%)";
            end;
        }
        field(9; "Difference Amount / Percent(%)"; Decimal)
        {
            Caption = 'Difference Amount / Percent(%)';
        }
        field(10; Revise; Boolean)
        {
            Caption = 'Revise';
        }
    }

    keys
    {
        key(Key1; "Pay Revision Id", "Location Code", "Salary Plan Code", "Pay Element Code")
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

