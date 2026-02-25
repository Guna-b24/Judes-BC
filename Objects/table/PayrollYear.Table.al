table 72054 "Payroll Year"
{
    Caption = 'Payroll Year';
    DataClassification = CustomerContent;
    DataCaptionFields = "Location Code", "Salary Plan Code", "Year Code", "Year Type", "Year Start Date", "Year End Date";
    DrillDownPageID = "Payroll Year List";
    LookupPageID = "Payroll Year List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the location for which the payroll year is defined.';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary plan associated with the payroll year.';
            TableRelation = "Salary Plan";
        }
        field(3; "Year Code"; Code[20])
        {
            Caption = 'Year Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique code for the payroll year.';
        }
        field(4; "Year Type"; Option)
        {
            Caption = 'Year Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the type of payroll year such as Salary Year, PF Year, ESI Year, etc.';
            OptionCaption = 'Salary Year,PF Year,ESI Year,Income Tax Year,Bonus Year,Leave Year';
            OptionMembers = "Salary Year","PF Year","ESI Year","Income Tax Year","Bonus Year","Leave Year";
        }
        field(5; "Year Start Date"; Date)
        {
            Caption = 'Year Start Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the starting date of the payroll year.';
        }
        field(6; "Year End Date"; Date)
        {
            Caption = 'Year End Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the ending date of the payroll year.';
        }
        field(7; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the payroll year is closed.';
        }
        field(8; Created; Boolean)
        {
            Caption = 'Created';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the payroll year has been created in the system.';
        }
        field(9; "Salary Cyclic Code Generated"; Integer)
        {
            CalcFormula = Count("Payroll Month & Year" WHERE("Location Code" = FIELD("Location Code"),
                                                              "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                              "Salary Year Code" = FIELD("Year Code")));
            Caption = 'Salary Cyclic Code Generated';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Acknowledgement No 1"; Code[20])
        {
            Caption = 'Acknowledgement No 1';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the first acknowledgement number.';
        }
        field(11; "Acknowledgement No 2"; Code[20])
        {
            Caption = 'Acknowledgement No 2';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the second acknowledgement number.';
        }
        field(12; "Acknowledgement No 3"; Code[20])
        {
            Caption = 'Acknowledgement No 3';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the third acknowledgement number.';
        }
        field(13; "Acknowledgement No 4"; Code[20])
        {
            Caption = 'Acknowledgement No 4';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fourth acknowledgement number.';
        }
        field(14; "Acknowledgement Date 1"; Date)
        {
            Caption = 'Acknowledgement Date 1';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date of the first acknowledgement.';
        }
        field(15; "Acknowledgement Date 2"; Date)
        {
            Caption = 'Acknowledgement Date 2';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date of the second acknowledgement.';
        }
        field(16; "Acknowledgement Date 3"; Date)
        {
            Caption = 'Acknowledgement Date 3';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date of the third acknowledgement.';
        }
        field(17; "Acknowledgement Date 4"; Date)
        {
            Caption = 'Acknowledgement Date 4';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date of the fourth acknowledgement.';
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

