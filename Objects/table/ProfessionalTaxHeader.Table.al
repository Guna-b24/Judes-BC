table 72065 "Professional Tax Header"
{
    Caption = 'Professional Tax Header';
    DataCaptionFields = "Effective Date", "Location Code", "Salary Plan Code", "Branch Code";
    // DrillDownPageID = 72086;
    LookupPageID = "Professional Tax List";

    fields
    {
        field(1; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date from which this professional tax setup becomes effective.';
        }

        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the payroll location to which this professional tax setup applies.';
        }

        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the salary plan associated with this professional tax setup.';
        }

        field(4; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the branch for which professional tax is configured.';
        }
        field(5; "Branch Name"; Text[50])
        {
            Caption = 'Branch Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the name of the branch.';
        }

        field(6; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            OptionCaption = '1M,6M';
            OptionMembers = "1M","6M";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether professional tax is calculated monthly (1M) or half-yearly (6M).';
        }

        field(7; "Salary Starting Date"; Date)
        {
            Caption = 'Salary Starting Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the starting date of the salary period for professional tax calculation.';

            trigger OnValidate()
            begin
                "Salary Ending Date" := CalcDate(Format("Calculation Type") + '-1D', "Salary Starting Date");
            end;
        }
        field(8; "Salary Ending Date"; Date)
        {
            Caption = 'Salary Ending Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the ending date of the salary period for professional tax calculation.';
        }
    }

    keys
    {
        key(Key1; "Branch Code", "Effective Date", "Location Code", "Salary Plan Code")
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
            ProfessionalTaxLine.Reset();
            ProfessionalTaxLine.SetRange("Effective Date", "Effective Date");
            ProfessionalTaxLine.SetRange("Location Code", "Location Code");
            ProfessionalTaxLine.SetRange("Salary Plan Code", "Salary Plan Code");
            ProfessionalTaxLine.SetRange("Branch Code", "Branch Code");
            if ProfessionalTaxLine.FindFirst() then begin
                ProfessionalTaxLine.LockTable();
                ProfessionalTaxLine.DeleteAll();
            end;
        end;
    end;

    var
        ProfessionalTaxLine: Record "Professional Tax Line";
}

