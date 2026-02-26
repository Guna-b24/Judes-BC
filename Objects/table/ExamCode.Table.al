table 71903 "Exam Code"
{
    Caption = 'Exam Code';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71907;
    LookupPageID = "Exam Code List";

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
            DataClassification = CustomerContent;
        }
        field(3; "Exam Order"; Integer)
        {
            Caption = 'Exam Order';
            BlankZero = true;
            ToolTip = 'Specifies the sequence in which the exam should be conducted or displayed.';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference ID for the exam code.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Exam Order")
        {
        }
    }

    fieldgroups
    {
    }

}

