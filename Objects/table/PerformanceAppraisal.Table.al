table 72006 "Performance Appraisal"
{

    Caption = 'Performance Appraisal';
    DataCaptionFields = "Code";
    // DrillDownPageID = 72006;
    // LookupPageID = 72006;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Appraisal Code';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique code for the performance appraisal.';
        }

        field(2; Description; Text[30])
        {
            Caption = 'Description';
            NotBlank = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the performance appraisal.';
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

