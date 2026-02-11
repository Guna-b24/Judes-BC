table 71079 "House Incharge Line"
{
    Caption = 'House Incharge Line';
    // DrillDownPageID = 71089;
    // LookupPageID = 71089;

    fields
    {
        field(1; "House Code"; Code[20])
        {
            Caption = 'House Code';
            TableRelation = House;
            DataClassification = CustomerContent;
        }
        field(2; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            TableRelation = "Employee Alll";

            trigger OnValidate()
            begin
                HouseInchargeLine.Reset();
                HouseInchargeLine.SetRange("Staff Code", "Staff Code");
                "Staff Name" := "Employee all".Name;
            end;
        }
        field(3; "Staff Name"; Text[100])
        {
            Caption = 'Staff Name';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(4; "Is Incharge"; Boolean)
        {
            Caption = 'Is Incharge';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                House.Get("House Code");
                House.TestField("No Incharge");
                HouseInchargeLine.Reset();
                HouseInchargeLine.SetRange("House Code", "House Code");
                HouseInchargeLine.SetRange("Is Incharge", true);
                if HouseInchargeLine.Count >= House."No Incharge" then
                    Error(Text001, House."No Incharge");
            end;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "House Code", "Staff Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HouseInchargeLine: Record "House Incharge Line";
        "Employee all": Record "Employee Alll";
        House: Record House;
        Text000: Label 'Staffs already allotted for house %1.';
        Text001: Label 'Only %1 staff can be allottted for Incharge.';
}

