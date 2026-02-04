table 72000 "HR Setup"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'HR Setup';
    DataCaptionFields = "Primary Key";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Indenting SNo"; Code[10])
        {
            Caption = 'Indenting SNo';
            TableRelation = "No. Series";
        }
        field(3; "ResumeDB SNo"; Code[10])
        {
            Caption = 'ResumeDB SNo';
            TableRelation = "No. Series";
        }
        field(4; "Appraisal SNo"; Code[20])
        {
            Caption = 'Appraisal SNo';
            TableRelation = "No. Series";
        }
        field(5; "File Directory"; Code[150])
        {
            Caption = 'File Directory';
        }
        field(6; Appraisal; DateFormula)
        {
            Caption = 'Appraisal';
        }
        field(7; "Send to HR Mail"; Text[30])
        {
            Caption = 'Send to HR Mail';
        }
        field(8; "Send to HR Mail CC"; Text[30])
        {
            Caption = 'Send to HR Mail CC';
        }
        field(9; "Training SNo"; Code[10])
        {
            Caption = 'Training SNo';
            TableRelation = "No. Series";
        }
        field(10; "Interview SNo"; Code[10])
        {
            Caption = 'Interview SNo';
            TableRelation = "No. Series";
        }
        field(11; "Selection SNo"; Code[10])
        {
            Caption = 'Selection SNo';
            TableRelation = "No. Series";
        }
        field(12; MsWordPath; Text[150])
        {
            Caption = 'MsWordPath';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

