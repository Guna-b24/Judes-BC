table 72021 "Appraisal Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Appraisal Header';
    DataCaptionFields = "App No.", "Employee No", "Employee Name";
    DrillDownPageID = 72033;
    LookupPageID = 72033;

    fields
    {
        field(1; "App No."; Code[20])
        {
            Caption = 'App No.';

            trigger OnValidate()
            begin
                if "App No." <> xRec."App No." then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Appraisal SNo");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            NotBlank = true;
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
        field(3; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(4; "Designation Code"; Code[10])
        {
            Caption = 'Designation Code';
            Editable = false;
        }
        field(5; "Designation Description"; Text[30])
        {
            Caption = 'Designation Description';
            Editable = false;
        }
        field(6; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
            Editable = false;
        }
        field(7; "Department Description"; Text[30])
        {
            Caption = 'Department Description';
            Editable = false;
        }
        field(8; "Expected CTC"; Decimal)
        {
            Caption = 'Expected CTC';
            DecimalPlaces = 2 : 2;
        }
        field(9; "Expected CTC %"; Decimal)
        {
            Caption = 'Expected CTC %';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if ("Expected CTC %" > 100) or ("Expected CTC %" < 0) then
                    Error('Expected CTC Percentage value range should be 0 to 100');
            end;
        }
        field(10; Year; Text[10])
        {
            Caption = 'Year';
            Editable = false;
        }
        field(11; "Review Type"; Option)
        {
            Caption = 'Review Type';
            OptionCaption = ' ,Weekly,Monthly,Bimonthly,Quarterly,Half Yearly,Annualy';
            OptionMembers = " ",Weekly,Monthly,Bimonthly,Quarterly,"Half Yearly",Annualy;
        }
        field(12; "Review Status"; Option)
        {
            Caption = 'Review Status';
            OptionCaption = ' ,Incomplete,Complete';
            OptionMembers = " ",Incomplete,Complete;
        }
        field(13; "Expected in"; Option)
        {
            Caption = 'Expected in';
            OptionCaption = ' ,Amount,Percentage';
            OptionMembers = " ",Amount,Percentage;

            trigger OnValidate()
            begin
                if "Expected in" = "Expected in"::Amount then
                    "Expected CTC %" := 0
                else
                    if "Expected in" = "Expected in"::Percentage then
                        "Expected CTC" := 0;
            end;
        }
        field(14; Post; Boolean)
        {
            Caption = 'Post';
        }
        field(15; Remarks; Text[30])
        {
            Caption = 'Remarks';
        }
        field(16; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(17; "Appraisal Level upto"; Integer)
        {
            Caption = 'Appraisal Level upto';
        }
        field(18; Comment; Boolean)
        {
            CalcFormula = Exist ("Human Resource Comment Line" WHERE ("Table Name" = CONST ("9"),
                                                                     "No." = FIELD ("App No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "App No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "App No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Appraisal SNo");
            NoSeriesMgt.InitSeries(HRSetup."Appraisal SNo", xRec."No. Series", 0D, "App No.", "No. Series");
        end;

        PayrollYear.Reset;
        PayrollYear.SetRange("Year Type", PayrollYear."Year Type"::"Leave Year");
        PayrollYear.SetRange(Closed, false);
        if PayrollYear.FindFirst then
            repeat
                Year := PayrollYear."Year Code";
            until PayrollYear.Next = 0;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record Employee;
        Department: Record "Dimension Value";
        PayrollYear: Record "Payroll Year";

    [Scope('Internal')]
    procedure AssistEdit(AppraisalHeader: Record "Appraisal Header"): Boolean
    begin
        with AppraisalHeader do begin
            AppraisalHeader := Rec;
            HRSetup.Get;
            HRSetup.TestField("Appraisal SNo");
            if NoSeriesMgt.SelectSeries(HRSetup."Appraisal SNo", "No. Series", "No. Series") then begin
                HRSetup.Get;
                HRSetup.TestField("Appraisal SNo");
                NoSeriesMgt.SetSeries("App No.");
                Rec := AppraisalHeader;
                exit(true);
            end;
        end;
    end;
}

