table 72008 Training
{
    Caption = 'Training';
    DataCaptionFields = "Code";
    DataClassification = CustomerContent;
    // DrillDownPageID = 72008;
    // LookupPageID = 72008;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField(Code);
    end;
}

