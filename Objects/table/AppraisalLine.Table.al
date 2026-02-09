table 72022 "Appraisal Line"
{
    Caption = 'Appraisal Line';

    fields
    {
        field(1; "App No."; Code[20])
        {
            Caption = 'App No.';
            Editable = false;
            DataClassification = CustomerContent;

        }
        field(2; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = CustomerContent;
        }
        field(3; "Objectives Code"; Code[10])
        {
            Caption = 'Objectives Code';
            TableRelation = "Performance Appraisal";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if PerformanceAppraisal.Get("Objectives Code") then
                    "Objectives Description" := PerformanceAppraisal.Description;
            end;
        }
        field(4; "Objectives Description"; Text[30])
        {
            Caption = 'Objectives Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Self Rating %"; Decimal)
        {
            Caption = 'Self Rating %';
            DataClassification = CustomerContent;
        }
        field(6; Performance; Option)
        {
            Caption = 'Performance';
            OptionCaption = ' ,Bad,Average,Good,V.Good,Excellent';
            OptionMembers = " ",Bad,"Average",Good,"V.Good",Excellent;
            DataClassification = CustomerContent;
        }
        field(7; "Positive Attitude"; Text[30])
        {
            Caption = 'Positive Attitude';
            DataClassification = CustomerContent;
        }
        field(8; "Future Responsibility"; Text[30])
        {
            Caption = 'Future Responsibility';
            DataClassification = CustomerContent;
        }
        field(9; "Training Code"; Code[10])
        {
            Caption = 'Training Code';
            TableRelation = Training;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Training.Get("Training Code") then
                    "Training Description" := Training.Description;
            end;
        }
        field(10; "Training Description"; Text[30])
        {
            Caption = 'Training Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "App No.", "Employee No", "Objectives Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Training: Record Training;
        PerformanceAppraisal: Record "Performance Appraisal";
}

