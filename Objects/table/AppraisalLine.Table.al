table 72022 "Appraisal Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Appraisal Line';

    fields
    {
        field(1; "App No."; Code[20])
        {
            Caption = 'App No.';
            Editable = false;
        }
        field(2; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
        }
        field(3; "Objectives Code"; Code[10])
        {
            Caption = 'Objectives Code';
            TableRelation = "Performance Appraisal";

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
        }
        field(5; "Self Rating %"; Decimal)
        {
            Caption = 'Self Rating %';
        }
        field(6; Performance; Option)
        {
            Caption = 'Performance';
            OptionCaption = ' ,Bad,Average,Good,V.Good,Excellent';
            OptionMembers = " ",Bad,"Average",Good,"V.Good",Excellent;
        }
        field(7; "Positive Attitude"; Text[30])
        {
            Caption = 'Positive Attitude';
        }
        field(8; "Future Responsibility"; Text[30])
        {
            Caption = 'Future Responsibility';
        }
        field(9; "Training Code"; Code[10])
        {
            Caption = 'Training Code';
            TableRelation = Training;

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

