table 72009 Indenting
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Indenting';
    DataCaptionFields = No, "Indenting Date", Description;
    DrillDownPageID = 72010;
    LookupPageID = 72010;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Indenting SNo");
                    "No. Series" := '';
                end;

                TestField(No);
            end;
        }
        field(2; "Indenting Date"; Date)
        {
            Caption = 'Indenting Date';
            Editable = false;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee."First Name";
                    "Department Code" := Employee."Global Dimension 1 Code";
                end;
            end;
        }
        field(5; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(6; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(7; Remarks; Text[50])
        {
            Caption = 'Remarks';
            Enabled = false;
        }
        field(8; "Vacancy Status"; Option)
        {
            Caption = 'Vacancy Status';
            OptionCaption = 'Open,In Process,Hold,Close';
            OptionMembers = Open,"In Process",Hold,Close;
        }
        field(9; "Recruitment Status"; Option)
        {
            Caption = 'Recruitment Status';
            OptionCaption = 'Open,Close';
            OptionMembers = Open,Close;
        }
        field(10; "Advertisement Type"; Option)
        {
            Caption = 'Advertisement Type';
            OptionCaption = ' ,News Paper,Agency';
            OptionMembers = " ","News Paper",Agency;
        }
        field(11; "Agency Mail"; Boolean)
        {
            Caption = 'Agency Mail';
            Editable = false;
        }
        field(12; "Designation Code"; Code[10])
        {
            Caption = 'Designation Code';
            TableRelation = Designation;
        }
        field(13; "No Of Vacancy"; Integer)
        {
            Caption = 'No Of Vacancy';
        }
        field(14; "Age From"; Integer)
        {
            Caption = 'Age From';

            trigger OnValidate()
            begin
                if "Age From" <= 19 then
                    Error('Should not allow, the bellow Age of 19');
            end;
        }
        field(15; "Age To"; Integer)
        {
            Caption = 'Age To';

            trigger OnValidate()
            begin
                if "Age To" < "Age From" then
                    Error('Should be enter Greater than or equal to %1', "Age From");
            end;
        }
        field(16; "Qualification Code"; Code[50])
        {
            Caption = 'Qualification Code';
            TableRelation = Qualification;
            ValidateTableRelation = false;
        }
        field(17; "Experience(in Yrs)"; Decimal)
        {
            Caption = 'Experience(in Yrs)';
        }
        field(18; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(19; Preference; Text[100])
        {
            Caption = 'Preference';
        }
        field(20; "Willing to Work"; Option)
        {
            Caption = 'Willing to Work';
            OptionCaption = 'General,I Shift,II Shift,III Shift';
            OptionMembers = General,"I Shift","II Shift","III Shift";
        }
        field(21; "On Board"; Date)
        {
            Caption = 'On Board';
        }
        field(22; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(23; Approve; Boolean)
        {
            Caption = 'Approve';
            Editable = false;
        }
        field(24; "Newspaper Mail"; Boolean)
        {
            Caption = 'Newspaper Mail';
            Editable = false;
        }
        field(25; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //Postcode.LookUpPostCode(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //Postcode.ValidatePostCode(City,"Post Code");
            end;
        }
        field(26; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //Postcode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //Postcode.ValidateCity(City,"Post Code");
            end;
        }
        field(27; Comment; Boolean)
        {
            Caption = 'Comment';
        }
        field(28; Skills; Code[250])
        {
            Caption = 'Skills';
            TableRelation = Skill;
            ValidateTableRelation = false;
        }
        field(29; Certifications; Code[250])
        {
            Caption = 'Certifications';
            TableRelation = Certification;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Approve then
            Error('Should not delete the record');
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Indenting SNo");
            NoSeriesMgt.InitSeries(HRSetup."Indenting SNo", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Vacancy Status" := "Vacancy Status"::Open;
        "Indenting Date" := Today;
    end;

    var
        HRSetup: Record "HR Setup";
        Employee: Record Employee;
        Indenting: Record Indenting;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Postcode: Record "Post Code";

    [Scope('Internal')]
    procedure AssistEdit(Indenting: Record Indenting): Boolean
    begin
        with Indenting do begin
            Indenting := Rec;
            HRSetup.Get;
            HRSetup.TestField("Indenting SNo");
            if NoSeriesMgt.SelectSeries(HRSetup."Indenting SNo", "No. Series", "No. Series") then begin
                HRSetup.Get;
                HRSetup.TestField("Indenting SNo");
                NoSeriesMgt.SetSeries(No);
                Rec := Indenting;
                exit(true);
            end;
        end;
    end;
}

