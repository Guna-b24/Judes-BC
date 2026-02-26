table 72021 "Appraisal Header"
{
    Caption = 'Appraisal Header';
    DataCaptionFields = "App No.", "Employee No", "Employee Name";
    // DrillDownPageID = 72033;
    LookupPageID = "Appraisal Header List";

    fields
    {
        field(1; "App No."; Code[20])
        {
            Caption = 'Appraisal No.';
            ToolTip = 'Specifies the unique appraisal document number.';
            DataClassification = CustomerContent;


            trigger OnValidate()
            begin
                if "App No." <> xRec."App No." then begin
                    HRSetup.Get();
                    NoSeriesMgt.TestManual(HRSetup."Appraisal SNo");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Employee No"; Code[20])
        {
            Caption = 'Employee No.';
            ToolTip = 'Specifies the employee for whom the appraisal is created.';
            DataClassification = CustomerContent;
            TableRelation = Employee;
            NotBlank = true;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Designation Code" := Employee."Designation Code";
                    "Designation Description" := Employee."Designation Code";
                    "Department Code" := Employee."Global Dimension 1 Code";

                    if Department.Get("Department Code") then
                        "Department Description" := Department.Name;
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            ToolTip = 'Specifies the full name of the employee.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Designation Code"; Text[30])
        {
            Caption = 'Designation Code';
            ToolTip = 'Specifies the designation code of the employee.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Designation Description"; Text[30])
        {
            Caption = 'Designation';
            ToolTip = 'Specifies the designation description of the employee.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            ToolTip = 'Specifies the department code of the employee.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Department Description"; Text[50])
        {
            Caption = 'Department';
            ToolTip = 'Specifies the department name of the employee.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Expected CTC"; Decimal)
        {
            Caption = 'Expected CTC';
            ToolTip = 'Specifies the expected cost to company amount.';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(9; "Expected CTC %"; Decimal)
        {
            Caption = 'Expected CTC %';
            ToolTip = 'Specifies the expected CTC increase percentage.';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if ("Expected CTC %" > 100) or ("Expected CTC %" < 0) then
                    Error('Expected CTC Percentage value range should be 0 to 100');
            end;
        }
        field(10; Year; code[20])
        {
            Caption = 'Year';
            ToolTip = 'Specifies the appraisal year.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Review Type"; Option)
        {
            Caption = 'Review Type';
            ToolTip = 'Specifies the frequency of the appraisal review.';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Weekly,Monthly,Bimonthly,Quarterly,Half Yearly,Annual';
            OptionMembers = " ",Weekly,Monthly,Bimonthly,Quarterly,"Half Yearly",Annualy;
        }
        field(12; "Review Status"; Option)
        {
            Caption = 'Review Status';
            ToolTip = 'Specifies the current status of the appraisal.';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Incomplete,Complete';
            OptionMembers = " ",Incomplete,Complete;
        }
        field(13; "Expected in"; Option)
        {
            Caption = 'Expected In';
            ToolTip = 'Specifies whether the expected CTC is entered as an amount or percentage.';
            DataClassification = CustomerContent;
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
            Caption = 'Posted';
            ToolTip = 'Specifies whether the appraisal has been posted.';
            DataClassification = CustomerContent;
        }
        field(15; Remarks; Text[30])
        {
            Caption = 'Remarks';
            ToolTip = 'Specifies additional remarks related to the appraisal.';
            DataClassification = CustomerContent;
        }
        field(16; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            ToolTip = 'Specifies the number series used for the appraisal document.';
            DataClassification = SystemMetadata;
        }
        field(17; "Appraisal Level upto"; Integer)
        {
            Caption = 'Appraisal Level Up To';
            ToolTip = 'Specifies the maximum appraisal approval level.';
            DataClassification = CustomerContent;
        }
        field(18; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const("Appraisal Header"),
                                                                     "No." = FIELD("App No.")));
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
            HRSetup.Get();
            HRSetup.TestField("Appraisal SNo");
            "No. Series" := HRSetup."Appraisal SNo";
            HRSetup."Appraisal SNo" := NoSeriesMgt.GetNextNo("App No.");
        end;

        PayrollYear.Reset();
        PayrollYear.SetRange("Year Type", PayrollYear."Year Type"::"Leave Year");
        PayrollYear.SetRange(Closed, false);
        if PayrollYear.FindFirst() then
            repeat
                Year := PayrollYear."Year Code";
            until PayrollYear.Next() = 0;
    end;

    var
        HRSetup: Record "HR Setup";
        Employee: Record Employee;
        Department: Record "Dimension Value";
        PayrollYear: Record "Payroll Year";
        NoSeriesMgt: Codeunit "No. Series";

    procedure AssistEdit(AppraisalHeader: Record "Appraisal Header"): Boolean
    begin
        AppraisalHeader := Rec;
        HRSetup.Get();
        HRSetup.TestField("Appraisal SNo");
        if NoSeriesMgt.LookupRelatedNoSeries(HRSetup."Appraisal SNo", "No. Series", "No. Series") then begin
            AppraisalHeader."App No." := NoSeriesMgt.GetNextNo(AppraisalHeader."No. Series");
            Rec := AppraisalHeader;
            exit(true);
        end;
    end;

}

