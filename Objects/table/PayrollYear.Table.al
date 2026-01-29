table 72054 "Payroll Year"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.

    Caption = 'Payroll Year';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Year Code", "Year Type", "Year Start Date", "Year End Date";
    DrillDownPageID = 72067;
    LookupPageID = 72067;

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
        field(3; "Year Code"; Code[20])
        {
            Caption = 'Year Code';
        }
        field(4; "Year Type"; Option)
        {
            Caption = 'Year Type';
            OptionCaption = 'Salary Year,PF Year,ESI Year,Income Tax Year,Bonus Year,Leave Year';
            OptionMembers = "Salary Year","PF Year","ESI Year","Income Tax Year","Bonus Year","Leave Year";
        }
        field(5; "Year Start Date"; Date)
        {
            Caption = 'Year Start Date';
        }
        field(6; "Year End Date"; Date)
        {
            Caption = 'Year End Date';
        }
        field(7; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(8; Created; Boolean)
        {
            Caption = 'Created';
        }
        field(9; "Salary Cyclic Code Generated"; Integer)
        {
            CalcFormula = Count ("Payroll Month & Year" WHERE ("Location Code" = FIELD ("Location Code"),
                                                              "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                              "Salary Year Code" = FIELD ("Year Code")));
            Caption = 'Salary Cyclic Code Generated';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Acknowledgement No 1"; Code[20])
        {
            Caption = 'Acknowledgement No 1';
        }
        field(11; "Acknowledgement No 2"; Code[20])
        {
            Caption = 'Acknowledgement No 2';
        }
        field(12; "Acknowledgement No 3"; Code[20])
        {
            Caption = 'Acknowledgement No 3';
        }
        field(13; "Acknowledgement No 4"; Code[20])
        {
            Caption = 'Acknowledgement No 4';
        }
        field(14; "Acknowledgement Date 1"; Date)
        {
            Caption = 'Acknowledgement Date 1';
        }
        field(15; "Acknowledgement Date 2"; Date)
        {
            Caption = 'Acknowledgement Date 2';
        }
        field(16; "Acknowledgement Date 3"; Date)
        {
            Caption = 'Acknowledgement Date 3';
        }
        field(17; "Acknowledgement Date 4"; Date)
        {
            Caption = 'Acknowledgement Date 4';
        }
    }

    keys
    {
        key(Key1; "Year Code", "Location Code", "Salary Plan Code", "Year Type", "Year Start Date")
        {
            Clustered = true;
        }
        key(Key2; "Location Code", "Salary Plan Code", "Year Type", "Year Start Date", "Year End Date")
        {
        }
    }

    fieldgroups
    {
    }
}

