table 72023 Reviewer
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Reviewer';
    DataCaptionFields = "App No.", "App EmpNo.", "Employee No";
    DrillDownPageID = 72034;
    LookupPageID = 72034;

    fields
    {
        field(1; "App No."; Code[20])
        {
            Caption = 'App No.';
        }
        field(2; "App EmpNo."; Code[20])
        {
            Caption = 'App EmpNo.';
        }
        field(3; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Designation Code" := Employee."Designation Code";
                    "Designation Description" := Employee."Job Title";
                    "Department Code" := Employee."Global Dimension 1 Code";

                    if Department.Get("Department Code") then
                        "Department Description" := Department.Name;
                end;
            end;
        }
        field(4; "Evaluation Code"; Code[10])
        {
            Caption = 'Evaluation Code';
            Editable = false;

            trigger OnValidate()
            begin
                if PerformanceAppraisal.Get("Evaluation Code") then
                    "Evaluation Description" := PerformanceAppraisal.Description;
            end;
        }
        field(5; "Evaluation Description"; Text[30])
        {
            Caption = 'Evaluation Description';
        }
        field(6; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(7; "Designation Code"; Code[10])
        {
            Caption = 'Designation Code';
        }
        field(8; "Designation Description"; Text[30])
        {
            Caption = 'Designation Description';
            Editable = false;
        }
        field(9; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
        }
        field(10; "Department Description"; Text[30])
        {
            Caption = 'Department Description';
            Editable = false;
        }
        field(11; "Result of Performance"; Option)
        {
            Caption = 'Result of Performance';
            OptionCaption = ' ,Bad,Average,Good,V.Good,Excellent';
            OptionMembers = " ",Bad,"Average",Good,"V.Good",Excellent;
        }
        field(12; "Evaluation Date"; Date)
        {
            Caption = 'Evaluation Date';
        }
        field(13; "Evaluation Time"; Time)
        {
            Caption = 'Evaluation Time';
        }
        field(14; "Evaluation Type"; Option)
        {
            Caption = 'Evaluation Type';
            OptionCaption = ' ,I Round,II Round,III Round,IV Round';
            OptionMembers = " ","I Round","II Round","III Round","IV Round";
        }
        field(15; "Evaluator Rating %"; Code[10])
        {
            Caption = 'Evaluator Rating %';
            TableRelation = "Rating Value";
        }
        field(16; Feedback; Text[30])
        {
            Caption = 'Feedback';
        }
        field(17; "Objectives Code"; Code[10])
        {
            Caption = 'Objectives Code';
        }
    }

    keys
    {
        key(Key1; "App No.", "App EmpNo.", "Employee No", "Evaluation Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
        Department: Record "Dimension Value";
        PerformanceAppraisal: Record "Performance Appraisal";
}

