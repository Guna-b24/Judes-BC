table 71904 "Academic Year"
{
    Caption = 'Academic Year';
    // DrillDownPageID = 71908;
    // LookupPageID = 71908;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the Code of the academic year.';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the academic year.';
            DataClassification = CustomerContent;
        }
        field(3; Sequence; Integer)
        {
            AutoIncrement = true;
            Caption = 'Sequence';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the Sequence of the academic year.';
        }
        field(4; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies whether the academic year is closed.';
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the start date of the academic year.';
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the end date of the academic year.';
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the Portal ID of the academic year.';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Sequence)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin

        if Closed then
            Error(CannotModifyErr);
    end;

    var
        CannotModifyErr: Label 'Cannot be modified';
}

