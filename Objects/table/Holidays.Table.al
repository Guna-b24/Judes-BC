table 72057 Holidays
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.

    Caption = 'Holidays';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Calendar Year", "Holiday Date", "Holiday Name";

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
        field(3; "Calendar Year"; Code[20])
        {
            Caption = 'Calendar Year';
            TableRelation = "Payroll Year";
        }
        field(4; "Holiday Date"; Date)
        {
            Caption = 'Holiday Date';
        }
        field(5; "Holiday Name"; Text[50])
        {
            Caption = 'Holiday Name';
        }
        field(6; "First Half (Holiday)"; Boolean)
        {
            Caption = 'First Half (Holiday)';

            trigger OnValidate()
            begin
                if "First Half (Holiday)" then
                    "Non Working Days" := true;

                if not "First Half (Holiday)" and not "Second Half (Holiday)" then
                    "Non Working Days" := false;
            end;
        }
        field(7; "Second Half (Holiday)"; Boolean)
        {
            Caption = 'Second Half (Holiday)';

            trigger OnValidate()
            begin
                if "Second Half (Holiday)" then
                    "Non Working Days" := true;

                if (not "First Half (Holiday)") and (not "Second Half (Holiday)") then
                    "Non Working Days" := false;
            end;
        }
        field(8; "Non Working Days"; Boolean)
        {
            Caption = 'Non Working Days';
        }
        field(9; "OT Applicable for the Day"; Boolean)
        {
            Caption = 'OT Applicable for the Day';
        }
    }

    keys
    {
        key(Key1; "Holiday Date", "Location Code", "Salary Plan Code", "Calendar Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

