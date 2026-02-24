table 72057 Holidays
{
    Caption = 'Holidays';
    DataClassification = CustomerContent;
    DataCaptionFields = "Location Code", "Salary Plan Code", "Calendar Year", "Holiday Date", "Holiday Name";
    DrillDownPageID = "Holidays List";
    LookupPageID = "Holidays List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
            TableRelation = "Salary Plan";
        }
        field(3; "Calendar Year"; Code[20])
        {
            Caption = 'Calendar Year';
            DataClassification = CustomerContent;
            TableRelation = "Payroll Year";
        }
        field(4; "Holiday Date"; Date)
        {
            Caption = 'Holiday Date';
            DataClassification = CustomerContent;
        }
        field(5; "Holiday Name"; Text[50])
        {
            Caption = 'Holiday Name';
            DataClassification = CustomerContent;
        }
        field(6; "First Half (Holiday)"; Boolean)
        {
            Caption = 'First Half (Holiday)';
            DataClassification = CustomerContent;

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
            DataClassification = CustomerContent;

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
            DataClassification = CustomerContent;
        }
        field(9; "OT Applicable for the Day"; Boolean)
        {
            Caption = 'OT Applicable for the Day';
            DataClassification = CustomerContent;
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

