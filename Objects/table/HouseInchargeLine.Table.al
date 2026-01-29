table 71079 "House Incharge Line"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   15.12.09  VIGNESH  OnInsert()                 Code added to enter the User id
    // 02   15.12.09  VIGNESH  Staff Code - OnValidate()  Code added to validate the Staff
    // 03   15.12.09  VIGNESH  Is Incharge - OnValidate() Code added to validate the Staff Incharge

    Caption = 'House Incharge Line';
    DrillDownPageID = 71089;
    LookupPageID = 71089;

    fields
    {
        field(1; "House Code"; Code[20])
        {
            Caption = 'House Code';
        }
        field(2; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            TableRelation = "Employee Alll";

            trigger OnValidate()
            begin
                // Start 02.VIGNESH
                HouseInchargeLine.Reset;
                HouseInchargeLine.SetRange("Staff Code", "Staff Code");
                //IF HouseInchargeLine.ISEMPTY THEN BEGIN
                //"Employee all".GET("Employee all"."Employee No.");
                "Staff Name" := "Employee all".Name;
                //END ELSE
                //IF HouseInchargeLine.FINDFIRST THEN
                // ERROR(Text000,HouseInchargeLine."House Code")
                //ELSE
                //"Staff Name" := '';

                // Stop 02.VIGNESH
            end;
        }
        field(3; "Staff Name"; Text[50])
        {
            Caption = 'Staff Name';
            Editable = true;
        }
        field(4; "Is Incharge"; Boolean)
        {
            Caption = 'Is Incharge';

            trigger OnValidate()
            begin
                // Start 03.VIGNESH
                House.Get("House Code");
                House.TestField("No Incharge");
                HouseInchargeLine.Reset;
                HouseInchargeLine.SetRange("House Code", "House Code");
                HouseInchargeLine.SetRange("Is Incharge", true);
                if HouseInchargeLine.Count >= House."No Incharge" then
                    Error(Text001, House."No Incharge");
                // Stop 03.VIGNESH
            end;
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
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

    trigger OnInsert()
    begin
        // Start 01.VIGNESH
        "User ID" := UserId;
        // Stop 01.VIGNESH
    end;

    var
        HouseInchargeLine: Record "House Incharge Line";
        "Employee all": Record "Employee Alll";
        House: Record House;
        Text000: Label 'Staffs already allotted for house %1.';
        Text001: Label 'Only %1 staff can be allottted for Incharge.';
}

