table 72019 Interviewer
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Interviewer';
    DataCaptionFields = "Interviewer No";
    DrillDownPageID = 72027;
    LookupPageID = 72027;

    fields
    {
        field(1; "Interviewer No"; Code[20])
        {
            Caption = 'Interviewer No';
        }
        field(2; "Interview Round Code"; Code[10])
        {
            Caption = 'Interview Round Code';
        }
        field(3; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
        }
        field(4; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
        }
        field(5; "Designation Code"; Code[10])
        {
            Caption = 'Designation Code';
        }
        field(6; "Designation Description"; Text[30])
        {
            Caption = 'Designation Description';
        }
        field(7; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
        }
        field(8; "Department Description"; Text[30])
        {
            Caption = 'Department Description';
        }
        field(9; Feedback; Text[30])
        {
            Caption = 'Feedback';
        }
        field(10; "Rating %"; Decimal)
        {
            Caption = 'Rating %';
        }
    }

    keys
    {
        key(Key1; "Interviewer No", "Interview Round Code", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

