table 72065 "Professional Tax Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Professional Tax Header';
    DataCaptionFields = "Effective Date", "Location Code", "Salary Plan Code", "Branch Code";
    DrillDownPageID = 72086;
    LookupPageID = 72086;

    fields
    {
        field(1; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(3; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(4; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
        }
        field(5; "Branch Name"; Text[50])
        {
            Caption = 'Branch Name';
        }
        field(6; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            OptionCaption = '1M,6M';
            OptionMembers = "1M","6M";
        }
        field(7; "Salary Starting Date"; Date)
        {
            Caption = 'Salary Starting Date';

            trigger OnValidate()
            begin
                "Salary Ending Date" := CalcDate(Format("Calculation Type") + '-1D', "Salary Starting Date");
            end;
        }
        field(8; "Salary Ending Date"; Date)
        {
            Caption = 'Salary Ending Date';
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
            ProfessionalTaxLine.Reset;
            ProfessionalTaxLine.SetRange("Effective Date", "Effective Date");
            ProfessionalTaxLine.SetRange("Location Code", "Location Code");
            ProfessionalTaxLine.SetRange("Salary Plan Code", "Salary Plan Code");
            ProfessionalTaxLine.SetRange("Branch Code", "Branch Code");
            if ProfessionalTaxLine.FindFirst then begin
                ProfessionalTaxLine.LockTable;
                ProfessionalTaxLine.DeleteAll;
            end;
        end;
    end;

    var
        ProfessionalTaxLine: Record "Professional Tax Line";
}

