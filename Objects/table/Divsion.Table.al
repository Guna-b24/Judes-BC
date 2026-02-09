table 71043 Divsion
{
    Caption = 'Divsion';
    DataClassification = CustomerContent;
    //   LookupPageID = 71043;

    fields
    {
        field(1; "Division Code"; Code[20])
        {
            Caption = 'Division Code';
            DataClassification = CustomerContent;
        }
        field(2; "Division Description"; Text[50])
        {
            Caption = 'Division Description';
            DataClassification = CustomerContent;
        }
        field(3; "Created Academic Year"; Code[20])
        {
            Caption = 'Created Academic Year';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Division Code", "Created Academic Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created Academic Year" := EduVert.GetAdmissionYear();
    end;

    var
        EduVert: Codeunit "Education Vertical";
}

