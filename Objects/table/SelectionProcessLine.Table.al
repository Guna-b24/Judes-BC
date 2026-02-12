table 71014 "Selection Process Line"
{

    Caption = 'Selection Process Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Selection No."; Code[10])
        {
            Caption = 'Selection No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the selection document number.';
        }

        field(2; "Application No"; Code[20])
        {
            Caption = 'Application No.';
            TableRelation = Application;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the application number related to this selection line.';

            trigger OnValidate()
            begin
                if Application.Get("Application No") then begin
                    Name := Application."Name of the pupil";
                    Gender := Application."Applicant Gender";
                end;
            end;
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the name of the applicant.';
        }

        field(4; Gender; Option)
        {
            Caption = 'Gender';
            OptionMembers = " ",Male,Female;
            OptionCaption = ' ,Male,Female';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the gender of the applicant.';
        }
        field(5; "Evaluation Total"; Decimal)
        {
            Caption = 'Evaluation Total';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total evaluation score for the applicant.';
        }

        field(6; Rank; Integer)
        {
            Caption = 'Rank';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the rank assigned to the applicant.';
        }

        field(7; Select; Boolean)
        {
            Caption = 'Select';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the applicant is selected.';
        }
    }

    keys
    {
        key(Key1; "Selection No.", "Application No")
        {
            Clustered = true;
        }
        key(Key2; Rank)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Application: Record Application;
}

