table 72091 "Revision Header"
{

    Caption = 'Revision Header';
    DataClassification = CustomerContent;
    // DrillDownPageID = 72129;
    LookupPageID = "Revision List";

    fields
    {
        field(1; "Pay Revision Id"; Code[20])
        {
            Caption = 'Pay Revision Id';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique identifier for the pay revision.';

            trigger OnValidate()
            begin
                if "Pay Revision Id" <> xRec."Pay Revision Id" then begin
                    HRPayrollSetup.Get(UserId);
                    LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
                    NoSeriesMgt.TestManual(LocationHRPayrollSetup."Pay Revision No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Pay Revision Processing Date"; Date)
        {
            Caption = 'Pay Revision Processing Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date on which the pay revision is processed.';
        }

        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll location for this revision.';
        }

        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary plan applicable for this revision.';
        }

        field(5; "New Effective Date"; Date)
        {
            Caption = 'New Effective Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date from which the revised salary becomes effective.';
        }

        field(6; "Revision Amount"; Decimal)
        {
            Caption = 'Revision Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fixed revision amount if Based on is set to Amount.';
        }

        field(7; "Revision Percent"; Decimal)
        {
            Caption = 'Revision Percent';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the revision percentage if Based on is set to Percent.';
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used to generate the pay revision ID.';
        }

        field(9; "Based on"; Option)
        {
            Caption = 'Based on';
            OptionCaption = 'Amount,Percent';
            OptionMembers = Amount,Percent;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the revision is based on a fixed amount or percentage.';
        }

        field(10; "Arrears Starting Date"; Date)
        {
            Caption = 'Arrears Starting Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the starting date for arrears calculation.';
        }

        field(11; "Arrears Ending Date"; Date)
        {
            Caption = 'Arrears Ending Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the ending date for arrears calculation.';
        }

        field(12; "Arrears Generated"; Boolean)
        {
            Caption = 'Arrears Generated';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether arrears have been generated for this revision.';
        }

        field(13; "VDA Increase Amount"; Decimal)
        {
            Caption = 'VDA Increase Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the increase amount applicable for VDA.';
        }

        field(14; "VDA Eligible Max Amount"; Decimal)
        {
            Caption = 'VDA Eligible Max Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the maximum eligible amount for VDA calculation.';
        }
    }

    keys
    {
        key(Key1; "Pay Revision Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Confirm('Are Sure to Delete the Records <Yes/No> Delete All Lines..!!') then begin
            RevisionLine.Reset();
            RevisionLine.SetRange("Pay Revision Id", "Pay Revision Id");
            if RevisionLine.FindFirst() then begin
                RevisionLine.LockTable();
                RevisionLine.DeleteAll();
            end;
        end;
    end;

    trigger OnInsert()
    begin
        if "Pay Revision Id" = '' then begin
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Pay Revision No.");
            "No. Series" := LocationHRPayrollSetup."Pay Revision No.";
            "Pay Revision Id" := NoSeriesMgt.GetNextNo("No. Series");

        end;

        if HRPayrollSetup.Get(UserId) then begin
            "Location Code" := HRPayrollSetup."Location Code";
            "Salary Plan Code" := HRPayrollSetup."Salary Plan Code";
        end;

        "Pay Revision Processing Date" := Today;
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";

        RevisionLine: Record "Revision Line";
        NoSeriesMgt: Codeunit "No. Series";


    procedure AssistEdit(OldRevisionHeader: Record "Revision Header"): Boolean
    var
        RevisionHeader: Record "Revision Header";
    begin

        RevisionHeader := Rec;
        HRPayrollSetup.Get(UserId);
        LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
        LocationHRPayrollSetup.TestField("Pay Revision No.");
        if NoSeriesMgt.LookupRelatedNoSeries(LocationHRPayrollSetup."Pay Revision No.", OldRevisionHeader."No. Series", "No. Series") then begin
            RevisionHeader."Pay Revision Id" := NoSeriesMgt.GetNextNo(RevisionHeader."No. Series");

            Rec := RevisionHeader;
            exit(true);
        end;
    end;

}

