table 72014 "Selection Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Selection Header';
    DataCaptionFields = "No.";
    DrillDownPageID = 72022;
    LookupPageID = 72022;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Selection SNo");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Indenting No"; Code[20])
        {
            Caption = 'Indenting No';
            TableRelation = Indenting;

            trigger OnLookup()
            begin
                Indenting.Reset;
                Indenting.SetFilter(Approve, '%1', true);
                Indenting.SetFilter("Vacancy Status", '<>%1', Indenting."Vacancy Status"::Close);
                if Indenting.FindFirst then;
                if PAGE.RunModal(72012, Indenting) = ACTION::LookupOK then begin
                    "Indenting No" := Indenting.No;
                    "Employee No." := Indenting."Employee No.";
                    "Employee Name" := Indenting."Employee Name";
                    "Department Code" := Indenting."Department Code";
                    "Advertisement Type" := Indenting."Advertisement Type";
                    "Required Position" := Indenting."Designation Code";
                    "No Of Vacancy" := Indenting."No Of Vacancy";
                    "Age From" := Indenting."Age From";
                    "Age To" := Indenting."Age To";
                    "Qualification Code" := Indenting."Qualification Code";
                    "Experience(in Yrs)" := Indenting."Experience(in Yrs)";
                    Gender := Indenting.Gender;
                    "Post Code" := Indenting."Post Code";
                    City := Indenting.City;
                    Skills := Indenting.Skills;
                    Certifications := Indenting.Certifications;
                end;
            end;
        }
        field(3; "Indenting Date"; Date)
        {
            Caption = 'Indenting Date';
            Editable = false;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Employee No."; Code[30])
        {
            Caption = 'Employee No.';
            Editable = false;
            Enabled = true;
        }
        field(6; "Employee Name"; Text[30])
        {
            Caption = 'Employee Name';
            Editable = false;
            Enabled = true;
        }
        field(7; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            Editable = false;
            Enabled = true;
        }
        field(8; Remarks; Text[50])
        {
            Caption = 'Remarks';
            Enabled = false;
        }
        field(9; "Vacancy Status"; Option)
        {
            Caption = 'Vacancy Status';
            OptionCaption = 'Open,In Process,Hold,Close';
            OptionMembers = Open,"In Process",Hold,Close;
        }
        field(10; "Recruitment Status"; Option)
        {
            Caption = 'Recruitment Status';
            OptionCaption = 'Open,Close';
            OptionMembers = Open,Close;
        }
        field(11; "Advertisement Type"; Option)
        {
            Caption = 'Advertisement Type';
            OptionCaption = ' ,News Paper,Agency';
            OptionMembers = " ","News Paper",Agency;
        }
        field(12; "Agency Mail"; Boolean)
        {
            Caption = 'Agency Mail';
            Editable = false;
        }
        field(13; "Required Position"; Code[30])
        {
            Caption = 'Required Position';
            Editable = false;
            Enabled = true;
        }
        field(14; "No Of Vacancy"; Integer)
        {
            Caption = 'No Of Vacancy';
            Editable = false;
        }
        field(15; "Age From"; Integer)
        {
            Caption = 'Age From';
            Editable = false;
        }
        field(16; "Age To"; Integer)
        {
            Caption = 'Age To';
            Editable = false;
        }
        field(17; "Qualification Code"; Code[20])
        {
            Caption = 'Qualification Code';
            Editable = false;
        }
        field(18; "Experience(in Yrs)"; Decimal)
        {
            Caption = 'Experience(in Yrs)';
            Editable = false;
        }
        field(19; Gender; Option)
        {
            Caption = 'Gender';
            Editable = false;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(20; Preference; Text[40])
        {
            Caption = 'Preference';
            Editable = false;
        }
        field(21; "Willing to Work"; Option)
        {
            Caption = 'Willing to Work';
            Editable = false;
            OptionCaption = ' ,General,Day,Night';
            OptionMembers = " ",General,Day,Night;
        }
        field(22; "Date of Required"; Date)
        {
            Caption = 'Date of Required';
        }
        field(23; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(24; Approve; Boolean)
        {
            Caption = 'Approve';
            Editable = false;
        }
        field(25; Skills; Text[250])
        {
            Caption = 'Skills';
            Editable = false;
        }
        field(26; Certifications; Text[250])
        {
            Caption = 'Certifications';
            Editable = false;
        }
        field(27; Location; Boolean)
        {
            Caption = 'Location';
        }
        field(28; Qualification; Boolean)
        {
            Caption = 'Qualification';
        }
        field(29; Skill; Boolean)
        {
            Caption = 'Skill';
        }
        field(30; Certification; Boolean)
        {
            Caption = 'Certification';
        }
        field(31; Age; Boolean)
        {
            Caption = 'Age';
        }
        field(32; Experience; Boolean)
        {
            Caption = 'Experience';
        }
        field(33; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            Editable = false;
            TableRelation = "Post Code";

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code");
            end;
        }
        field(34; City; Text[30])
        {
            Caption = 'City';
            Editable = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(35; Comment; Boolean)
        {
            CalcFormula = Exist ("Human Resource Comment Line" WHERE ("Table Name" = CONST ("11"),
                                                                     "No." = FIELD ("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Selection SNo");
            NoSeriesMgt.InitSeries(HRSetup."Selection SNo", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Indenting: Record Indenting;
        PostCode: Record "Post Code";

    [Scope('Internal')]
    procedure AssistEdit(SelectionHeader: Record "Selection Header"): Boolean
    begin
        with SelectionHeader do begin
            SelectionHeader := Rec;
            HRSetup.Get;
            HRSetup.TestField("Selection SNo");
            if NoSeriesMgt.SelectSeries(HRSetup."Selection SNo", "No. Series", "No. Series") then begin
                HRSetup.Get;
                HRSetup.TestField("Selection SNo");
                NoSeriesMgt.SetSeries("No.");
                Rec := SelectionHeader;
                exit(true);
            end;
        end;
    end;
}

